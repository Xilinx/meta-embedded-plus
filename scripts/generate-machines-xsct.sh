#! /bin/bash -e

XSCT_VERSION=2024.2

### The following table controls the automatic generated of the machine .conf files (lines start with #M#)
### Machine               Board Template                     OTHER
#M# emb-plus-ve2302       versal-emb-plus-ve2302-reva        

this=$(realpath $0)

if [ $# -lt 2 ]; then
  echo "$0: <conf_path> <machine_url_index> [machine]" >&2
  exit 1
fi

gmc=`which gen-machineconf`
if [ -z "${gmc}" ]; then
  echo "ERROR: This script must be run in a configured Yocto Project build with gen-machineconf in the environment." >&2
  exit 1
fi

conf_path=$(realpath $1)
if [ ! -d ${conf_path} ]; then
  mkdir -p ${conf_path}
fi


mach_index=$(realpath $2)
count=0
while read mach_id mach_url; do
  if [ ${mach_id} = '#' ]; then
      continue
  fi

  # We need a rename on this to avoid a conflict
  case ${mach_id} in
    versal-net-generic) mach_id="generic-versal-net" ;;
    embedded-plus-ve2302) mach_id="emb-plus-ve2302" ;;
  esac

  MACHINE_ID[$count]=${mach_id}
  MACHINE_URL[$count]=${mach_url}

  count=$(expr $count + 1)
done < ${mach_index}


# Load in the arrays from this script
count=0
while read marker machine board other; do
  if [ "${marker}" != "#M#" ]; then
      continue
  fi

  MACHINES[$count]=${machine}
  BOARDS[$count]=${board}
  for mach in ${!MACHINE_ID[@]}; do
    if [ ${MACHINE_ID[${mach}]} = ${machine} ]; then
      URLS[$count]=${MACHINE_URL[${mach}]}
      break
    fi
  done
  if [ -z "${URLS[$count]}" ]; then
    echo "ERROR: Unable to find ${machine} in ${mach_index}" >&2
    exit 1
  fi
  OTHER[$count]=${other}

  count=$(expr $count + 1)
done < ${this}


for mach in ${!MACHINES[@]}; do
  if [ -n "$3" -a "$3" != "${MACHINES[${mach}]}" ]; then
    continue
  fi

  echo "Machine: ${MACHINES[${mach}]}"
  echo "Board:   ${BOARDS[${mach}]}"
  echo "URL:     ${URLS[${mach}]}"
  echo
  set -x
  rm -rf output
  gen-machineconf parse-xsa --hw-description ${URLS[${mach}]} -c ${conf_path} --machine-name ${MACHINES[${mach}]} --add-config CONFIG_SUBSYSTEM_MACHINE_NAME=\"${BOARDS[${mach}]}\"
  set +x

  ######### Post gen-machineconf changes
  #
  # Since this is a version specific XSA, set the version of XSCT to use.
  if [ -n "${OTHER[${mach}]}" ]; then
    sed -i ${conf_path}/machine/${MACHINES[${mach}]}.conf -e 's,\(# Required generic machine inclusion\),'"${OTHER[${mach}]}"'\n\1,'
  fi

  case ${MACHINES[${mach}]} in
    emb-plus-ve2302)
      sed -i ${conf_path}/machine/${MACHINES[${mach}]}.conf \
        -e 's,YAML_CONSOLE_DEVICE_CONFIG:pn-device-tree ?= "blp_cips_pspmc_0_psv_sbsauart_0",YAML_CONSOLE_DEVICE_CONFIG:pn-device-tree ?= "blp_cips_pspmc_0_psv_sbsauart_1",' \
        -e 's,YAML_MAIN_MEMORY_CONFIG:pn-device-tree ?= "blp_axi_noc_mc_1x_C0_DDR_LOW0",YAML_MAIN_MEMORY_CONFIG:pn-device-tree ?= "C0_DDR_LOW0",' \
        -e 's,ATF_CONSOLE ?= "pl011",ATF_CONSOLE ?= "pl011_1",'
      ;;
  esac
done
