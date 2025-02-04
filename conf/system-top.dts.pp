# 0 "/scratch/jenkins-sdt_artifactory_upload_2024.2-52/build_cfg/hw-description/emb-plus-ve2302-sdt_2024.2_1111_2/system-top.dts"
# 0 "<built-in>"
# 0 "<command-line>"
# 1 "/scratch/jenkins-sdt_artifactory_upload_2024.2-52/build_cfg/hw-description/emb-plus-ve2302-sdt_2024.2_1111_2/system-top.dts"
/dts-v1/;
# 1 "/scratch/jenkins-sdt_artifactory_upload_2024.2-52/build_cfg/hw-description/emb-plus-ve2302-sdt_2024.2_1111_2/versal.dtsi" 1
# 11 "/scratch/jenkins-sdt_artifactory_upload_2024.2-52/build_cfg/hw-description/emb-plus-ve2302-sdt_2024.2_1111_2/versal.dtsi"
/ {
 compatible = "xlnx,versal";
 #address-cells = <2>;
 #size-cells = <2>;
 model = "Xilinx Versal";

 options {
  u-boot {
   compatible = "u-boot,config";
   bootscr-address = /bits/ 64 <0x20000000>;
  };
 };

 cpus_a72: cpus-a72@0 {
  #address-cells = <1>;
  #size-cells = <0>;

  psv_cortexa72_0: cpu@0 {
   compatible = "arm,cortex-a72", "arm,armv8";
   device_type = "cpu";
   enable-method = "psci";
   operating-points-v2 = <&cpu_opp_table>;
   reg = <0>;
   cpu-idle-states = <&CPU_SLEEP_0>;
   power-domains = <&versal_firmware 0x18110003>;
  };

  psv_cortexa72_1: cpu@1 {
   compatible = "arm,cortex-a72", "arm,armv8";
   device_type = "cpu";
   enable-method = "psci";
   operating-points-v2 = <&cpu_opp_table>;
   reg = <1>;
   cpu-idle-states = <&CPU_SLEEP_0>;
   power-domains = <&versal_firmware 0x18110004>;
  };

  idle-states {
   entry-method = "psci";

   CPU_SLEEP_0: cpu-sleep-0 {
    compatible = "arm,idle-state";
    arm,psci-suspend-param = <0x40000000>;
    local-timer-stop;
    entry-latency-us = <300>;
    exit-latency-us = <600>;
    min-residency-us = <10000>;
   };
  };
 };

 cpus_microblaze_0: cpus_microblaze@0 {
  #address-cells = <1>;
  #size-cells = <0>;
  psv_pmc_0: cpu@0 {
   compatible = "pmc-microblaze";
   device_type = "cpu";
   reg = <0x0>;
   operating-points-v2 = <&cpu_opp_table>;
  };
 };

 cpus_microblaze_1: cpus_microblaze@1 {
  #address-cells = <1>;
  #size-cells = <0>;
  psv_psm_0: cpu@0 {
   compatible = "psm-microblaze";
   device_type = "cpu";
   reg = <0x1>;
   operating-points-v2 = <&cpu_opp_table>;
  };

 };

 cpus_r5_0: cpus-r5@0 {
  #address-cells = <1>;
  #size-cells = <0>;
  psv_cortexr5_0: cpu@0 {
   compatible = "arm,cortex-r5";
   device_type = "cpu";
   reg = <0x0>;
   operating-points-v2 = <&cpu_opp_table>;
   power-domains = <&versal_firmware 0x18110005>;
  };
 };

 cpus_r5_1: cpus-r5@1 {
  #address-cells = <1>;
  #size-cells = <0>;
  psv_cortexr5_1: cpu@1 {
   compatible = "arm,cortex-r5";
   device_type = "cpu";
   reg = <0x1>;
   operating-points-v2 = <&cpu_opp_table>;
   power-domains = <&versal_firmware 0x18110006>;
  };
 };

 cpu_opp_table: opp-table-cpu {
  compatible = "operating-points-v2";
  opp-shared;
  opp00 {
   opp-hz = /bits/ 64 <1199999988>;
   opp-microvolt = <1000000>;
   clock-latency-ns = <500000>;
  };
  opp01 {
   opp-hz = /bits/ 64 <599999994>;
   opp-microvolt = <1000000>;
   clock-latency-ns = <500000>;
  };
  opp02 {
   opp-hz = /bits/ 64 <399999996>;
   opp-microvolt = <1000000>;
   clock-latency-ns = <500000>;
  };
  opp03 {
   opp-hz = /bits/ 64 <299999997>;
   opp-microvolt = <1000000>;
   clock-latency-ns = <500000>;
  };
 };

 dcc: dcc {
  compatible = "arm,dcc";
  status = "disabled";
  bootph-all;
 };

 fpga: fpga-region {
  compatible = "fpga-region";
  fpga-mgr = <&versal_fpga>;
  #address-cells = <2>;
  #size-cells = <2>;
 };

 psci: psci {
  compatible = "arm,psci-0.2";
  method = "smc";
 };

 pmu {
  compatible = "arm,armv8-pmuv3";
  interrupt-parent = <&imux>;
  interrupts = <1 7 0x304>;
 };

 timer: timer {
  compatible = "arm,armv8-timer";
  interrupt-parent = <&imux>;
  interrupts = <1 13 4>,
               <1 14 4>,
               <1 11 4>,
               <1 10 4>;
 };

 versal_fpga: versal-fpga {
  compatible = "xlnx,versal-fpga";
 };

 sensor0: versal-thermal-sensor {
  compatible = "xlnx,versal-thermal";
  #thermal-sensor-cells = <0>;
  io-channels = <&sysmon0>;
  io-channel-names = "sysmon-temp-channel";
 };

 thermal-zones {
  versal_thermal: versal-thermal {
   polling-delay-passive = <250>;
   polling-delay = <1000>;
   thermal-sensors = <&sensor0>;

   trips {
    temp_alert: temp-alert {
     temperature = <70000>;
     hysteresis = <0>;
     type = "passive";
    };

    ot_crit: ot-crit {
     temperature = <125000>;
     hysteresis = <0>;
     type = "critical";
    };
   };

  };
 };

 amba_apu: apu-bus {
  compatible = "simple-bus";
  #address-cells = <2>;
  #size-cells = <2>;
  ranges;
  interrupt-parent = <&gic_a72>;
  bootph-all;

  gic_a72: interrupt-controller@f9000000 {
   compatible = "arm,gic-v3";
   #interrupt-cells = <3>;
   #address-cells = <2>;
   #size-cells = <2>;
   ranges;
   reg = <0 0xf9000000 0 0x80000>,
         <0 0xf9080000 0 0x80000>;
   interrupt-controller;
   interrupt-parent = <&gic_a72>;
   interrupts = <1 9 4>;
   status = "disabled";

   gic_its: msi-controller@f9020000 {
    compatible = "arm,gic-v3-its";
    status = "disabled";
    msi-controller;
    #msi-cells = <1>;
    reg = <0 0xf9020000 0 0x20000>;
   };
  };
 };

 amba_rpu: rpu-bus {
  compatible = "indirect-bus";
  #address-cells = <0x2>;
  #size-cells = <0x2>;
  ranges;
  interrupt-parent = <&gic_r5>;
  bootph-all;

  gic_r5: interrupt-controller@f9000000 {
   compatible = "arm,pl390";
   #interrupt-cells = <3>;
   interrupt-controller;
   status = "disabled";
   reg = <0x0 0xf9000000 0x0 0x1000 0x0 0xf9001000 0x0 0x1000>;
  };
 };

 amba: axi {
  compatible = "simple-bus";
  #address-cells = <2>;
  #size-cells = <2>;
  ranges;
  interrupt-parent = <&imux>;
  bootph-all;


  imux: interrupt-multiplex {
   compatible = "interrupt-multiplex";
   #address-cells = <0x0>;
   #interrupt-cells = <3>;
   interrupt-controller;
   interrupt-parent = <&gic_a72>, <&gic_r5>;

   interrupt-map-mask = <0x0 0xffff 0x0>;


   interrupt-map = <0x0 0x14 0x0 &gic_a72 0x0 0x14 0x1>,
    <0x0 0x15 0x0 &gic_a72 0x0 0x15 0x1>,
    <0x0 0x6a 0x0 &gic_a72 0x0 0x6a 0x4>,
    <0x0 0x3c 0x0 &gic_a72 0x0 0x3c 0x4>,
    <0x0 0x3d 0x0 &gic_a72 0x0 0x3d 0x4>,
    <0x0 0x3e 0x0 &gic_a72 0x0 0x3e 0x4>,
    <0x0 0x3f 0x0 &gic_a72 0x0 0x3f 0x4>,
    <0x0 0x40 0x0 &gic_a72 0x0 0x40 0x4>,
    <0x0 0x41 0x0 &gic_a72 0x0 0x41 0x4>,
    <0x0 0x42 0x0 &gic_a72 0x0 0x42 0x4>,
    <0x0 0x43 0x0 &gic_a72 0x0 0x43 0x4>,
    <0x0 0x38 0x0 &gic_a72 0x0 0x38 0x4>,
    <0x0 0x3a 0x0 &gic_a72 0x0 0x3a 0x4>,
    <0x0 0xd 0x0 &gic_a72 0x0 0xd 0x4>,
    <0x0 0x7a 0x0 &gic_a72 0x0 0x7a 0x4>,
    <0x0 0xe 0x0 &gic_a72 0x0 0xe 0x4>,
    <0x0 0xf 0x0 &gic_a72 0x0 0xf 0x4>,
    <0x0 0x8e 0x0 &gic_a72 0x0 0x8e 0x4>,
    <0x0 0x8f 0x0 &gic_a72 0x0 0x8f 0x4>,
    <0x0 0x7e 0x0 &gic_a72 0x0 0x7e 0x4>,
    <0x0 0x80 0x0 &gic_a72 0x0 0x80 0x4>,
    <0x0 0x12 0x0 &gic_a72 0x0 0x12 0x4>,
    <0x0 0x13 0x0 &gic_a72 0x0 0x13 0x4>,
    <0x0 0x6b 0x0 &gic_a72 0x0 0x6b 0x4>,
    <0x0 0x7c 0x0 &gic_a72 0x0 0x7c 0x4>,
    <0x0 0x7d 0x0 &gic_a72 0x0 0x7d 0x4>,
    <0x0 0x10 0x0 &gic_a72 0x0 0x10 0x4>,
    <0x0 0x11 0x0 &gic_a72 0x0 0x11 0x4>,
    <0x0 0x16 0x0 &gic_a72 0x0 0x16 0x4>,
    <0x0 0x1a 0x0 &gic_a72 0x0 0x1a 0x4>,
    <0x0 0x4a 0x0 &gic_a72 0x0 0x4a 0x4>,
    <0x0 0x48 0x0 &gic_a72 0x0 0x48 0x4>,
    <0x0 0x1e 0x0 &gic_a72 0x0 0x1e 0x4>,
    <0x0 0x1f 0x0 &gic_a72 0x0 0x1f 0x4>,
    <0x0 0x83 0x0 &gic_a72 0x0 0x83 0x4>,
    <0x0 0x84 0x0 &gic_a72 0x0 0x84 0x4>,
    <0x0 0x14 0x0 &gic_r5 0x0 0x14 0x1>,
    <0x0 0x15 0x0 &gic_r5 0x0 0x15 0x1>,
    <0x0 0x6a 0x0 &gic_r5 0x0 0x6a 0x4>,
    <0x0 0x3c 0x0 &gic_r5 0x0 0x3c 0x4>,
    <0x0 0x3d 0x0 &gic_r5 0x0 0x3d 0x4>,
    <0x0 0x3e 0x0 &gic_r5 0x0 0x3e 0x4>,
    <0x0 0x3f 0x0 &gic_r5 0x0 0x3f 0x4>,
    <0x0 0x40 0x0 &gic_r5 0x0 0x40 0x4>,
    <0x0 0x41 0x0 &gic_r5 0x0 0x41 0x4>,
    <0x0 0x42 0x0 &gic_r5 0x0 0x42 0x4>,
    <0x0 0x43 0x0 &gic_r5 0x0 0x43 0x4>,
    <0x0 0x38 0x0 &gic_r5 0x0 0x38 0x4>,
    <0x0 0x3a 0x0 &gic_r5 0x0 0x3a 0x4>,
    <0x0 0xd 0x0 &gic_r5 0x0 0xd 0x4>,
    <0x0 0x7a 0x0 &gic_r5 0x0 0x7a 0x4>,
    <0x0 0xe 0x0 &gic_r5 0x0 0xe 0x4>,
    <0x0 0xf 0x0 &gic_r5 0x0 0xf 0x4>,
    <0x0 0x8e 0x0 &gic_r5 0x0 0x8e 0x4>,
    <0x0 0x8f 0x0 &gic_r5 0x0 0x8f 0x4>,
    <0x0 0x7e 0x0 &gic_r5 0x0 0x7e 0x4>,
    <0x0 0x80 0x0 &gic_r5 0x0 0x80 0x4>,
    <0x0 0x12 0x0 &gic_r5 0x0 0x12 0x4>,
    <0x0 0x13 0x0 &gic_r5 0x0 0x13 0x4>,
    <0x0 0x6b 0x0 &gic_r5 0x0 0x6b 0x4>,
    <0x0 0x7c 0x0 &gic_r5 0x0 0x7c 0x4>,
    <0x0 0x7d 0x0 &gic_r5 0x0 0x7d 0x4>,
    <0x0 0x10 0x0 &gic_r5 0x0 0x10 0x4>,
    <0x0 0x11 0x0 &gic_r5 0x0 0x11 0x4>,
    <0x0 0x16 0x0 &gic_r5 0x0 0x16 0x4>,
    <0x0 0x1a 0x0 &gic_r5 0x0 0x1a 0x4>,
    <0x0 0x4a 0x0 &gic_r5 0x0 0x4a 0x4>,
    <0x0 0x48 0x0 &gic_r5 0x0 0x48 0x4>,
    <0x0 0x1e 0x0 &gic_r5 0x0 0x1e 0x4>,
    <0x0 0x1f 0x0 &gic_r5 0x0 0x1f 0x4>,
    <0x0 0x83 0x0 &gic_r5 0x0 0x83 0x4>,
    <0x0 0x84 0x0 &gic_r5 0x0 0x84 0x4>;
  };

  can0: can@ff060000 {
   compatible = "xlnx,canfd-2.0";
   status = "disabled";
   reg = <0 0xff060000 0 0x6000>;
   interrupts = <0 20 4>;
   interrupt-parent = <&imux>;
   clock-names = "can_clk", "s_axi_aclk";
   rx-fifo-depth = <0x40>;
   tx-mailbox-count = <0x20>;
  };

  can1: can@ff070000 {
   compatible = "xlnx,canfd-2.0";
   status = "disabled";
   reg = <0 0xff070000 0 0x6000>;
   interrupts = <0 21 4>;
   interrupt-parent = <&imux>;
   clock-names = "can_clk", "s_axi_aclk";
   rx-fifo-depth = <0x40>;
   tx-mailbox-count = <0x20>;
  };

  cci: cci@fd000000 {
   compatible = "arm,cci-500";
   status = "disabled";
   reg = <0 0xfd000000 0 0x10000>;
   ranges = <0 0 0xfd000000 0xa0000>;
   #address-cells = <1>;
   #size-cells = <1>;
   cci_pmu: pmu@10000 {
    compatible = "arm,cci-500-pmu,r0";
    reg = <0x10000 0x90000>;
    interrupt-parent = <&imux>;
    interrupts = <0 106 4>,
                 <0 106 4>,
                 <0 106 4>,
                 <0 106 4>,
                 <0 106 4>,
                 <0 106 4>,
                 <0 106 4>,
                 <0 106 4>;
   };
  };

  lpd_dma_chan0: dma-controller@ffa80000 {
   compatible = "xlnx,zynqmp-dma-1.0";
   status = "disabled";
   reg = <0 0xffa80000 0 0x1000>;
   interrupts = <0 60 4>;
   interrupt-parent = <&imux>;
   clock-names = "clk_main", "clk_apb";

   xlnx,dma-type = <1>;

   #dma-cells = <1>;
   xlnx,bus-width = <64>;

  };

  lpd_dma_chan1: dma-controller@ffa90000 {
   compatible = "xlnx,zynqmp-dma-1.0";
   status = "disabled";
   reg = <0 0xffa90000 0 0x1000>;
   interrupts = <0 61 4>;
   interrupt-parent = <&imux>;
   clock-names = "clk_main", "clk_apb";

   xlnx,dma-type = <1>;

   #dma-cells = <1>;
   xlnx,bus-width = <64>;

  };

  lpd_dma_chan2: dma-controller@ffaa0000 {
   compatible = "xlnx,zynqmp-dma-1.0";
   status = "disabled";
   reg = <0 0xffaa0000 0 0x1000>;
   interrupts = <0 62 4>;
   interrupt-parent = <&imux>;
   clock-names = "clk_main", "clk_apb";

   xlnx,dma-type = <1>;

   #dma-cells = <1>;
   xlnx,bus-width = <64>;

  };


  lpd_dma_chan3: dma-controller@ffab0000 {
   compatible = "xlnx,zynqmp-dma-1.0";
   status = "disabled";
   reg = <0 0xffab0000 0 0x1000>;
   interrupts = <0 63 4>;
   interrupt-parent = <&imux>;
   clock-names = "clk_main", "clk_apb";

   xlnx,dma-type = <1>;

   #dma-cells = <1>;
   xlnx,bus-width = <64>;

  };

  lpd_dma_chan4: dma-controller@ffac0000 {
   compatible = "xlnx,zynqmp-dma-1.0";
   status = "disabled";
   reg = <0 0xffac0000 0 0x1000>;
   interrupts = <0 64 4>;
   interrupt-parent = <&imux>;
   clock-names = "clk_main", "clk_apb";

   xlnx,dma-type = <1>;

   #dma-cells = <1>;
   xlnx,bus-width = <64>;

  };

  lpd_dma_chan5: dma-controller@ffad0000 {
   compatible = "xlnx,zynqmp-dma-1.0";
   status = "disabled";
   reg = <0 0xffad0000 0 0x1000>;
   interrupts = <0 65 4>;
   interrupt-parent = <&imux>;
   clock-names = "clk_main", "clk_apb";

   xlnx,dma-type = <1>;

   #dma-cells = <1>;
   xlnx,bus-width = <64>;

  };

  lpd_dma_chan6: dma-controller@ffae0000 {
   compatible = "xlnx,zynqmp-dma-1.0";
   status = "disabled";
   reg = <0 0xffae0000 0 0x1000>;
   interrupts = <0 66 4>;
   interrupt-parent = <&imux>;
   clock-names = "clk_main", "clk_apb";

   xlnx,dma-type = <1>;

   #dma-cells = <1>;
   xlnx,bus-width = <64>;

  };

  lpd_dma_chan7: dma-controller@ffaf0000 {
   compatible = "xlnx,zynqmp-dma-1.0";
   status = "disabled";
   reg = <0 0xffaf0000 0 0x1000>;
   interrupts = <0 67 4>;
   interrupt-parent = <&imux>;
   clock-names = "clk_main", "clk_apb";

   xlnx,dma-type = <1>;

   #dma-cells = <1>;
   xlnx,bus-width = <64>;

  };

  gem0: ethernet@ff0c0000 {
   compatible = "xlnx,versal-gem", "cdns,gem";
   status = "disabled";
   reg = <0 0xff0c0000 0 0x1000>;
   interrupts = <0 56 4>, <0 56 4>;
   interrupt-parent = <&imux>;
   clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";


   #address-cells = <1>;
   #size-cells = <0>;
  };

  gem1: ethernet@ff0d0000 {
   compatible = "xlnx,versal-gem", "cdns,gem";
   status = "disabled";
   reg = <0 0xff0d0000 0 0x1000>;
   interrupts = <0 58 4>, <0 58 4>;
   interrupt-parent = <&imux>;
   clock-names = "pclk", "hclk", "tx_clk", "rx_clk", "tsu_clk";


   #address-cells = <1>;
   #size-cells = <0>;
  };


  gpio0: gpio@ff0b0000 {
   compatible = "xlnx,versal-gpio-1.0";
   status = "disabled";
   reg = <0 0xff0b0000 0 0x1000>;
   interrupts = <0 13 4>;
   interrupt-parent = <&imux>;
   #gpio-cells = <2>;
   gpio-controller;
   #interrupt-cells = <2>;
   interrupt-controller;
  };

  gpio1: gpio@f1020000 {
   compatible = "xlnx,pmc-gpio-1.0";
   status = "disabled";
   reg = <0 0xf1020000 0 0x1000>;
   interrupts = <0 122 4>;
   interrupt-parent = <&imux>;
   #gpio-cells = <2>;
   gpio-controller;
   #interrupt-cells = <2>;
   interrupt-controller;
  };

  i2c0: i2c@ff020000 {
   compatible = "cdns,i2c-r1p14";
   status = "disabled";
   reg = <0 0xff020000 0 0x1000>;
   interrupts = <0 14 4>;
   interrupt-parent = <&imux>;
   clock-frequency = <100000>;
   #address-cells = <1>;
   #size-cells = <0>;
  };

  i2c1: i2c@ff030000 {
   compatible = "cdns,i2c-r1p14";
   status = "disabled";
   reg = <0 0xff030000 0 0x1000>;
   interrupts = <0 15 4>;
   interrupt-parent = <&imux>;
   clock-frequency = <100000>;
   #address-cells = <1>;
   #size-cells = <0>;
  };

  i2c2: i2c@f1000000 {
   compatible = "cdns,i2c-r1p14";
   status = "disabled";
   reg = <0 0xf1000000 0 0x1000>;
   interrupts = <0 123 4>;
   interrupt-parent = <&imux>;
   clock-frequency = <100000>;
   #address-cells = <1>;
   #size-cells = <0>;
  };

  mc0: memory-controller@f6150000 {
   compatible = "xlnx,versal-ddrmc";
   status = "disabled";
   reg = <0x0 0xf6150000 0x0 0x2000>, <0x0 0xf6070000 0x0 0x20000>;
   reg-names = "base", "noc";
   interrupts = <0 147 4>;
   interrupt-parent = <&imux>;
  };

  mc1: memory-controller@f62c0000 {
   compatible = "xlnx,versal-ddrmc";
   status = "disabled";
   reg = <0x0 0xf62c0000 0x0 0x2000>, <0x0 0xf6210000 0x0 0x20000>;
   reg-names = "base", "noc";
   interrupts = <0 147 4>;
   interrupt-parent = <&imux>;
  };

  mc2: memory-controller@f6430000 {
   compatible = "xlnx,versal-ddrmc";
   status = "disabled";
   reg = <0x0 0xf6430000 0x0 0x2000>, <0x0 0xf6380000 0x0 0x20000>;
   reg-names = "base", "noc";
   interrupts = <0 147 4>;
   interrupt-parent = <&imux>;
  };

  mc3: memory-controller@f65a0000 {
   compatible = "xlnx,versal-ddrmc";
   status = "disabled";
   reg = <0x0 0xf65a0000 0x0 0x2000>, <0x0 0xf64f0000 0x0 0x20000>;
   reg-names = "base", "noc";
   interrupts = <0 147 4>;
   interrupt-parent = <&imux>;
  };

  ocm: memory-controller@ff960000 {
   compatible = "xlnx,zynqmp-ocmc-1.0";
   reg = <0x0 0xff960000 0x0 0x1000>;
   interrupts = <0 10 4>;
   interrupt-parent = <&imux>;
  };

  rtc: rtc@f12a0000 {
   compatible = "xlnx,zynqmp-rtc";
   status = "disabled";
   reg = <0 0xf12a0000 0 0x100>;
   interrupt-names = "alarm", "sec";
   interrupts = <0 142 4>, <0 143 4>;
   interrupt-parent = <&imux>;
   calibration = <0x7FFF>;
  };

  sdhci0: mmc@f1040000 {
   compatible = "xlnx,versal-8.9a", "arasan,sdhci-8.9a";
   status = "disabled";
   reg = <0 0xf1040000 0 0x10000>;
   interrupts = <0 126 4>;
   interrupt-parent = <&imux>;
   clock-names = "clk_xin", "clk_ahb", "gate";
   #clock-cells = <1>;
   clock-output-names = "clk_out_sd0", "clk_in_sd0";


  };

  sdhci1: mmc@f1050000 {
   compatible = "xlnx,versal-8.9a", "arasan,sdhci-8.9a";
   status = "disabled";
   reg = <0 0xf1050000 0 0x10000>;
   interrupts = <0 128 4>;
   interrupt-parent = <&imux>;
   clock-names = "clk_xin", "clk_ahb", "gate";
   #clock-cells = <1>;
   clock-output-names = "clk_out_sd1", "clk_in_sd1";


  };

  serial0: serial@ff000000 {
   compatible = "arm,pl011", "arm,primecell";
   status = "disabled";
   reg = <0 0xff000000 0 0x1000>;
   interrupts = <0 18 4>;
   interrupt-parent = <&imux>;
   reg-io-width = <4>;
   clock-names = "uartclk", "apb_pclk";
   bootph-all;
  };

  serial1: serial@ff010000 {
   compatible = "arm,pl011", "arm,primecell";
   status = "disabled";
   reg = <0 0xff010000 0 0x1000>;
   interrupts = <0 19 4>;
   interrupt-parent = <&imux>;
   reg-io-width = <4>;
   clock-names = "uartclk", "apb_pclk";
   bootph-all;
  };

  smmu: iommu@fd800000 {
   compatible = "arm,mmu-500";
   status = "disabled";
   reg = <0 0xfd800000 0 0x40000>;
   stream-match-mask = <0x7c00>;
   #iommu-cells = <1>;
   #global-interrupts = <1>;
   interrupts = <0 107 4>,
    <0 107 4>, <0 107 4>, <0 107 4>, <0 107 4>,
    <0 107 4>, <0 107 4>, <0 107 4>, <0 107 4>,
    <0 107 4>, <0 107 4>, <0 107 4>, <0 107 4>,
    <0 107 4>, <0 107 4>, <0 107 4>, <0 107 4>,
    <0 107 4>, <0 107 4>, <0 107 4>, <0 107 4>,
    <0 107 4>, <0 107 4>, <0 107 4>, <0 107 4>,
    <0 107 4>, <0 107 4>, <0 107 4>, <0 107 4>,
    <0 107 4>, <0 107 4>, <0 107 4>, <0 107 4>;
   interrupt-parent = <&imux>;
  };

  ospi: spi@f1010000 {
   compatible = "xlnx,versal-ospi-1.0", "cdns,qspi-nor";
   status = "disabled";
   reg = <0 0xf1010000 0 0x10000 0 0xc0000000 0 0x20000000>;
   interrupts = <0 124 4>;
   interrupt-parent = <&imux>;
   cdns,fifo-depth = <256>;
   cdns,fifo-width = <4>;
   cdns,is-dma = <1>;
   cdns,trigger-address = <0xC0000000>;
   #address-cells = <1>;
   #size-cells = <0>;
  };

  qspi: spi@f1030000 {
   compatible = "xlnx,versal-qspi-1.0";
   status = "disabled";
   reg = <0 0xf1030000 0 0x1000>;
   interrupts = <0 125 4>;
   interrupt-parent = <&imux>;
   clock-names = "ref_clk", "pclk";


   #address-cells = <1>;
   #size-cells = <0>;
  };


  spi0: spi@ff040000 {
   compatible = "cdns,spi-r1p6";
   status = "disabled";
   reg = <0 0xff040000 0 0x1000>;
   interrupts = <0 16 4>;
   interrupt-parent = <&imux>;
   clock-names = "ref_clk", "pclk";
   #address-cells = <1>;
   #size-cells = <0>;
  };

  spi1: spi@ff050000 {
   compatible = "cdns,spi-r1p6";
   status = "disabled";
   reg = <0 0xff050000 0 0x1000>;
   interrupts = <0 17 4>;
   interrupt-parent = <&imux>;
   clock-names = "ref_clk", "pclk";
   #address-cells = <1>;
   #size-cells = <0>;
  };

  sysmon0: sysmon@f1270000 {
   compatible = "xlnx,versal-sysmon";
   #io-channel-cells = <0>;
   reg = <0x0 0xf1270000 0x0 0x4000>;
   interrupts = <0 144 4>;
   xlnx,numchannels = /bits/8 <0>;
   #address-cells = <1>;
   #size-cells = <0>;
  };

  sysmon1: sysmon@109270000 {
   compatible = "xlnx,versal-sysmon";
   status = "disabled";
   reg = <0x1 0x09270000 0x0 0x4000>;
   xlnx,numchannels = /bits/8 <0>;
   #address-cells = <1>;
   #size-cells = <0>;
  };

  sysmon2: sysmon@111270000 {
   compatible = "xlnx,versal-sysmon";
   status = "disabled";
   reg = <0x1 0x11270000 0x0 0x4000>;
   xlnx,numchannels = /bits/8 <0>;
   #address-cells = <1>;
   #size-cells = <0>;
  };

  sysmon3: sysmon@119270000 {
   compatible = "xlnx,versal-sysmon";
   status = "disabled";
   reg = <0x1 0x19270000 0x0 0x4000>;
   xlnx,numchannels = /bits/8 <0>;
   #address-cells = <1>;
   #size-cells = <0>;
  };

  ttc0: timer@ff0e0000 {
   compatible = "cdns,ttc";
   status = "disabled";
   interrupts = <0 37 4>, <0 38 4>, <0 39 4>;
   interrupt-parent = <&imux>;
   reg = <0x0 0xff0e0000 0x0 0x1000>;
   timer-width = <32>;
  };

  ttc1: timer@ff0f0000 {
   compatible = "cdns,ttc";
   status = "disabled";
   interrupts = <0 40 4>, <0 41 4>, <0 42 4>;
   interrupt-parent = <&imux>;
   reg = <0x0 0xff0f0000 0x0 0x1000>;
   timer-width = <32>;
  };

  ttc2: timer@ff100000 {
   compatible = "cdns,ttc";
   status = "disabled";
   interrupts = <0 43 4>, <0 44 4>, <0 45 4>;
   interrupt-parent = <&imux>;
   reg = <0x0 0xff100000 0x0 0x1000>;
   timer-width = <32>;
  };

  ttc3: timer@ff110000 {
   compatible = "cdns,ttc";
   status = "disabled";
   interrupts = <0 46 4>, <0 47 4>, <0 48 4>;
   interrupt-parent = <&imux>;
   reg = <0x0 0xff110000 0x0 0x1000>;
   timer-width = <32>;
  };

  usb0: usb@ff9d0000 {
   compatible = "xlnx,versal-dwc3";
   status = "disabled";
   reg = <0 0xff9d0000 0 0x100>;
   clock-names = "bus_clk", "ref_clk";
   ranges;
   #address-cells = <2>;
   #size-cells = <2>;

   dwc3_0: usb@fe200000 {
    compatible = "snps,dwc3";
    status = "disabled";
    reg = <0 0xfe200000 0 0x10000>;
    interrupt-names = "host", "peripheral", "otg", "wakeup";
    interrupts = <0 0x16 4>, <0 0x16 4>, <0 0x1a 4>, <0x0 0x4a 0x4>;

    snps,dis_u2_susphy_quirk;
    snps,dis_u3_susphy_quirk;
    snps,quirk-frame-length-adjustment = <0x20>;
    clock-names = "ref";

   };
  };

  cpm_pciea: pci@fca10000 {
   device_type = "pci";
   #address-cells = <3>;
   #interrupt-cells = <1>;
   #size-cells = <2>;
   compatible = "xlnx,versal-cpm-host-1.00";
   status = "disabled";
   interrupt-map = <0 0 0 1 &pcie_intc_0 0>,
     <0 0 0 2 &pcie_intc_0 1>,
     <0 0 0 3 &pcie_intc_0 2>,
     <0 0 0 4 &pcie_intc_0 3>;
   interrupt-map-mask = <0 0 0 7>;
   interrupt-names = "misc";
   interrupts = <0 72 4>;
   xlnx,csr-slcr = <0x6 00000000>;
   xlnx,num-of-bars = <0x2>;
   xlnx,port-type = <0x1>;
   interrupt-parent = <&imux>;
   bus-range = <0x00 0xff>;
   ranges = <0x02000000 0x00000000 0xe0010000 0x0 0xe0010000 0x00000000 0x10000000>,
     <0x43000000 0x00000080 0x00000000 0x00000080 0x00000000 0x00000000 0x80000000>;
   msi-map = <0x0 &gic_its 0x0 0x10000>;
   reg = <0x6 0x00000000 0x0 0x1000000>,
         <0x0 0xfca10000 0x0 0x1000>;
   reg-names = "cfg", "cpm_slcr";
   pcie_intc_0: interrupt-controller {
    #address-cells = <0>;
    #interrupt-cells = <1>;
    interrupt-controller ;
   };
  };

  cpm5_pcie: pcie@fcdd0000 {
   device_type = "pci";
   #address-cells = <3>;
   #interrupt-cells = <1>;
   #size-cells = <2>;
   compatible = "xlnx,versal-cpm5-host";
   status = "disabled";
   interrupt-map = <0 0 0 1 &pcie_intc_2 0>,
     <0 0 0 2 &pcie_intc_2 1>,
     <0 0 0 3 &pcie_intc_2 2>,
     <0 0 0 4 &pcie_intc_2 3>;
   interrupt-map-mask = <0 0 0 7>;
   interrupt-names = "misc";
   interrupts = <0 72 4>;
   xlnx,csr-slcr = <0xfce20000>;
   xlnx,num-of-bars = <0x2>;
   xlnx,port-type = <0x1>;
   interrupt-parent = <&imux>;
   bus-range = <0x00 0xff>;
   ranges = <0x02000000 0x0 0xe0000000 0x0 0xe0000000 0x0 0x10000000>,
     <0x43000000 0x80 0x00000000 0x80 0x00000000 0x0 0x80000000>;
   msi-map = <0x0 &gic_its 0x0 0x10000>;
   reg = <0x06 0x00000000 0x00 0x1000000>,
         <0x00 0xfcdd0000 0x00 0x1000>,
         <0x00 0xfce20000 0x00 0x1000000>;
   reg-names = "cfg", "cpm_slcr", "cpm_csr";
   pcie_intc_2: interrupt-controller {
    #address-cells = <0>;
    #interrupt-cells = <1>;
    interrupt-controller;
   };
  };

  watchdog: watchdog@fd4d0000 {
   compatible = "xlnx,versal-wwdt";
   status = "disabled";
   reg = <0 0xfd4d0000 0 0x10000>;
   interrupt-names = "wdt", "wwdt_reset_pending", "gwdt", "gwdt_reset_pending";
   interrupts = <0 0x64 1>, <0 0x6D 1>, <0 0x6C 1>, <0 0x6E 1>;
   interrupt-parent = <&imux>;
   timeout-sec = <30>;
  };

  watchdog1: watchdog@ff120000 {
   compatible = "xlnx,versal-wwdt";
   status = "disabled";
   reg = <0x0 0xff120000 0x0 0x10000>;
   interrupt-parent = <&imux>;
   interrupt-names = "wdt", "wwdt_reset_pending", "gwdt", "gwdt_reset_pending";
   interrupts = <0 49 1>, <0 69 1>, <0 70 4>, <0 71 4>;
   timeout-sec = <30>;
  };
  xilsem_edac: edac@f2014050 {
   compatible = "xlnx,versal-xilsem-edac";
   status = "disabled";
   reg = <0x0 0xf2014050 0x0 0xc4>;
  };

  dma0: pmcdma@f11c0000 {
   status = "disabled";
   compatible = "xlnx,zynqmp-csudma-1.0";
   interrupt-parent = <&imux>;
   interrupts = <0 0x83 4>;
   reg = <0x0 0xf11c0000 0x0 0x10000>;
   xlnx,dma-type = <1>;
  };

  dma1: pmcdma@f11d0000 {
   status = "disabled";
   compatible = "xlnx,zynqmp-csudma-1.0";
   interrupt-parent = <&imux>;
   interrupts = <0 0x84 4>;
   reg = <0x0 0xf11d0000 0x0 0x10000>;
   xlnx,dma-type = <2>;
  };

  iomodule0: iomodule@f0280000 {
   status = "disabled";
   compatible = "xlnx,iomodule-3.1";
   reg = <0x0 0xF0280000 0x0 0x1000>, <0xFFFFFFFF 0xFFFFFFFF 0x0 0xE0000>;
   xlnx,intc-has-fast = <0x0>;
   xlnx,intc-base-vectors = <0xF0240000U>;
   xlnx,intc-addr-width = <0x20>;
   xlnx,intc-level-edge = <0x7FFU>;
   xlnx,clock-freq = <100000000U>;
   xlnx,uart-baudrate = <115200U>;
   xlnx,pit-used = <01 01 01 01>;
   xlnx,pit-size = <0x20 0x20 0x20 0x20>;
   xlnx,pit-mask = <0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF>;
   xlnx,pit-prescaler = <0x9 0x0 0x9 0x0>;
   xlnx,pit-readable = <01 01 01 01>;
   xlnx,gpo-init = <00 00 00 00>;
   xlnx,options = <0x1>;
   xlnx,max-intr-size = <32>;
  };

  ipi_pmc: mailbox@ff320000 {
   status = "disabled";
   compatible = "xlnx,zynqmp-ipi-mailbox";
   interrupt-parent = <&imux>;
   interrupts = <0 27 4>;
   reg = <0x0 0xFF320000U 0x0 0x20>;
   xlnx,ipi-bitmask = <0x2>;
   xlnx,ipi-id = <1>;
   xlnx,ipi-buf-index = <1>;
   #address-cells = <2>;
   #size-cells = <2>;
   ranges;

  };

  ipi_pmc_nobuf: mailbox@ff390000 {
   status = "disabled";
   compatible = "xlnx,zynqmp-ipi-mailbox";
   interrupt-parent = <&imux>;
   interrupts = <0 28 4>;
   reg = <0x0 0xFF390000U 0x0 0x20>;
   xlnx,ipi-bitmask = <0x100>;
   xlnx,ipi-id = <8>;
   xlnx,ipi-buf-index = <0xFFFF>;
   #address-cells = <2>;
   #size-cells = <2>;
   ranges;

  };

  ipi_psm: mailbox@ff310000 {
   status = "disabled";
   compatible = "xlnx,zynqmp-ipi-mailbox";
   interrupt-parent = <&imux>;
   interrupts = <0 29 4>;
   reg = <0x0 0xFF310000U 0x0 0x20>;
   xlnx,ipi-bitmask = <0x1>;
   xlnx,ipi-id = <0>;
   xlnx,ipi-buf-index = <0>;
   #address-cells = <2>;
   #size-cells = <2>;
   ranges;

  };

  ipi0: mailbox@ff330000 {
   status = "disabled";
   compatible = "xlnx,zynqmp-ipi-mailbox";
   interrupt-parent = <&imux>;
   interrupts = <0 30 4>;
   reg = <0x0 0xFF330000U 0x0 0x20>;
   xlnx,ipi-bitmask = <0x4>;
   xlnx,ipi-id = <2>;
   xlnx,ipi-buf-index = <2>;
   #address-cells = <2>;
   #size-cells = <2>;
   ranges;

  };

  ipi1: mailbox@ff340000 {
   status = "disabled";
   compatible = "xlnx,zynqmp-ipi-mailbox";
   interrupt-parent = <&imux>;
   interrupts = <0 31 4>;
   reg = <0x0 0xFF340000U 0x0 0x20>;
   xlnx,ipi-bitmask = <0x8>;
   xlnx,ipi-id = <3>;
   xlnx,ipi-buf-index = <3>;
   #address-cells = <2>;
   #size-cells = <2>;
   ranges;

  };

  ipi2: mailbox@ff350000 {
   status = "disabled";
   compatible = "xlnx,zynqmp-ipi-mailbox";
   interrupt-parent = <&imux>;
   interrupts = <0 32 4>;
   reg = <0x0 0xFF350000U 0x0 0x20>;
   xlnx,ipi-bitmask = <0x10>;
   xlnx,ipi-id = <4>;
   xlnx,ipi-buf-index = <4>;
   #address-cells = <2>;
   #size-cells = <2>;
   ranges;

  };

  ipi3: mailbox@ff360000 {
   status = "disabled";
   compatible = "xlnx,zynqmp-ipi-mailbox";
   interrupt-parent = <&imux>;
   interrupts = <0 33 4>;
   reg = <0x0 0xFF360000U 0x0 0x20>;
   xlnx,ipi-bitmask = <0x20>;
   xlnx,ipi-id = <5>;
   xlnx,ipi-buf-index = <5>;
   #address-cells = <2>;
   #size-cells = <2>;
   ranges;

  };

  ipi4: mailbox@ff370000 {
   status = "disabled";
   compatible = "xlnx,zynqmp-ipi-mailbox";
   interrupt-parent = <&imux>;
   interrupts = <0 34 4>;
   reg = <0x0 0xFF370000U 0x0 0x20>;
   xlnx,ipi-bitmask = <0x40>;
   xlnx,ipi-id = <6>;
   xlnx,ipi-buf-index = <6>;
   #address-cells = <2>;
   #size-cells = <2>;
   ranges;

  };

  ipi5: mailbox@ff380000 {
   status = "disabled";
   compatible = "xlnx,zynqmp-ipi-mailbox";
   interrupt-parent = <&imux>;
   interrupts = <0 35 4>;
   reg = <0x0 0xFF380000U 0x0 0x20>;
   xlnx,ipi-bitmask = <0x80>;
   xlnx,ipi-id = <7>;
   xlnx,ipi-buf-index = <7>;
   #address-cells = <2>;
   #size-cells = <2>;
   ranges;

  };

  ipi6: mailbox@ff3a0000 {
   status = "disabled";
   compatible = "xlnx,zynqmp-ipi-mailbox";
   interrupt-parent = <&imux>;
   interrupts = <0 36 4>;
   reg = <0x0 0xFF3A0000U 0x0 0x20>;
   xlnx,ipi-bitmask = <0x200>;
   xlnx,ipi-id = <9>;
   xlnx,ipi-buf-index = <0xFFFF>;
   #address-cells = <2>;
   #size-cells = <2>;
   ranges;
  };

  coresight: coresight@f0800000 {
   compatible = "xlnx,coresight-1.0";
   status = "disabled";
   reg = <0x0 0xf0800000 0x0 0x10000>;
  };
 };

 psv_r5_0_atcm_global: psv_r5_0_atcm_global@ffe00000 {
  compatible = "xlnx,psv-tcm-global-1.0" , "mmio-sram";
  power-domains = <&versal_firmware 0x1831800b>;
  reg = <0x0 0xffe00000 0x0 0x10000>;
 };

 psv_r5_0_btcm_global: psv_r5_0_btcm_global@ffe20000 {
  compatible = "xlnx,psv-tcm-global-1.0" , "mmio-sram";
  power-domains = <&versal_firmware 0x1831800c>;
  reg = <0x0 0xffe20000 0x0 0x10000>;
 };

 psv_r5_1_atcm_global: psv_r5_1_atcm_global@ffe90000 {
  compatible = "xlnx,psv-tcm-global-1.0" , "mmio-sram";
  power-domains = <&versal_firmware 0x1831800d>;
  reg = <0x0 0xffe90000 0x0 0x10000>;
 };

 psv_r5_1_btcm_global: psv_r5_1_btcm_global@ffeb0000 {
  compatible = "xlnx,psv-tcm-global-1.0" , "mmio-sram";
  power-domains = <&versal_firmware 0x1831800e>;
  reg = <0x0 0xffeb0000 0x0 0x10000>;
 };

 amba_xppu: indirect-bus@1 {
  compatible = "indirect-bus";
  #address-cells = <0x2>;
  #size-cells = <0x2>;

  lpd_xppu: xppu@ff990000 {
   compatible = "xlnx,xppu";
   #firewall-cells = <0x0>;
   reg = <0x0 0xff990000 0x0 0x2000>;
   status = "disabled";
  };

  pmc_xppu: xppu@f1310000 {
   compatible = "xlnx,xppu";
   #firewall-cells = <0x0>;
   reg = <0x0 0xf1310000 0x0 0x2000>;
   status = "disabled";
  };

  pmc_xppu_npi: xppu@f1300000 {
   compatible = "xlnx,xppu";
   #firewall-cells = <0x0>;
   reg = <0x0 0xf1300000 0x0 0x2000>;
   status = "disabled";
  };
 };

 amba_xmpu: indirect-bus@2 {
  compatible = "indirect-bus";
  #address-cells = <0x2>;
  #size-cells = <0x2>;

  fpd_xmpu: xmpu@fd390000 {
   compatible = "xlnx,xmpu";
   #firewall-cells = <0x0>;
   reg = <0x0 0xfd390000 0x0 0x1000>;
   status = "disabled";
  };

  pmc_xmpu: xmpu@f12f0000 {
   compatible = "xlnx,xmpu";
   #firewall-cells = <0x0>;
   reg = <0x0 0xf12f0000 0x0 0x1000>;
   status = "disabled";
  };

  ocm_xmpu: xmpu@ff980000 {
   compatible = "xlnx,xmpu";
   #firewall-cells = <0x0>;
   reg = <0x0 0xff980000 0x0 0x1000>;
   status = "disabled";
  };

  ddrmc_xmpu_0: xmpu@f6080000 {
   compatible = "xlnx,xmpu";
   #firewall-cells = <0x0>;
   reg = <0x0 0xf6080000 0x0 0x1000>;
   status = "disabled";
  };

  ddrmc_xmpu_1: xmpu@f6220000 {
   compatible = "xlnx,xmpu";
   #firewall-cells = <0x0>;
   reg = <0x0 0xf6220000 0x0 0x1000>;
   status = "disabled";
  };

  ddrmc_xmpu_2: xmpu@f6390000 {
   compatible = "xlnx,xmpu";
   #firewall-cells = <0x0>;
   reg = <0x0 0xf6390000 0x0 0x1000>;
   status = "disabled";
  };

  ddrmc_xmpu_3: xmpu@f6500000 {
   compatible = "xlnx,xmpu";
   #firewall-cells = <0x0>;
   reg = <0x0 0xf6500000 0x0 0x1000>;
   status = "disabled";
  };
 };
};
# 3 "/scratch/jenkins-sdt_artifactory_upload_2024.2-52/build_cfg/hw-description/emb-plus-ve2302-sdt_2024.2_1111_2/system-top.dts" 2
# 1 "/scratch/jenkins-sdt_artifactory_upload_2024.2-52/build_cfg/hw-description/emb-plus-ve2302-sdt_2024.2_1111_2/versal-clk.dtsi" 1
# 11 "/scratch/jenkins-sdt_artifactory_upload_2024.2-52/build_cfg/hw-description/emb-plus-ve2302-sdt_2024.2_1111_2/versal-clk.dtsi"
# 1 "/scratch/jenkins-sdt_artifactory_upload_2024.2-52/build_cfg/hw-description/emb-plus-ve2302-sdt_2024.2_1111_2/include/dt-bindings/power/xlnx-versal-power.h" 1
# 12 "/scratch/jenkins-sdt_artifactory_upload_2024.2-52/build_cfg/hw-description/emb-plus-ve2302-sdt_2024.2_1111_2/versal-clk.dtsi" 2
# 1 "/scratch/jenkins-sdt_artifactory_upload_2024.2-52/build_cfg/hw-description/emb-plus-ve2302-sdt_2024.2_1111_2/include/dt-bindings/power/xlnx-versal-regnode.h" 1
# 13 "/scratch/jenkins-sdt_artifactory_upload_2024.2-52/build_cfg/hw-description/emb-plus-ve2302-sdt_2024.2_1111_2/versal-clk.dtsi" 2
# 1 "/scratch/jenkins-sdt_artifactory_upload_2024.2-52/build_cfg/hw-description/emb-plus-ve2302-sdt_2024.2_1111_2/include/dt-bindings/clock/xlnx-versal-clk.h" 1
# 14 "/scratch/jenkins-sdt_artifactory_upload_2024.2-52/build_cfg/hw-description/emb-plus-ve2302-sdt_2024.2_1111_2/versal-clk.dtsi" 2
# 1 "/scratch/jenkins-sdt_artifactory_upload_2024.2-52/build_cfg/hw-description/emb-plus-ve2302-sdt_2024.2_1111_2/include/dt-bindings/reset/xlnx-versal-resets.h" 1
# 15 "/scratch/jenkins-sdt_artifactory_upload_2024.2-52/build_cfg/hw-description/emb-plus-ve2302-sdt_2024.2_1111_2/versal-clk.dtsi" 2

/ {
 pl_alt_ref_clk: pl_alt_ref_clk {
  bootph-all;
  compatible = "fixed-clock";
  #clock-cells = <0>;
  clock-frequency = <33333333>;
 };

 ref_clk: ref_clk {
  bootph-all;
  compatible = "fixed-clock";
  #clock-cells = <0>;
  clock-frequency = <33333333>;
 };

 can0_clk: can0_clk {
  #clock-cells = <0>;
  compatible = "fixed-factor-clock";
  clocks = <&versal_clk 96>;
  clock-div = <2>;
  clock-mult = <1>;
 };

 can1_clk: can1_clk {
  #clock-cells = <0>;
  compatible = "fixed-factor-clock";
  clocks = <&versal_clk 97>;
  clock-div = <2>;
  clock-mult = <1>;
 };

 firmware {
  versal_firmware: versal-firmware {
   compatible = "xlnx,versal-firmware";
   interrupt-parent = <&imux>;
   bootph-all;
   method = "smc";
   #power-domain-cells = <1>;

   versal_clk: clock-controller {
    bootph-all;
    #clock-cells = <1>;
    compatible = "xlnx,versal-clk";
    clocks = <&ref_clk>, <&pl_alt_ref_clk>;
    clock-names = "ref_clk", "pl_alt_ref_clk";
   };

   zynqmp_power: zynqmp-power {
    compatible = "xlnx,zynqmp-power";
   };

   versal_reset: reset-controller {
    compatible = "xlnx,versal-reset";
    #reset-cells = <1>;
   };

   pinctrl0: pinctrl {
    compatible = "xlnx,versal-pinctrl";
   };

   versal_sec_cfg: versal-sec-cfg {
    compatible = "xlnx,versal-sec-cfg";
    #address-cells = <1>;
    #size-cells = <1>;

    bbram_zeroize: bbram-zeroize@4 {
     reg = <0x04 0x4>;
    };

    bbram_key: bbram-key@10 {
     reg = <0x10 0x20>;
    };

    bbram_usr: bbram-usr@30 {
     reg = <0x30 0x4>;
    };

    bbram_lock: bbram-lock@48 {
     reg = <0x48 0x4>;
    };

    user_key0: user-key@110 {
     reg = <0x110 0x20>;
    };

    user_key1: user-key@130 {
     reg = <0x130 0x20>;
    };

    user_key2: user-key@150 {
     reg = <0x150 0x20>;
    };

    user_key3: user-key@170 {
     reg = <0x170 0x20>;
    };

    user_key4: user-key@190 {
     reg = <0x190 0x20>;
    };

    user_key5: user-key@1b0 {
     reg = <0x1b0 0x20>;
    };

    user_key6: user-key@1d0 {
     reg = <0x1d0 0x20>;
    };

    user_key7: user-key@1f0 {
     reg = <0x1f0 0x20>;
    };
   };
  };
 };
};

&psv_cortexa72_0 {
 clocks = <&versal_clk 77>;
};

&can0 {
 clocks = <&can0_clk>, <&versal_clk 82>;
 power-domains = <&versal_firmware (0x1822401fU)>;
};

&can1 {
 clocks = <&can1_clk>, <&versal_clk 82>;
 power-domains = <&versal_firmware (0x18224020U)>;
};

&gem0 {
 clocks = <&versal_clk 82>,
   <&versal_clk 88>, <&versal_clk 49>,
   <&versal_clk 48>, <&versal_clk 43>;
 power-domains = <&versal_firmware (0x18224019U)>;
};

&gem1 {
 clocks = <&versal_clk 82>,
   <&versal_clk 89>, <&versal_clk 51>,
   <&versal_clk 50>, <&versal_clk 43>;
 power-domains = <&versal_firmware (0x1822401aU)>;
};

&gpio0 {
 clocks = <&versal_clk 82>;
 power-domains = <&versal_firmware (0x18224023U)>;
};

&gpio1 {
 clocks = <&versal_clk 61>;
 power-domains = <&versal_firmware (0x1822402cU)>;
};

&i2c0 {
 clocks = <&versal_clk 98>;
 power-domains = <&versal_firmware (0x1822401dU)>;
};

&i2c1 {
 clocks = <&versal_clk 99>;
 power-domains = <&versal_firmware (0x1822401eU)>;
};

&i2c2 {
 clocks = <&versal_clk 62>;
 power-domains = <&versal_firmware (0x1822402dU)>;
};

&lpd_dma_chan0 {
 clocks = <&versal_clk 81>, <&versal_clk 82>;
 power-domains = <&versal_firmware (0x18224035U)>;
};

&lpd_dma_chan1 {
 clocks = <&versal_clk 81>, <&versal_clk 82>;
 power-domains = <&versal_firmware (0x18224036U)>;
};

&lpd_dma_chan2 {
 clocks = <&versal_clk 81>, <&versal_clk 82>;
 power-domains = <&versal_firmware (0x18224037U)>;
};

&lpd_dma_chan3 {
 clocks = <&versal_clk 81>, <&versal_clk 82>;
 power-domains = <&versal_firmware (0x18224038U)>;
};

&lpd_dma_chan4 {
 clocks = <&versal_clk 81>, <&versal_clk 82>;
 power-domains = <&versal_firmware (0x18224039U)>;
};

&lpd_dma_chan5 {
 clocks = <&versal_clk 81>, <&versal_clk 82>;
 power-domains = <&versal_firmware (0x1822403aU)>;
};

&lpd_dma_chan6 {
 clocks = <&versal_clk 81>, <&versal_clk 82>;
 power-domains = <&versal_firmware (0x1822403bU)>;
};

&lpd_dma_chan7 {
 clocks = <&versal_clk 81>, <&versal_clk 82>;
 power-domains = <&versal_firmware (0x1822403cU)>;
};

&qspi {
 clocks = <&versal_clk 57>, <&versal_clk 82>;
 power-domains = <&versal_firmware (0x1822402bU)>;
};

&ospi {
 clocks = <&versal_clk 58>;
 power-domains = <&versal_firmware (0x1822402aU)>;
 reset-names = "qspi";
 resets = <&versal_reset (0xc10402eU)>;
};

&rtc {
 power-domains = <&versal_firmware (0x18224034U)>;
};

&serial0 {
 clocks = <&versal_clk 92>, <&versal_clk 82>;
 power-domains = <&versal_firmware (0x18224021U)>;
};

&serial1 {
 clocks = <&versal_clk 93>, <&versal_clk 82>;
 power-domains = <&versal_firmware (0x18224022U)>;
};

&sdhci0 {
 clocks = <&versal_clk 59>, <&versal_clk 82>,
  <&versal_clk 74>;
 power-domains = <&versal_firmware (0x1822402eU)>;
};

&sdhci1 {
 clocks = <&versal_clk 60>, <&versal_clk 82>,
  <&versal_clk 74>;
 power-domains = <&versal_firmware (0x1822402fU)>;
};

&spi0 {
 clocks = <&versal_clk 94>, <&versal_clk 82>;
 power-domains = <&versal_firmware (0x1822401bU)>;
};

&spi1 {
 clocks = <&versal_clk 95>, <&versal_clk 82>;
 power-domains = <&versal_firmware (0x1822401cU)>;
};

&ttc0 {
 clocks = <&versal_clk 39>, <&versal_clk 82>;
 power-domains = <&versal_firmware (0x18224024U)>;
};

&ttc1 {
 clocks = <&versal_clk 40>, <&versal_clk 82>;
 power-domains = <&versal_firmware (0x18224025U)>;
};

&ttc2 {
 clocks = <&versal_clk 41>, <&versal_clk 82>;
 power-domains = <&versal_firmware (0x18224026U)>;
};

&ttc3 {
 clocks = <&versal_clk 42>, <&versal_clk 82>;
 power-domains = <&versal_firmware (0x18224027U)>;
};

&usb0 {
 clocks = <&versal_clk 91>, <&versal_clk 104>;
 power-domains = <&versal_firmware (0x18224018U)>;
 resets = <&versal_reset (0xc104036U)>;
};

&dwc3_0 {
 clocks = <&versal_clk 91>;
};

&watchdog {
 clocks = <&versal_clk 76>;
 power-domains = <&versal_firmware (0x18224029U)>;
};

&watchdog1 {
 clocks = <&versal_clk 82>;
 power-domains = <&versal_firmware (0x18224028U)>;
};

&sysmon0 {
 xlnx,nodeid = <(0x18224055U)>;
};

&sysmon1 {
 xlnx,nodeid = <(0x18225055U)>;
};

&sysmon2 {
 xlnx,nodeid = <(0x18226055U)>;
};

&sysmon3 {
 xlnx,nodeid = <(0x18227055U)>;
};
# 4 "/scratch/jenkins-sdt_artifactory_upload_2024.2-52/build_cfg/hw-description/emb-plus-ve2302-sdt_2024.2_1111_2/system-top.dts" 2
# 1 "/scratch/jenkins-sdt_artifactory_upload_2024.2-52/build_cfg/hw-description/emb-plus-ve2302-sdt_2024.2_1111_2/pl.dtsi" 1
/ {
 amba_pl: amba_pl {
  ranges;
  compatible = "simple-bus";
  #address-cells = <2>;
  #size-cells = <2>;
  firmware-name = "ve2302_pcie_qdma_base.pdi";
  fpga_PR: fpga-PR {
   ranges;
   compatible = "fpga-region";
   #address-cells = <2>;
   #size-cells = <2>;
  };
  misc_clk_0: misc_clk_0 {
   compatible = "fixed-clock";
   clock-frequency = <125000000>;
   #clock-cells = <0>;
  };
  blp_blp_logic_ert_support_axi_intc_0_31: interrupt-controller@20202020000 {
   #interrupt-cells = <2>;
   interrupts = < 0 93 1 >;
   xlnx,sense-of-irq-edge-type = "Rising";
   xlnx,edk-special = "INTR_CTRL";
   xlnx,kind-of-intr = <0x1>;
   xlnx,kind-of-edge = <0xffffffff>;
   xlnx,irq-is-level = <0>;
   xlnx,has-ivr = <1>;
   compatible = "xlnx,axi-intc-4.1" , "xlnx,xps-intc-1.00.a";
   xlnx,disable-synchronizers = <0>;
   xlnx,kind-of-lvl = <0xffffffff>;
   xlnx,ivar-reset-value = <0x10>;
   xlnx,irq-active = <0x1>;
   interrupt-parent = <&imux>;
   xlnx,rable = <0>;
   xlnx,en-cascade-mode = <0>;
   xlnx,ip-name = "axi_intc";
   xlnx,has-ilr = <0>;
   reg = <0x00000202 0x02020000 0x0 0x1000>;
   xlnx,addr-width = <0x20>;
   clocks = <&versal_clk 65>;
   xlnx,s-axi-aclk-freq-mhz = <0x5f5e0a4>;
   xlnx,num-sw-intr = <0>;
   xlnx,irq-connection = <1>;
   xlnx,num-intr-inputs = <0x20>;
   xlnx,has-sie = <1>;
   xlnx,enable-async = <0>;
   xlnx,has-cie = <1>;
   xlnx,num-sync-ff = <2>;
   xlnx,edk-iptype = "PERIPHERAL";
   xlnx,mb-clk-not-connected = <1>;
   xlnx,has-ipr = <1>;
   xlnx,sense-of-irq-level-type = "Active_High";
   xlnx,cascade-master = <0>;
   xlnx,processor-clk-freq-mhz = <100>;
   status = "okay";
   xlnx,is-fast = <0x0>;
   clock-names = "s_axi_aclk";
   xlnx,has-fast = <0>;
   xlnx,ivar-rst-val = <0x10>;
   interrupt-controller;
   interrupt-names = "irq";
   xlnx,async-intr = <0xffffffff>;
   xlnx,name = "blp_blp_logic_ert_support_axi_intc_0_31";
  };
  blp_blp_logic_axi_blp_dbg_hub: axi_dbg_hub@20105000000 {
   compatible = "xlnx,axi-dbg-hub-2.0";
   xlnx,rable = <0>;
   xlnx,core-name = "axi_dbg_hub_v2_0";
   xlnx,ip-name = "axi_dbg_hub";
   xlnx,addr-offset = <0x201 0x05000000>;
   xlnx,address-list = "Master0 /blp/cips/PMC_NOC_AXI_0/SEG_axi_blp_dbg_hub_Mem0 vlnv0 xilinx.com:ip:versal_cips:3.4 Address0 0x0000020105000000 Range0 0x0000000000200000 Master1 /blp/qdma_0/M_AXI/SEG_axi_blp_dbg_hub_Mem0 vlnv1 xilinx.com:ip:qdma:5.0 Address1 0x0000020105000000 Range1 0x0000000000200000 Master2 /blp/qdma_0/M_AXI_BRIDGE/SEG_axi_blp_dbg_hub_Mem0 vlnv2 xilinx.com:ip:qdma:5.0 Address2 0x0000020105000000 Range2 0x0000000000200000";
   xlnx,axi-addr-width = <64>;
   reg = <0x00000201 0x05000000 0x0 0x200000>;
   clocks = <&versal_clk 65>;
   xlnx,axi-id-width = <2>;
   xlnx,num-wr-outstanding-txn = <1>;
   xlnx,edk-iptype = "PERIPHERAL";
   xlnx,num-debug-cores = <0>;
   xlnx,addr-range = <0x200000>;
   xlnx,axis-tdata-width = <32>;
   status = "okay";
   xlnx,axi-data-width = <128>;
   clock-names = "aclk";
   xlnx,num-rd-outstanding-txn = <1>;
   xlnx,en-fallback = <0>;
   xlnx,name = "blp_blp_logic_axi_blp_dbg_hub";
  };
  blp_blp_logic_axi_firewall_user: axi_firewall@80001000 {
   xlnx,protocol = <2>;
   compatible = "xlnx,axi-firewall-1.2";
   xlnx,enable-pipelining = <1>;
   xlnx,enable-protocol-checks = <1>;
   xlnx,awuser-width = <0>;
   xlnx,has-rresp = <1>;
   xlnx,has-bresp = <1>;
   xlnx,supports-narrow = <0>;
   xlnx,read-write-mode = "READ_WRITE";
   xlnx,rable = <0>;
   xlnx,has-prot = <1>;
   xlnx,wdata-width = <32>;
   xlnx,ruser-width = <0>;
   xlnx,buser-width = <0>;
   xlnx,has-aclken = <0>;
   xlnx,ip-name = "axi_firewall";
   xlnx,num-write-threads = <1>;
   reg = <0x0 0x80001000 0x0 0x1000>;
   xlnx,addr-width = <64>;
   clocks = <&versal_clk 65>;
   xlnx,num-read-threads = <1>;
   xlnx,has-lock = <1>;
   xlnx,id-width = <0>;
   xlnx,enable-initial-delay = <1>;
   xlnx,has-wstrb = <1>;
   xlnx,has-aresetn = <1>;
   xlnx,wuser-width = <0>;
   xlnx,has-qos = <1>;
   xlnx,edk-iptype = "PERIPHERAL";
   xlnx,has-region = <1>;
   xlnx,has-cache = <1>;
   xlnx,num-write-outstanding = <32>;
   xlnx,enable-prescaler = <1>;
   xlnx,num-read-outstanding = <32>;
   status = "okay";
   clock-names = "aclk";
   xlnx,data-width = <32>;
   xlnx,aruser-width = <0>;
   xlnx,firewall-mode = <0>;
   xlnx,enable-ctl-clock = <0>;
   xlnx,has-burst = <1>;
   xlnx,rdata-width = <32>;
   xlnx,mask-err-resp = <1>;
   xlnx,enable-timeout-checks = <1>;
   xlnx,name = "blp_blp_logic_axi_firewall_user";
  };
  blp_blp_logic_axi_intc_gcq_apu: interrupt-controller@402031000 {
   #interrupt-cells = <2>;
   interrupts = < 0 95 1 >;
   xlnx,sense-of-irq-edge-type = "Rising";
   xlnx,edk-special = "INTR_CTRL";
   xlnx,kind-of-intr = <0x1>;
   xlnx,kind-of-edge = <0xffffffff>;
   xlnx,irq-is-level = <0>;
   xlnx,has-ivr = <1>;
   compatible = "xlnx,axi-intc-4.1" , "xlnx,xps-intc-1.00.a";
   xlnx,disable-synchronizers = <0>;
   xlnx,kind-of-lvl = <0xffffffff>;
   xlnx,ivar-reset-value = <0x10>;
   xlnx,irq-active = <0x1>;
   interrupt-parent = <&imux>;
   xlnx,rable = <0>;
   xlnx,en-cascade-mode = <0>;
   xlnx,ip-name = "axi_intc";
   xlnx,has-ilr = <0>;
   reg = <0x00000004 0x02031000 0x0 0x1000>;
   xlnx,addr-width = <0x20>;
   clocks = <&versal_clk 65>;
   xlnx,s-axi-aclk-freq-mhz = <0x5f5e0a4>;
   xlnx,num-sw-intr = <0>;
   xlnx,irq-connection = <1>;
   xlnx,num-intr-inputs = <0x1>;
   xlnx,has-sie = <1>;
   xlnx,enable-async = <0>;
   xlnx,has-cie = <1>;
   xlnx,num-sync-ff = <2>;
   xlnx,edk-iptype = "PERIPHERAL";
   xlnx,mb-clk-not-connected = <1>;
   xlnx,has-ipr = <1>;
   xlnx,sense-of-irq-level-type = "Active_High";
   xlnx,cascade-master = <0>;
   xlnx,processor-clk-freq-mhz = <100>;
   status = "okay";
   xlnx,is-fast = <0x0>;
   clock-names = "s_axi_aclk";
   xlnx,has-fast = <0>;
   xlnx,ivar-rst-val = <0x10>;
   interrupt-controller;
   interrupt-names = "irq";
   xlnx,async-intr = <0xfffffffe>;
   xlnx,name = "blp_blp_logic_axi_intc_gcq_apu";
  };
  blp_blp_logic_axi_intc_uart_apu: interrupt-controller@402030000 {
   #interrupt-cells = <2>;
   interrupts = < 0 94 1 >;
   xlnx,sense-of-irq-edge-type = "Rising";
   xlnx,edk-special = "INTR_CTRL";
   xlnx,kind-of-intr = <0x1>;
   xlnx,kind-of-edge = <0xffffffff>;
   xlnx,irq-is-level = <0>;
   xlnx,has-ivr = <1>;
   compatible = "xlnx,axi-intc-4.1" , "xlnx,xps-intc-1.00.a";
   xlnx,disable-synchronizers = <0>;
   xlnx,kind-of-lvl = <0xffffffff>;
   xlnx,ivar-reset-value = <0x10>;
   xlnx,irq-active = <0x1>;
   interrupt-parent = <&imux>;
   xlnx,rable = <0>;
   xlnx,en-cascade-mode = <0>;
   xlnx,ip-name = "axi_intc";
   xlnx,has-ilr = <0>;
   reg = <0x00000004 0x02030000 0x0 0x1000>;
   xlnx,addr-width = <0x20>;
   clocks = <&versal_clk 65>;
   xlnx,s-axi-aclk-freq-mhz = <0x5f5e0a4>;
   xlnx,num-sw-intr = <0>;
   xlnx,irq-connection = <1>;
   xlnx,num-intr-inputs = <0x2>;
   xlnx,has-sie = <1>;
   xlnx,enable-async = <0>;
   xlnx,has-cie = <1>;
   xlnx,num-sync-ff = <2>;
   xlnx,edk-iptype = "PERIPHERAL";
   xlnx,mb-clk-not-connected = <1>;
   xlnx,has-ipr = <1>;
   xlnx,sense-of-irq-level-type = "Active_High";
   xlnx,cascade-master = <0>;
   xlnx,processor-clk-freq-mhz = <100>;
   status = "okay";
   xlnx,is-fast = <0x0>;
   clock-names = "s_axi_aclk";
   xlnx,has-fast = <0>;
   xlnx,ivar-rst-val = <0x10>;
   interrupt-controller;
   interrupt-names = "irq";
   xlnx,async-intr = <0xfffffffe>;
   xlnx,name = "blp_blp_logic_axi_intc_uart_apu";
  };
  blp_blp_logic_axi_uart_apu0: serial@402020000 {
   interrupts = < 0 0 >;
   compatible = "xlnx,axi-uartlite-2.0" , "xlnx,xps-uartlite-1.00.a";
   xlnx,uartlite-board-interface = "Custom";
   xlnx,s-axi-aclk-freq-hz-d = <0x5f5e0a4>;
   interrupt-parent = <&blp_blp_logic_axi_intc_uart_apu>;
   xlnx,rable = <0>;
   xlnx,ip-name = "axi_uartlite";
   reg = <0x00000004 0x02020000 0x0 0x1000>;
   xlnx,baudrate = <230400>;
   clocks = <&versal_clk 65>;
   current-speed = <230400>;
   xlnx,use-parity = <0>;
   xlnx,edk-iptype = "PERIPHERAL";
   xlnx,odd-parity = <0>;
   status = "okay";
   clock-names = "s_axi_aclk";
   interrupt-names = "interrupt";
   xlnx,name = "blp_blp_logic_axi_uart_apu0";
   xlnx,data-bits = <8>;
   xlnx,parity = "No_Parity";
  };
  blp_blp_logic_axi_uart_mgmt_apu0: serial@20102021000 {
   compatible = "xlnx,axi-uartlite-2.0" , "xlnx,xps-uartlite-1.00.a";
   xlnx,uartlite-board-interface = "Custom";
   xlnx,s-axi-aclk-freq-hz-d = <0x5f5e0a4>;
   xlnx,rable = <0>;
   xlnx,ip-name = "axi_uartlite";
   reg = <0x00000201 0x02021000 0x0 0x1000>;
   xlnx,baudrate = <230400>;
   clocks = <&versal_clk 65>;
   current-speed = <230400>;
   xlnx,use-parity = <0>;
   xlnx,edk-iptype = "PERIPHERAL";
   xlnx,odd-parity = <0>;
   status = "okay";
   clock-names = "s_axi_aclk";
   xlnx,name = "blp_blp_logic_axi_uart_mgmt_apu0";
   xlnx,data-bits = <8>;
   xlnx,parity = "No_Parity";
  };
  blp_blp_logic_axi_uart_mgmt_rpu: serial@20102020000 {
   compatible = "xlnx,axi-uartlite-2.0" , "xlnx,xps-uartlite-1.00.a";
   xlnx,uartlite-board-interface = "Custom";
   xlnx,s-axi-aclk-freq-hz-d = <0x5f5e0a4>;
   xlnx,rable = <0>;
   xlnx,ip-name = "axi_uartlite";
   reg = <0x00000201 0x02020000 0x0 0x1000>;
   xlnx,baudrate = <230400>;
   clocks = <&versal_clk 65>;
   current-speed = <230400>;
   xlnx,use-parity = <0>;
   xlnx,edk-iptype = "PERIPHERAL";
   xlnx,odd-parity = <0>;
   status = "okay";
   clock-names = "s_axi_aclk";
   xlnx,name = "blp_blp_logic_axi_uart_mgmt_rpu";
   xlnx,data-bits = <8>;
   xlnx,parity = "No_Parity";
  };
  blp_blp_logic_axi_uart_rpu: serial@80021000 {
   interrupts = < 0 87 1 >;
   compatible = "xlnx,axi-uartlite-2.0" , "xlnx,xps-uartlite-1.00.a";
   xlnx,uartlite-board-interface = "Custom";
   xlnx,s-axi-aclk-freq-hz-d = <0x5f5e0a4>;
   interrupt-parent = <&imux>;
   xlnx,rable = <0>;
   xlnx,ip-name = "axi_uartlite";
   reg = <0x0 0x80021000 0x0 0x1000>;
   xlnx,baudrate = <230400>;
   clocks = <&versal_clk 65>;
   current-speed = <230400>;
   xlnx,use-parity = <0>;
   xlnx,edk-iptype = "PERIPHERAL";
   xlnx,odd-parity = <0>;
   status = "okay";
   clock-names = "s_axi_aclk";
   interrupt-names = "interrupt";
   xlnx,name = "blp_blp_logic_axi_uart_rpu";
   xlnx,data-bits = <8>;
   xlnx,parity = "No_Parity";
  };
  blp_blp_logic_base_clocking_force_reset_gpio: gpio@20102040000 {
   xlnx,gpio-board-interface = "Custom";
   compatible = "xlnx,axi-gpio-2.0" , "xlnx,xps-gpio-1.00.a";
   xlnx,all-outputs = <1>;
   #gpio-cells = <2>;
   xlnx,gpio-width = <1>;
   xlnx,rable = <0>;
   xlnx,dout-default = <0x0>;
   xlnx,is-dual = <1>;
   xlnx,ip-name = "axi_gpio";
   xlnx,tri-default-2 = <0xffffffff>;
   reg = <0x00000201 0x02040000 0x0 0x1000>;
   xlnx,all-inputs-2 = <1>;
   clocks = <&versal_clk 65>;
   xlnx,all-outputs-2 = <0>;
   gpio-controller;
   xlnx,interrupt-present = <0>;
   xlnx,gpio2-board-interface = "Custom";
   xlnx,edk-iptype = "PERIPHERAL";
   xlnx,dout-default-2 = <0x0>;
   status = "okay";
   xlnx,gpio2-width = <1>;
   clock-names = "s_axi_aclk";
   xlnx,tri-default = <0xffffffff>;
   xlnx,name = "blp_blp_logic_base_clocking_force_reset_gpio";
   xlnx,all-inputs = <0>;
  };
  blp_blp_logic_base_clocking_pr_reset_gpio: gpio@80020000 {
   xlnx,gpio-board-interface = "Custom";
   compatible = "xlnx,axi-gpio-2.0" , "xlnx,xps-gpio-1.00.a";
   xlnx,all-outputs = <1>;
   #gpio-cells = <2>;
   xlnx,gpio-width = <2>;
   xlnx,rable = <0>;
   xlnx,dout-default = <0x0>;
   xlnx,is-dual = <1>;
   xlnx,ip-name = "axi_gpio";
   xlnx,tri-default-2 = <0xffffffff>;
   reg = <0x0 0x80020000 0x0 0x1000>;
   xlnx,all-inputs-2 = <1>;
   clocks = <&versal_clk 65>;
   xlnx,all-outputs-2 = <0>;
   gpio-controller;
   xlnx,interrupt-present = <0>;
   xlnx,gpio2-board-interface = "Custom";
   xlnx,edk-iptype = "PERIPHERAL";
   xlnx,dout-default-2 = <0x0>;
   status = "okay";
   xlnx,gpio2-width = <2>;
   clock-names = "s_axi_aclk";
   xlnx,tri-default = <0xffffffff>;
   xlnx,name = "blp_blp_logic_base_clocking_pr_reset_gpio";
   xlnx,all-inputs = <0>;
  };
  blp_blp_logic_gcq_m2r: cmd_queue@20102010000 {
   compatible = "xlnx,cmd-queue-2.0";
   interrupts = < 0 84 1 >;
   xlnx,rable = <0>;
   interrupt-parent = <&imux>;
   xlnx,ip-name = "cmd_queue";
   reg = <0x0 0x80010000 0x0 0x1000 0x00000201 0x02010000 0x0 0x1000>;
   clocks = <&versal_clk 65>;
   xlnx,s01-addr-width = <12>;
   xlnx,edk-iptype = "PERIPHERAL";
   status = "okay";
   clock-names = "aclk";
   xlnx,s00-addr-width = <12>;
   interrupt-names = "irq_sq";
   xlnx,name = "blp_blp_logic_gcq_m2r";
  };
  blp_blp_logic_gcq_r2a: cmd_queue@80011000 {
   compatible = "xlnx,cmd-queue-2.0";
   interrupts = < 0 85 1 0 92 1 >;
   xlnx,rable = <0>;
   interrupt-parent = <&imux>;
   xlnx,ip-name = "cmd_queue";
   reg = <0x0 0x80011000 0x0 0x1000 0x00000004 0x02000000 0x0 0x1000>;
   clocks = <&versal_clk 65>;
   xlnx,s01-addr-width = <12>;
   xlnx,edk-iptype = "PERIPHERAL";
   status = "okay";
   clock-names = "aclk";
   xlnx,s00-addr-width = <12>;
   interrupt-names = "irq_cq" , "irq_sq";
   xlnx,name = "blp_blp_logic_gcq_r2a";
  };
  blp_blp_logic_gcq_u2a_0: cmd_queue@20202010000 {
   compatible = "xlnx,cmd-queue-2.0";
   interrupts = < 0 0 >;
   xlnx,rable = <0>;
   interrupt-parent = <&blp_blp_logic_axi_intc_gcq_apu>;
   xlnx,ip-name = "cmd_queue";
   reg = <0x00000004 0x02010000 0x0 0x1000 0x00000202 0x02010000 0x0 0x1000>;
   clocks = <&versal_clk 65>;
   xlnx,s01-addr-width = <12>;
   xlnx,edk-iptype = "PERIPHERAL";
   status = "okay";
   clock-names = "aclk";
   xlnx,s00-addr-width = <12>;
   interrupt-names = "irq_sq";
   xlnx,name = "blp_blp_logic_gcq_u2a_0";
  };
  blp_blp_logic_hw_discovery: hw_discovery@20102001000 {
   xlnx,xdevicefamily = "versal";
   xlnx,pf2-entry-major-version-5 = <0>;
   xlnx,pf0-entry-type-1 = <0x53>;
   xlnx,pf1-entry-bar-5 = <0>;
   xlnx,pf2-entry-major-version-6 = <0>;
   xlnx,pf0-entry-type-2 = <0x55>;
   xlnx,pf1-entry-bar-6 = <0>;
   xlnx,pf2-entry-major-version-7 = <0>;
   xlnx,pf2-entry-addr-0 = <0x0>;
   xlnx,pf0-entry-type-3 = <0x50>;
   xlnx,pf1-entry-bar-7 = <0>;
   xlnx,pf2-entry-major-version-8 = <0>;
   xlnx,pf2-entry-addr-1 = <0x0>;
   xlnx,pf0-entry-type-4 = <0x0>;
   xlnx,pf1-entry-bar-8 = <0>;
   xlnx,pf2-entry-major-version-9 = <0>;
   xlnx,pf2-entry-addr-2 = <0x0>;
   xlnx,pf0-entry-type-5 = <0x0>;
   xlnx,pf1-entry-bar-9 = <0>;
   xlnx,pf3-entry-major-version-10 = <0>;
   xlnx,pf2-entry-addr-3 = <0x0>;
   xlnx,pf0-entry-type-6 = <0x0>;
   xlnx,pf3-entry-major-version-11 = <0>;
   xlnx,pf2-entry-addr-4 = <0x0>;
   reg = <0x00000201 0x02001000 0x0 0x1000 0x00000202 0x02001000 0x0 0x1000>;
   xlnx,pf0-entry-type-7 = <0x0>;
   xlnx,pf3-entry-major-version-12 = <0>;
   xlnx,pf2-entry-addr-5 = <0x0>;
   xlnx,pf0-entry-type-8 = <0x0>;
   xlnx,pf3-entry-major-version-13 = <0>;
   xlnx,pf2-entry-addr-6 = <0x0>;
   xlnx,pf0-entry-type-9 = <0x0>;
   xlnx,pf3-entry-major-version-14 = <0>;
   xlnx,pf2-entry-addr-7 = <0x0>;
   xlnx,pf3-entry-major-version-15 = <0>;
   xlnx,pf2-entry-addr-8 = <0x0>;
   xlnx,pf2-entry-addr-9 = <0x0>;
   xlnx,pf2-entry-major-version-10 = <0>;
   xlnx,pf1-entry-bar-10 = <0>;
   xlnx,pf2-entry-major-version-11 = <0>;
   xlnx,pf1-entry-bar-11 = <0>;
   xlnx,pf2-entry-major-version-12 = <0>;
   xlnx,pf1-entry-bar-12 = <0>;
   xlnx,pf2-entry-major-version-13 = <0>;
   xlnx,pf1-entry-bar-13 = <0>;
   xlnx,pf2-entry-major-version-14 = <0>;
   xlnx,pf1-low-offset = <0x200100>;
   xlnx,pf0-s-axi-addr-width = <32>;
   xlnx,pf1-entry-bar-14 = <0>;
   xlnx,pf2-entry-major-version-15 = <0>;
   xlnx,pf1-entry-bar-15 = <0>;
   xlnx,pf1-entry-version-type-0 = <0x1>;
   xlnx,pf1-entry-major-version-10 = <0>;
   xlnx,pf1-entry-version-type-1 = <0x0>;
   xlnx,pf0-entry-rsvd0-0 = <0x0>;
   xlnx,pf1-entry-major-version-11 = <0>;
   xlnx,pf2-endpoint-names = <0>;
   xlnx,pf1-entry-version-type-2 = <0x0>;
   xlnx,pf0-entry-rsvd0-1 = <0x3>;
   xlnx,pf1-entry-major-version-12 = <0>;
   xlnx,pf1-entry-version-type-3 = <0x0>;
   xlnx,pf0-entry-rsvd0-2 = <0x0>;
   xlnx,pf1-entry-major-version-13 = <0>;
   xlnx,pf1-entry-version-type-4 = <0x0>;
   xlnx,pf0-entry-rsvd0-3 = <0x0>;
   xlnx,pf1-entry-major-version-14 = <0>;
   xlnx,pf3-entry-rsvd0-10 = <0x0>;
   xlnx,pf1-entry-version-type-5 = <0x0>;
   xlnx,pf0-entry-rsvd0-4 = <0x0>;
   xlnx,pf1-entry-major-version-15 = <0>;
   xlnx,pf3-entry-rsvd0-11 = <0x0>;
   xlnx,pf1-entry-version-type-6 = <0x0>;
   xlnx,pf0-entry-major-version-0 = <1>;
   xlnx,pf0-entry-rsvd0-5 = <0x0>;
   xlnx,pf1-entry-addr-0 = <0x2000000>;
   xlnx,pf3-entry-rsvd0-12 = <0x0>;
   xlnx,pf1-entry-version-type-7 = <0x0>;
   xlnx,pf0-entry-major-version-10 = <0>;
   xlnx,pf0-entry-major-version-1 = <1>;
   xlnx,pf0-entry-bar-0 = <0>;
   xlnx,pf0-entry-rsvd0-6 = <0x0>;
   xlnx,pf1-entry-addr-1 = <0x0>;
   xlnx,pf1-entry-addr-10 = <0x0>;
   xlnx,pf3-entry-rsvd0-13 = <0x0>;
   xlnx,pf1-entry-version-type-8 = <0x0>;
   xlnx,pf0-entry-major-version-11 = <0>;
   xlnx,pf0-entry-bar-1 = <0>;
   xlnx,pf0-entry-major-version-2 = <1>;
   xlnx,pf0-entry-rsvd0-7 = <0x0>;
   xlnx,pf1-entry-addr-11 = <0x0>;
   xlnx,pf1-entry-addr-2 = <0x0>;
   xlnx,pf3-entry-rsvd0-14 = <0x0>;
   xlnx,pf1-entry-version-type-9 = <0x0>;
   xlnx,pf0-entry-bar-2 = <0>;
   xlnx,pf0-entry-major-version-12 = <0>;
   xlnx,pf0-entry-major-version-3 = <0>;
   xlnx,pf0-entry-rsvd0-8 = <0x0>;
   xlnx,pf1-entry-addr-12 = <0x0>;
   xlnx,pf1-entry-addr-3 = <0x0>;
   xlnx,pf3-entry-rsvd0-15 = <0x0>;
   xlnx,pf0-entry-bar-3 = <0>;
   xlnx,pf0-entry-major-version-13 = <0>;
   xlnx,pf0-entry-major-version-4 = <0>;
   xlnx,pf0-entry-rsvd0-9 = <0x0>;
   xlnx,pf1-entry-addr-13 = <0x0>;
   xlnx,pf1-entry-addr-4 = <0x0>;
   xlnx,pf0-entry-bar-4 = <0>;
   xlnx,pf0-entry-major-version-14 = <0>;
   xlnx,pf0-entry-major-version-5 = <0>;
   xlnx,pf1-entry-addr-14 = <0x0>;
   xlnx,pf1-entry-addr-5 = <0x0>;
   xlnx,pf0-entry-bar-5 = <0>;
   xlnx,name = "blp_blp_logic_hw_discovery";
   xlnx,pf0-entry-major-version-15 = <0>;
   xlnx,pf0-entry-major-version-6 = <0>;
   xlnx,pf1-entry-addr-15 = <0x0>;
   xlnx,pf1-entry-addr-6 = <0x0>;
   xlnx,pf0-entry-bar-6 = <0>;
   xlnx,pf0-entry-major-version-7 = <0>;
   xlnx,pf1-entry-addr-7 = <0x0>;
   xlnx,pf0-entry-bar-7 = <0>;
   xlnx,pf0-entry-major-version-8 = <0>;
   xlnx,pf1-entry-addr-8 = <0x0>;
   xlnx,pf2-s-axi-addr-width = <32>;
   xlnx,pf0-entry-bar-8 = <0>;
   xlnx,pf0-entry-major-version-9 = <0>;
   xlnx,pf1-entry-addr-9 = <0x0>;
   xlnx,pf0-entry-bar-9 = <0>;
   xlnx,pf0-entry-bar-10 = <0>;
   xlnx,pf0-entry-bar-11 = <0>;
   xlnx,pf0-entry-bar-12 = <0>;
   xlnx,pf0-entry-bar-13 = <0>;
   xlnx,pf0-entry-bar-14 = <0>;
   xlnx,pf3-num-slots-bar-layout-table = <1>;
   xlnx,pf0-entry-bar-15 = <0>;
   xlnx,pf2-low-offset = <0x0>;
   clock-names = "aclk_ctrl" , "aclk_pcie";
   xlnx,pf0-entry-addr-0 = <0x2010000>;
   xlnx,pf0-entry-type-10 = <0x0>;
   xlnx,pf3-entry-minor-version-10 = <0>;
   xlnx,pf0-entry-addr-1 = <0x2000000>;
   xlnx,pf0-entry-type-11 = <0x0>;
   xlnx,pf3-entry-minor-version-11 = <0>;
   xlnx,pf0-entry-addr-2 = <0x8000000>;
   xlnx,pf0-entry-type-12 = <0x0>;
   xlnx,pf3-entry-minor-version-12 = <0>;
   xlnx,pf0-entry-addr-3 = <0x2002000>;
   xlnx,pf0-entry-type-13 = <0x0>;
   xlnx,pf3-entry-minor-version-13 = <0>;
   xlnx,pf0-entry-addr-4 = <0x0>;
   xlnx,pf0-entry-type-14 = <0x0>;
   xlnx,pf3-entry-minor-version-14 = <0>;
   xlnx,pf0-entry-addr-5 = <0x0>;
   xlnx,pf0-entry-type-15 = <0x0>;
   xlnx,pf3-entry-minor-version-15 = <0>;
   xlnx,pf0-entry-addr-6 = <0x0>;
   xlnx,pf0-entry-addr-7 = <0x0>;
   xlnx,pf3-entry-minor-version-0 = <0>;
   xlnx,pf2-entry-minor-version-10 = <0>;
   xlnx,pf0-entry-addr-8 = <0x0>;
   xlnx,pf3-entry-minor-version-1 = <0>;
   xlnx,pf2-entry-minor-version-11 = <0>;
   xlnx,pf0-entry-addr-9 = <0x0>;
   xlnx,pf3-entry-minor-version-2 = <0>;
   xlnx,pf2-entry-minor-version-12 = <0>;
   xlnx,pf3-entry-minor-version-3 = <0>;
   xlnx,pf2-entry-minor-version-13 = <0>;
   xlnx,pf3-entry-minor-version-4 = <0>;
   xlnx,pf2-entry-version-type-0 = <0x0>;
   xlnx,pf2-entry-minor-version-14 = <0>;
   xlnx,pf3-entry-minor-version-5 = <0>;
   xlnx,pf2-entry-version-type-1 = <0x0>;
   xlnx,pf2-entry-minor-version-15 = <0>;
   xlnx,pf3-entry-minor-version-6 = <0>;
   xlnx,pf2-entry-version-type-2 = <0x0>;
   xlnx,pf3-entry-minor-version-7 = <0>;
   xlnx,pf2-entry-version-type-3 = <0x0>;
   xlnx,pf1-entry-minor-version-10 = <0>;
   xlnx,pf3-entry-minor-version-8 = <0>;
   xlnx,pf2-entry-version-type-4 = <0x0>;
   xlnx,pf1-s-axi-data-width = <32>;
   xlnx,pf1-entry-minor-version-11 = <0>;
   xlnx,pf3-entry-minor-version-9 = <0>;
   xlnx,pf2-entry-version-type-5 = <0x0>;
   xlnx,pf1-entry-minor-version-12 = <0>;
   xlnx,pf3-low-offset = <0x0>;
   xlnx,pf2-entry-version-type-6 = <0x0>;
   xlnx,pf1-entry-minor-version-13 = <0>;
   xlnx,pf2-entry-version-type-7 = <0x0>;
   xlnx,pf0-bar-index = <0>;
   xlnx,pf1-entry-minor-version-14 = <0>;
   xlnx,pf2-entry-version-type-8 = <0x0>;
   xlnx,pf1-entry-minor-version-15 = <0>;
   xlnx,pf2-entry-version-type-9 = <0x0>;
   xlnx,pf1-entry-rsvd0-0 = <0x1>;
   xlnx,pf1-entry-rsvd0-1 = <0x0>;
   xlnx,pf0-entry-minor-version-10 = <0>;
   xlnx,pf1-entry-rsvd0-2 = <0x0>;
   xlnx,pf0-entry-minor-version-11 = <0>;
   xlnx,pf1-entry-rsvd0-3 = <0x0>;
   xlnx,pf0-entry-minor-version-12 = <0>;
   xlnx,pf1-entry-rsvd0-4 = <0x0>;
   xlnx,pf0-entry-minor-version-13 = <0>;
   xlnx,pf1-entry-rsvd0-5 = <0x0>;
   xlnx,pf0-entry-minor-version-14 = <0>;
   xlnx,pf2-entry-addr-10 = <0x0>;
   xlnx,pf1-entry-rsvd0-6 = <0x0>;
   xlnx,pf0-entry-minor-version-15 = <0>;
   xlnx,pf2-entry-addr-11 = <0x0>;
   xlnx,pf1-entry-rsvd0-7 = <0x0>;
   xlnx,pf2-entry-addr-12 = <0x0>;
   xlnx,pf1-entry-rsvd0-8 = <0x0>;
   xlnx,pf2-entry-addr-13 = <0x0>;
   xlnx,pf1-entry-rsvd0-9 = <0x0>;
   xlnx,pf2-entry-addr-14 = <0x0>;
   xlnx,pf3-high-offset = <0x0>;
   xlnx,pf2-entry-addr-15 = <0x0>;
   xlnx,pf3-s-axi-data-width = <32>;
   xlnx,pf2-entry-version-type-10 = <0x0>;
   xlnx,pf2-entry-version-type-11 = <0x0>;
   xlnx,next-cap-addr = <0x0>;
   xlnx,pf1-entry-minor-version-0 = <0>;
   xlnx,pf2-entry-version-type-12 = <0x0>;
   xlnx,pf1-entry-minor-version-1 = <0>;
   xlnx,pf2-entry-version-type-13 = <0x0>;
   xlnx,pf1-entry-minor-version-2 = <0>;
   xlnx,pf2-entry-version-type-14 = <0x0>;
   xlnx,pf1-entry-minor-version-3 = <0>;
   xlnx,pf2-entry-version-type-15 = <0x0>;
   xlnx,pf1-entry-minor-version-4 = <0>;
   xlnx,pf1-entry-minor-version-5 = <0>;
   status = "okay";
   xlnx,pf1-endpoint-names = "ep_mailbox_user_00 {type 0x53 reserve 0x1}";
   xlnx,pf1-entry-minor-version-6 = <0>;
   xlnx,pf1-entry-minor-version-7 = <0>;
   xlnx,pf0-num-slots-bar-layout-table = <4>;
   xlnx,pf1-entry-minor-version-8 = <0>;
   xlnx,pf2-entry-rsvd0-10 = <0x0>;
   xlnx,pf1-entry-minor-version-9 = <0>;
   xlnx,pf2-entry-rsvd0-11 = <0x0>;
   xlnx,pf2-entry-rsvd0-12 = <0x0>;
   xlnx,pf1-entry-type-10 = <0x0>;
   xlnx,pf2-entry-rsvd0-13 = <0x0>;
   xlnx,pf1-entry-type-11 = <0x0>;
   xlnx,pf2-entry-rsvd0-14 = <0x0>;
   xlnx,pf1-entry-type-12 = <0x0>;
   xlnx,pf2-entry-rsvd0-15 = <0x0>;
   xlnx,pf1-entry-type-13 = <0x0>;
   xlnx,pf3-entry-version-type-0 = <0x0>;
   xlnx,pf2-bar-index = <0>;
   xlnx,pf1-entry-type-14 = <0x0>;
   xlnx,pf3-entry-version-type-1 = <0x0>;
   xlnx,pf1-entry-type-15 = <0x0>;
   xlnx,pf3-entry-version-type-2 = <0x0>;
   xlnx,pf3-entry-version-type-3 = <0x0>;
   xlnx,pf3-entry-version-type-4 = <0x0>;
   xlnx,edk-iptype = "PERIPHERAL";
   xlnx,pf3-entry-version-type-5 = <0x0>;
   xlnx,pf3-entry-version-type-6 = <0x0>;
   xlnx,pf3-entry-version-type-7 = <0x0>;
   xlnx,pf3-entry-major-version-0 = <0>;
   xlnx,pf3-entry-version-type-8 = <0x0>;
   xlnx,pf3-entry-major-version-1 = <0>;
   xlnx,pf3-entry-version-type-9 = <0x0>;
   xlnx,pf3-entry-major-version-2 = <0>;
   xlnx,pf3-entry-major-version-3 = <0>;
   xlnx,pf2-high-offset = <0x0>;
   xlnx,pf3-entry-major-version-4 = <0>;
   xlnx,pf3-entry-major-version-5 = <0>;
   xlnx,pf3-entry-major-version-6 = <0>;
   xlnx,pf3-entry-major-version-7 = <0>;
   xlnx,pf0-entry-version-type-10 = <0x0>;
   xlnx,pf3-entry-major-version-8 = <0>;
   xlnx,inject-endpoints = <0>;
   xlnx,pf0-entry-version-type-11 = <0x0>;
   xlnx,pf3-entry-major-version-9 = <0>;
   xlnx,pf0-entry-version-type-12 = <0x0>;
   xlnx,pf2-entry-rsvd0-0 = <0x0>;
   xlnx,pf0-entry-version-type-13 = <0x0>;
   xlnx,pf2-entry-rsvd0-1 = <0x0>;
   xlnx,pf0-entry-version-type-14 = <0x0>;
   xlnx,pf2-entry-rsvd0-2 = <0x0>;
   xlnx,pf0-entry-version-type-15 = <0x0>;
   xlnx,pf2-entry-rsvd0-3 = <0x0>;
   xlnx,pf2-entry-rsvd0-4 = <0x0>;
   xlnx,pf2-entry-rsvd0-5 = <0x0>;
   xlnx,pf3-entry-addr-10 = <0x0>;
   xlnx,pf2-entry-rsvd0-6 = <0x0>;
   xlnx,num-pfs = <2>;
   xlnx,pf3-entry-addr-11 = <0x0>;
   xlnx,pf2-entry-rsvd0-7 = <0x0>;
   xlnx,pf3-entry-addr-12 = <0x0>;
   xlnx,pf2-entry-rsvd0-8 = <0x0>;
   xlnx,pf3-entry-addr-13 = <0x0>;
   xlnx,pf2-entry-rsvd0-9 = <0x0>;
   xlnx,pf3-entry-addr-14 = <0x0>;
   xlnx,pf3-entry-addr-15 = <0x0>;
   xlnx,pf1-entry-major-version-0 = <1>;
   xlnx,pf1-entry-major-version-1 = <0>;
   xlnx,pf1-entry-major-version-2 = <0>;
   xlnx,pf1-entry-major-version-3 = <0>;
   xlnx,pf1-high-offset = <0x0>;
   xlnx,pf1-entry-major-version-4 = <0>;
   xlnx,pf2-num-slots-bar-layout-table = <1>;
   xlnx,pf1-entry-major-version-5 = <0>;
   compatible = "xlnx,hw-discovery-1.0";
   xlnx,pf1-entry-major-version-6 = <0>;
   xlnx,pf1-entry-major-version-7 = <0>;
   xlnx,pf2-entry-type-10 = <0x0>;
   xlnx,pf1-entry-major-version-8 = <0>;
   xlnx,pf2-entry-type-11 = <0x0>;
   xlnx,pf1-entry-major-version-9 = <0>;
   xlnx,pf2-entry-type-12 = <0x0>;
   xlnx,pf2-entry-type-13 = <0x0>;
   xlnx,pf2-entry-type-14 = <0x0>;
   xlnx,pf2-entry-type-15 = <0x0>;
   xlnx,pf1-s-axi-addr-width = <32>;
   xlnx,pf0-endpoint-names = "ep_blp_rom_00 {type 0x50 reserve 0x0} ep_mailbox_mgmt_00 {type 0x53 reserve 0x3} ep_xgq_mgmt_to_rpu_sq_pi_00 {type 0x54 reserve 0x0} ep_xgq_payload_mgmt_00 {type 0x55 reserve 0x0}";
   xlnx,pf1-entry-rsvd0-10 = <0x0>;
   xlnx,pf3-entry-rsvd0-0 = <0x0>;
   xlnx,pf1-entry-rsvd0-11 = <0x0>;
   xlnx,pf3-entry-rsvd0-1 = <0x0>;
   xlnx,pf1-entry-rsvd0-12 = <0x0>;
   xlnx,pf3-entry-rsvd0-2 = <0x0>;
   xlnx,pf1-entry-rsvd0-13 = <0x0>;
   xlnx,pf3-entry-rsvd0-3 = <0x0>;
   xlnx,pf1-entry-rsvd0-14 = <0x0>;
   xlnx,pf3-s-axi-addr-width = <32>;
   xlnx,pf3-entry-rsvd0-4 = <0x0>;
   xlnx,pf1-entry-rsvd0-15 = <0x0>;
   xlnx,pf3-entry-rsvd0-5 = <0x0>;
   xlnx,pf3-entry-rsvd0-6 = <0x0>;
   xlnx,pf0-high-offset = <0x0>;
   xlnx,pf3-entry-rsvd0-7 = <0x0>;
   xlnx,pf3-entry-rsvd0-8 = <0x0>;
   xlnx,pf3-entry-rsvd0-9 = <0x0>;
   xlnx,cap-base-addr = <0x600>;
   xlnx,pf0-s-axi-data-width = <32>;
   xlnx,pf3-entry-type-0 = <0x0>;
   xlnx,pf3-entry-type-1 = <0x0>;
   xlnx,pf3-entry-type-2 = <0x0>;
   xlnx,pf3-entry-type-3 = <0x0>;
   xlnx,pf3-entry-bar-0 = <0>;
   xlnx,pf3-entry-type-4 = <0x0>;
   xlnx,pf3-entry-bar-1 = <0>;
   xlnx,pf3-entry-type-5 = <0x0>;
   xlnx,pf3-entry-bar-2 = <0>;
   xlnx,pf3-entry-type-6 = <0x0>;
   xlnx,pf3-entry-bar-3 = <0>;
   xlnx,pf3-entry-type-7 = <0x0>;
   xlnx,pf3-entry-bar-4 = <0>;
   xlnx,pf3-entry-type-8 = <0x0>;
   xlnx,pf3-entry-bar-5 = <0>;
   xlnx,pf3-entry-type-9 = <0x0>;
   xlnx,pf3-entry-type-10 = <0x0>;
   xlnx,pf3-entry-bar-6 = <0>;
   xlnx,rable = <0>;
   xlnx,pf3-entry-type-11 = <0x0>;
   xlnx,pf3-entry-bar-7 = <0>;
   xlnx,pf3-entry-type-12 = <0x0>;
   xlnx,pf3-entry-bar-8 = <0>;
   xlnx,ip-name = "hw_discovery";
   xlnx,pf3-entry-version-type-10 = <0x0>;
   xlnx,pf3-entry-type-13 = <0x0>;
   xlnx,pf3-entry-bar-9 = <0>;
   xlnx,pf3-entry-version-type-11 = <0x0>;
   xlnx,pf3-entry-type-14 = <0x0>;
   xlnx,pf2-entry-minor-version-0 = <0>;
   xlnx,pf3-entry-version-type-12 = <0x0>;
   xlnx,pf3-entry-type-15 = <0x0>;
   xlnx,pf2-entry-minor-version-1 = <0>;
   xlnx,pf3-entry-version-type-13 = <0x0>;
   xlnx,pf2-s-axi-data-width = <32>;
   xlnx,pf2-entry-minor-version-2 = <0>;
   xlnx,pf3-entry-version-type-14 = <0x0>;
   xlnx,pf2-entry-minor-version-3 = <0>;
   xlnx,pf3-entry-version-type-15 = <0x0>;
   xlnx,pf2-entry-minor-version-4 = <0>;
   xlnx,pf2-entry-minor-version-5 = <0>;
   xlnx,pf2-entry-minor-version-6 = <0>;
   xlnx,pf3-endpoint-names = <0>;
   xlnx,pf2-entry-minor-version-7 = <0>;
   xlnx,pf2-entry-minor-version-8 = <0>;
   xlnx,pf2-entry-minor-version-9 = <0>;
   xlnx,pf2-entry-type-0 = <0x0>;
   xlnx,pf2-entry-type-1 = <0x0>;
   xlnx,pf2-entry-type-2 = <0x0>;
   xlnx,pf2-entry-type-3 = <0x0>;
   xlnx,pf1-bar-index = <2>;
   xlnx,pf2-entry-type-4 = <0x0>;
   xlnx,pf2-entry-type-5 = <0x0>;
   xlnx,pf2-entry-type-6 = <0x0>;
   xlnx,pf2-entry-type-7 = <0x0>;
   xlnx,pf2-entry-type-8 = <0x0>;
   xlnx,pf2-entry-type-9 = <0x0>;
   xlnx,pf2-entry-bar-0 = <0>;
   xlnx,pf2-entry-bar-1 = <0>;
   xlnx,pf3-entry-bar-10 = <0>;
   xlnx,pf2-entry-bar-2 = <0>;
   xlnx,pf3-entry-bar-11 = <0>;
   xlnx,pf2-entry-bar-3 = <0>;
   xlnx,pf3-entry-bar-12 = <0>;
   xlnx,pf2-entry-bar-4 = <0>;
   xlnx,pf3-entry-bar-13 = <0>;
   xlnx,pf2-entry-bar-5 = <0>;
   xlnx,pf3-entry-bar-14 = <0>;
   xlnx,pf2-entry-bar-6 = <0>;
   xlnx,pf3-entry-bar-15 = <0>;
   xlnx,pf2-entry-bar-7 = <0>;
   xlnx,pf2-entry-bar-8 = <0>;
   xlnx,pf1-entry-version-type-10 = <0x0>;
   xlnx,manual = <1>;
   xlnx,pf2-entry-bar-9 = <0>;
   xlnx,pf1-entry-version-type-11 = <0x0>;
   xlnx,pf0-entry-minor-version-0 = <2>;
   xlnx,pf1-entry-version-type-12 = <0x0>;
   xlnx,pf0-entry-minor-version-1 = <0>;
   clocks = <&versal_clk 65>, <&misc_clk_0>;
   xlnx,pf1-entry-version-type-13 = <0x0>;
   xlnx,pf0-entry-minor-version-2 = <0>;
   xlnx,pf1-entry-version-type-14 = <0x0>;
   xlnx,pf1-entry-type-0 = <0x53>;
   xlnx,pf0-entry-minor-version-3 = <0>;
   xlnx,pf1-entry-version-type-15 = <0x0>;
   xlnx,pf1-entry-type-1 = <0x0>;
   xlnx,pf0-entry-addr-10 = <0x0>;
   xlnx,pf0-entry-minor-version-4 = <0>;
   xlnx,pf1-entry-type-2 = <0x0>;
   xlnx,pf0-entry-addr-11 = <0x0>;
   xlnx,pf0-entry-minor-version-5 = <0>;
   xlnx,pf0-entry-version-type-0 = <0x1>;
   xlnx,pf3-entry-addr-0 = <0x0>;
   xlnx,pf1-entry-type-3 = <0x0>;
   xlnx,pf0-entry-addr-12 = <0x0>;
   xlnx,pf0-entry-minor-version-6 = <0>;
   xlnx,pf0-entry-version-type-1 = <0x1>;
   xlnx,pf3-entry-addr-1 = <0x0>;
   xlnx,pf1-entry-type-4 = <0x0>;
   xlnx,pf0-entry-addr-13 = <0x0>;
   xlnx,pf0-entry-minor-version-7 = <0>;
   xlnx,pf0-entry-version-type-2 = <0x1>;
   xlnx,pf3-entry-addr-2 = <0x0>;
   xlnx,pf1-entry-type-5 = <0x0>;
   xlnx,pf0-entry-addr-14 = <0x0>;
   xlnx,pf0-entry-minor-version-8 = <0>;
   xlnx,pf0-entry-rsvd0-10 = <0x0>;
   xlnx,pf0-entry-version-type-3 = <0x1>;
   xlnx,pf3-entry-addr-3 = <0x0>;
   xlnx,pf1-entry-type-6 = <0x0>;
   xlnx,pf0-entry-addr-15 = <0x0>;
   xlnx,pf0-entry-minor-version-9 = <0>;
   xlnx,pf0-entry-rsvd0-11 = <0x0>;
   xlnx,pf0-entry-version-type-4 = <0x0>;
   xlnx,pf3-entry-addr-4 = <0x0>;
   xlnx,pf1-entry-type-7 = <0x0>;
   xlnx,pf0-entry-rsvd0-12 = <0x0>;
   xlnx,pf0-entry-version-type-5 = <0x0>;
   xlnx,pf3-entry-addr-5 = <0x0>;
   xlnx,pf1-entry-type-8 = <0x0>;
   xlnx,pf0-entry-rsvd0-13 = <0x0>;
   xlnx,pf0-entry-version-type-6 = <0x0>;
   xlnx,pf3-entry-addr-6 = <0x0>;
   xlnx,pf1-entry-type-9 = <0x0>;
   xlnx,pf0-entry-rsvd0-14 = <0x0>;
   xlnx,pf0-entry-version-type-7 = <0x0>;
   xlnx,pf3-entry-addr-7 = <0x0>;
   xlnx,pf0-entry-rsvd0-15 = <0x0>;
   xlnx,pf0-entry-version-type-8 = <0x0>;
   xlnx,pf3-entry-addr-8 = <0x0>;
   xlnx,pf0-entry-version-type-9 = <0x0>;
   xlnx,pf3-entry-addr-9 = <0x0>;
   xlnx,pf2-entry-bar-10 = <0>;
   xlnx,pf3-bar-index = <0>;
   xlnx,pf2-entry-bar-11 = <0>;
   xlnx,pf1-num-slots-bar-layout-table = <1>;
   xlnx,pf2-entry-bar-12 = <0>;
   xlnx,pf0-low-offset = <0x200100>;
   xlnx,pf2-entry-bar-13 = <0>;
   xlnx,pf2-entry-bar-14 = <0>;
   xlnx,pf2-entry-bar-15 = <0>;
   xlnx,pf2-entry-major-version-0 = <0>;
   xlnx,pf1-entry-bar-0 = <2>;
   xlnx,pf2-entry-major-version-1 = <0>;
   xlnx,pf1-entry-bar-1 = <0>;
   xlnx,pf2-entry-major-version-2 = <0>;
   xlnx,pf1-entry-bar-2 = <0>;
   xlnx,pf2-entry-major-version-3 = <0>;
   xlnx,pf1-entry-bar-3 = <0>;
   xlnx,pf2-entry-major-version-4 = <0>;
   xlnx,pf0-entry-type-0 = <0x54>;
   xlnx,pf1-entry-bar-4 = <0>;
  };
  blp_blp_logic_pf_mailbox: mailbox@20102000000 {
   xlnx,s1-axi-aclk-freq-mhz = <0x5f5e0a4>;
   compatible = "xlnx,mailbox-2.1";
   xlnx,interconnect-port-0 = <2>;
   xlnx,interconnect-port-1 = <2>;
   xlnx,rable = <0>;
   xlnx,mailbox-depth = <16>;
   xlnx,s1-axi-data-width = <32>;
   xlnx,s0-axi-addr-width = <32>;
   xlnx,ip-name = "mailbox";
   reg = <0x00000201 0x02000000 0x0 0x1000 0x00000202 0x02000000 0x0 0x1000>;
   xlnx,async-clks = <0>;
   xlnx,impl-style = <0>;
   clocks = <&versal_clk 65>, <&versal_clk 65>;
   xlnx,read-clock-period-0 = <0>;
   xlnx,read-clock-period-1 = <0>;
   xlnx,num-sync-ff = <2>;
   xlnx,async-interrupts = <1>;
   xlnx,edk-iptype = "PERIPHERAL";
   xlnx,enable-bus-error = <0>;
   xlnx,s0-axi-data-width = <32>;
   status = "okay";
   xlnx,ext-reset-high = <1>;
   clock-names = "S0_AXI_ACLK" , "S1_AXI_ACLK";
   xlnx,s1-axi-addr-width = <32>;
   xlnx,s0-axi-aclk-freq-mhz = <0x5f5e0a4>;
   xlnx,name = "blp_blp_logic_pf_mailbox";
  };
  blp_blp_logic_pfm_irq_ctlr: pfm_irq_ctlr@80044000 {
   compatible = "xlnx,pfm-irq-ctlr-1.0";
   xlnx,rable = <0>;
   xlnx,num-of-irq-pf0 = <1>;
   xlnx,num-of-irq-pf1 = <1>;
   xlnx,ip-name = "pfm_irq_ctlr";
   xlnx,cpm-type = <0>;
   xlnx,num-of-pfs = <2>;
   xlnx,num-of-irq-pf2 = <32>;
   reg = <0x0 0x80044000 0x0 0x1000>;
   xlnx,addr-width = <10>;
   clocks = <&misc_clk_0>;
   xlnx,num-of-irq-pf3 = <32>;
   xlnx,edk-iptype = "PERIPHERAL";
   xlnx,axi-ctrl-en = <1>;
   xlnx,edge-select-pf0 = <0x0>;
   status = "okay";
   xlnx,edge-select-pf1 = <0x0>;
   clock-names = "aclk";
   xlnx,edge-select-pf2 = <0x0>;
   xlnx,max-pf-length = <32>;
   xlnx,edge-select-pf3 = <0x0>;
   xlnx,name = "blp_blp_logic_pfm_irq_ctlr";
  };
  blp_blp_logic_ulp_clocking_clkwiz_aclk_kernel_00: clk_wizard@80042000 {
   xlnx,reset-type = "ACTIVE_HIGH";
   xlnx,clk-out1-port = "clk_out1";
   xlnx,clkout1-actual-duty-cycle = <50>;
   xlnx,clkout2-phase = <0>;
   xlnx,clkout1-dyn-ps = <00>;
   xlnx,use-locked-deskew1 = <0>;
   xlnx,use-locked-deskew2 = <0>;
   xlnx,clkout3-drives = "BUFG";
   xlnx,deskew-delay1 = <0>;
   reg = <0x0 0x80042000 0x0 0x1000>;
   xlnx,deskew-delay2 = <0>;
   xlnx,clkin2-deskew-port = "clkin2_deskew";
   xlnx,clkout4-grouping = "Auto";
   xlnx,d-max = <107>;
   xlnx,divide6-auto = <0>;
   xlnx,clkout1-phase = <0>;
   xlnx,clkout2-requested-out-freq = <100>;
   xlnx,clkout7-divide = <12>;
   xlnx,use-locked = <1>;
   xlnx,clkin1-ibufds = <0>;
   xlnx,input-clk-stopped-port = "input_clk_stopped";
   xlnx,clkout1-drives = "No_buffer";
   xlnx,divide3-auto = <0>;
   xlnx,clkout4-duty-cycle = <0x7a120>;
   xlnx,clkout4-mbufgce-mode = "PERFORMANCE";
   xlnx,use-dyn-reconfig = <1>;
   xlnx,clkout6-actual-duty-cycle = <50>;
   xlnx,clkout6-requested-duty-cycle = <50>;
   xlnx,deskew2-in = <0>;
   xlnx,deskew1-fb = <1>;
   xlnx,clkin2-jitter-ps = <100>;
   xlnx,feedback-source = "FDBK_AUTO";
   xlnx,clkout5-requested-out-freq = <100>;
   xlnx,bufgce-div-ce-type = "SYNC";
   xlnx,name = "blp_blp_logic_ulp_clocking_clkwiz_aclk_kernel_00";
   xlnx,clkout5-divide = <12>;
   xlnx,current-path = "clk_wizard_v1_0";
   xlnx,prim-in-freq = <0x1fc9f08>;
   xlnx,clkout-matched-routing = "false,false,false,false,false,false,false";
   xlnx,deskew2-lock-circuit-en;
   xlnx,clk-in2-board-interface = "Custom";
   xlnx,clkin1-deskew-port = "clkin1_deskew";
   xlnx,clkin1-ui-jitter = <0x2710>;
   xlnx,clkout3-mbufgce-mode = "PERFORMANCE";
   xlnx,use-inclk-switchover = <0>;
   clock-names = "clk_in1" , "s_axi_aclk";
   xlnx,clkout3-divide = <12>;
   xlnx,clkout5-duty-cycle = <0x7a120>;
   xlnx,clkout1-grouping = "Auto";
   xlnx,use-dyn-phase-shift = <0>;
   xlnx,o-min = <3>;
   xlnx,daddr-port = "daddr";
   xlnx,clkout-grouping = "Auto,Auto,Auto,Auto,Auto,Auto,Auto";
   xlnx,clkin1-bufg = <0>;
   xlnx,precision = <1>;
   clock-output-names = "0x80042000-clk_out1";
   xlnx,clkout1-divide = <10>;
   xlnx,use-phase-alignment = <0>;
   xlnx,ref-clk-freq = <100>;
   xlnx,pllbufgcediv = <0>;
   xlnx,deskew1-in = <0>;
   xlnx,inclk-sum-row0 = "Input , Clock , Freq , (MHz) , Input , Jitter , (UI)";
   xlnx,clkout7-requested-duty-cycle = <50>;
   xlnx,inclk-sum-row1 = "primary , 100.000 , 0.010";
   xlnx,inclk-sum-row2 = "secondary , 100.000 , 0.010";
   xlnx,clkout2-mbufgce-mode = "PERFORMANCE";
   xlnx,din-port = "din";
   xlnx,reset-board-interface = "Custom";
   xlnx,clkout5-actual-duty-cycle = <50>;
   xlnx,clkout-requested-phase = "0.000,0.000,0.000,0.000,0.000,0.000,0.000";
   xlnx,clkout6-duty-cycle = <0x7a120>;
   xlnx,clkout1-requested-duty-cycle = <50>;
   xlnx,vco-max = <4320>;
   xlnx,use-freq-synth = <1>;
   xlnx,clkout5-used = <0>;
   xlnx,d-min = <1>;
   xlnx,clk-out6-port = "clk_out6";
   xlnx,clk-tree1 = <0>;
   xlnx,clkout2-sequence-number = <1>;
   xlnx,clkout-used = "true,false,false,false,false,false,false";
   xlnx,clk-tree2 = <0>;
   xlnx,clk-tree3 = <0>;
   xlnx,clkin1-period = <0x1c9c4ac>;
   xlnx,clkout2-used = <0>;
   xlnx,clkout4-sequence-number = <1>;
   xlnx,psincdec-port = "psincdec";
   xlnx,clk-tree4 = <0>;
   xlnx,clkfbin-ibuf = <0>;
   xlnx,clk-tree5 = <0>;
   xlnx,clk-out3-port = "clk_out3";
   xlnx,clkout6-sequence-number = <1>;
   xlnx,clkout-port = "clk_out1,clk_out2,clk_out3,clk_out4,clk_out5,clk_out6,clk_out7";
   xlnx,locked-deskew1-port = "locked_deskew1";
   xlnx,clk-tree6 = <0>;
   xlnx,clk-tree7 = <0>;
   xlnx,clkin2-ibuf = <0>;
   xlnx,clkfbout-fract = <0>;
   xlnx,clkout5-grouping = "Auto";
   xlnx,pllbufgcediv1 = <0>;
   xlnx,nr-outputs = <1>;
   xlnx,pllbufgcediv2 = <0>;
   xlnx,pllbufgcediv3 = <0>;
   xlnx,pllbufgcediv4 = <0>;
   xlnx,clkout1-mbufgce-mode = "PERFORMANCE";
   xlnx,clkfb-deskew-port = "clkfb_deskew";
   xlnx,clkout2-matched-routing = <0>;
   xlnx,safeclock-startup-mode = "DESKEW_MODE";
   xlnx,ref-jitter1 = <0x2710>;
   xlnx,ref-jitter2 = <0x2710>;
   status = "okay";
   xlnx,clkout4-matched-routing = <0>;
   xlnx,clkout6-dyn-ps = <00>;
   xlnx,clkout6-matched-routing = <0>;
   xlnx,clkout7-duty-cycle = <0x7a120>;
   xlnx,outclk-sum-row1 = "no , clk_out1 , output";
   xlnx,outclk-sum-row2 = "no , clk_out2 , output";
   xlnx,jitter-sel = "No_Jitter";
   xlnx,outclk-sum-row3 = "no , clk_out3 , output";
   xlnx,outclk-sum-row4 = "no , clk_out4 , output";
   xlnx,outclk-sum-row5 = "no , clk_out5 , output";
   xlnx,clkout7-actual-phase = <0>;
   xlnx,outclk-sum-row6 = "no , clk_out6 , output";
   xlnx,outclk-sum-row7 = "no , clk_out7 , output";
   xlnx,divide5-auto = <0>;
   xlnx,deskew-fb1 = <1>;
   xlnx,deskew-fb2 = <1>;
   xlnx,clkfbin-obuf = <0>;
   xlnx,psdone-port = "psdone";
   xlnx,edk-iptype = "PERIPHERAL";
   xlnx,clkout3-requested-out-freq = <100>;
   xlnx,divide2-auto = <0>;
   xlnx,clkout4-dyn-ps = <00>;
   xlnx,ss-mode = "CENTER_HIGH";
   xlnx,clkfbout-mult = <1>;
   xlnx,clkout-requested-duty-cycle = "50.000,50.000,50.000,50.000,50.000,50.000,50.000";
   xlnx,clkout6-drives = "BUFG";
   xlnx,ss-mod-period = <4000>;
   xlnx,clkout2-actual-out-freq = <0x5f5dd18>;
   xlnx,clkout2-requested-duty-cycle = <50>;
   xlnx,numbufgce = <0>;
   xlnx,clkout4-actual-duty-cycle = <50>;
   xlnx,clkout4-actual-out-freq = <0x5f5dd18>;
   xlnx,primary-port = "clk_in1";
   xlnx,clkout6-actual-out-freq = <0x5f5dd18>;
   xlnx,clkout6-requested-out-freq = <100>;
   xlnx,clkfbout-oddr = <0>;
   xlnx,use-locked-fb = <0>;
   xlnx,locked-fb-port = "locked_fb";
   xlnx,clkout2-requested-phase = <0>;
   xlnx,relative-inclk = "REL_PRIMARY";
   xlnx,clkout4-requested-phase = <0>;
   xlnx,enable-user-clock0 = <0>;
   xlnx,clkout2-dyn-ps = <00>;
   xlnx,clkout2-grouping = "Auto";
   xlnx,enable-user-clock1 = <0>;
   xlnx,clkout6-actual-phase = <0>;
   xlnx,clkout6-requested-phase = <0>;
   xlnx,clkout-requested-out-frequency = "300,100.000,100.000,100.000,100.000,100.000,100.000";
   xlnx,ss-mod-freq = <250>;
   xlnx,enable-user-clock2 = <0>;
   xlnx,enable-user-clock3 = <0>;
   xlnx,primitive-type = "MMCM";
   xlnx,ce-sync-ext = <0>;
   xlnx,clkout4-drives = "BUFG";
   xlnx,den-port = "den";
   xlnx,use-safe-clock-startup = <0>;
   xlnx,dwe-port = "dwe";
   xlnx,drdy-port = "drdy";
   xlnx,vco-min = <2160>;
   xlnx,clk-in-sel-port = "clk_in_sel";
   xlnx,clkin1-jitter-ps = <100>;
   xlnx,deskew-delay-path1;
   xlnx,deskew-delay-path2;
   xlnx,enable-pll0 = <0>;
   xlnx,enable-pll1 = <0>;
   xlnx,clkin2-ibufds = <0>;
   xlnx,clkfb2-deskew-port = "clkfb2_deskew";
   xlnx,clkout2-drives = "BUFG";
   xlnx,use-inclk-stopped = <0>;
   compatible = "xlnx,clk-wizard-1.0" , "xlnx,versal-clk-wizard";
   xlnx,clkout5-actual-phase = <0>;
   xlnx,reset-port = "reset";
   xlnx,sim-device = "VERSAL_AI_EDGE";
   xlnx,speed-grade = <2>;
   xlnx,clkout6-divide = <12>;
   xlnx,clkout3-requested-duty-cycle = <50>;
   xlnx,prim-source = "No_buffer";
   xlnx,clkout7-used = <0>;
   xlnx,deskew1-delay-en;
   xlnx,use-clkfb-stopped = <0>;
   xlnx,clkout6-grouping = "Auto";
   xlnx,compensation = "AUTO";
   xlnx,mmcmbufgcediv = <0>;
   xlnx,clkin-deskew-port = "clkin_deskew";
   xlnx,clkout3-actual-duty-cycle = <50>;
   xlnx,clkout4-used = <0>;
   xlnx,clk-out5-port = "clk_out5";
   xlnx,psclk-port = "psclk";
   xlnx,ce-type = "SYNC";
   xlnx,clkfbout-phase = <0>;
   xlnx,clkout4-divide = <12>;
   xlnx,primitive = "MMCM";
   xlnx,clkout1-used = <1>;
   xlnx,deskew1-lock-circuit-en;
   xlnx,clk-in1-board-interface = "Custom";
   xlnx,clk-out2-port = "clk_out2";
   xlnx,clkout4-actual-phase = <0>;
   xlnx,power-down-port = "power_down";
   xlnx,clkfb1-deskew-port = "clkfb1_deskew";
   xlnx,bandwidth = "OPTIMIZED";
   xlnx,clkin1-ibuf = <0>;
   xlnx,user-clk-freq0 = <100>;
   xlnx,deskew1-delay-path = "ClkFb_Path";
   xlnx,user-clk-freq1 = <100>;
   xlnx,clkoutfb-phase-ctrl = <00>;
   xlnx,user-clk-freq2 = <100>;
   xlnx,user-clk-freq3 = <100>;
   xlnx,use-clock-sequencing = <0>;
   xlnx,secondary-source = "Single_ended_clock_capable_pin";
   xlnx,cddcdone-port = "cddcdone";
   xlnx,clkout2-divide = <12>;
   xlnx,actual-vco = <0xb2cfe8d0>;
   xlnx,clkout7-phase = <0>;
   xlnx,psen-port = "psen";
   xlnx,m-max = <432>;
   xlnx,deskew-delay-en1;
   xlnx,dclk-port = "dclk";
   xlnx,deskew-delay-en2;
   xlnx,outclk-sum-row0a = "Output , Output , Phase , Duty , Pk-to-Pk , Phase";
   xlnx,divide7-auto = <0>;
   xlnx,clkout1-requested-out-freq = <100>;
   xlnx,outclk-sum-row0b = "Clock , Freq , (MHz) , (degrees) , Cycle , () , Jitter , (ps) , Error , (ps)";
   xlnx,locked-port = "locked";
   xlnx,enable-clock-monitor = <0>;
   xlnx,clkin2-ui-jitter = <0x2710>;
   xlnx,ss-mod-time = <0xfa0>;
   xlnx,divide4-auto = <0>;
   xlnx,auto-primitive = "MMCM";
   xlnx,drp-addr-set1 = "00000328 , 0000032c , 00000330 , 00000334 , 00000338 , 0000033c , 00000340 , 00000344 , 00000348 , 0000034c , 00000350 , 00000354 , 00000358 , 0000035c , 00000360 , 00000364 , 00000368 , 0000036c , 00000370 , 00000374 , 00000378 , 0000037c , 00000380 , 00000384 , 00000388 , 0000038c , 00000390 , 00000394 , 00000398 , 0000039c , 000003a0 , 000003a4 , 000003a8 , 000003ac , 000003b0 , 000003b4 , 000003b8 , 000003bc , 000003c0 , 000003c4 , 000003c8 , 000003cc , 000003d0 , 000003d4 , 000003d8 , 000003dc , 000003e0 , 000003e4 , 000003e8 , 000003ec , 000003f0 , 000003f4 , 000003f8 , 000003fc";
   xlnx,drp-addr-set2 = "00000328 , 0000032c , 00000330 , 00000334 , 00000338 , 0000033c , 00000340 , 00000344 , 00000348 , 0000034c , 00000350 , 00000354 , 00000358 , 0000035c , 00000360 , 00000364 , 00000368 , 0000036c , 00000370 , 00000374 , 00000378 , 0000037c , 00000380 , 00000384 , 00000388 , 0000038c , 00000390 , 00000394 , 00000398 , 0000039c , 000003a0 , 000003a4 , 000003a8 , 000003ac , 000003b0 , 000003b4 , 000003b8 , 000003bc , 000003c0 , 000003c4 , 000003c8 , 000003cc , 000003d0 , 000003d4 , 000003d8 , 000003dc , 000003e0 , 000003e4 , 000003e8 , 000003ec , 000003f0 , 000003f4 , 000003f8 , 000003fc";
   xlnx,drp-addr-set3 = "00000328 , 0000032c , 00000330 , 00000334 , 00000338 , 0000033c , 00000340 , 00000344 , 00000348 , 0000034c , 00000350 , 00000354 , 00000358 , 0000035c , 00000360 , 00000364 , 00000368 , 0000036c , 00000370 , 00000374 , 00000378 , 0000037c , 00000380 , 00000384 , 00000388 , 0000038c , 00000390 , 00000394 , 00000398 , 0000039c , 000003a0 , 000003a4 , 000003a8 , 000003ac , 000003b0 , 000003b4 , 000003b8 , 000003bc , 000003c0 , 000003c4 , 000003c8 , 000003cc , 000003d0 , 000003d4 , 000003d8 , 000003dc , 000003e0 , 000003e4 , 000003e8 , 000003ec , 000003f0 , 000003f4 , 000003f8 , 000003fc";
   xlnx,clkout3-actual-phase = <0>;
   xlnx,clkout-mbufgce-mode = "PERFORMANCE,PERFORMANCE,PERFORMANCE,PERFORMANCE,PERFORMANCE,PERFORMANCE,PERFORMANCE";
   xlnx,use-power-down = <1>;
   xlnx,divide1-auto = <0>;
   xlnx,clkout3-grouping = "Auto";
   xlnx,clkout4-requested-duty-cycle = <50>;
   xlnx,clkout4-requested-out-freq = <100>;
   xlnx,rable = <0>;
   xlnx,clkout6-phase = <0>;
   xlnx,num-out-clks = <1>;
   xlnx,ip-name = "clk_wizard";
   xlnx,auto-nummbufgce = <0>;
   xlnx,deskew-in1 = <0>;
   xlnx,deskew2-delay = <0>;
   xlnx,deskew-in2 = <0>;
   xlnx,mmcmbufgcediv1 = <0>;
   xlnx,deskew2-delay-path = "ClkFb_Path";
   xlnx,mmcmbufgcediv2 = <0>;
   xlnx,clkin2-period = <0x13de432>;
   xlnx,clkout1-duty-cycle = <0x7a120>;
   xlnx,mmcmbufgcediv3 = <0>;
   xlnx,mmcmbufgcediv4 = <0>;
   xlnx,mmcmbufgcediv5 = <0>;
   xlnx,dout-port = "dout";
   xlnx,mmcmbufgcediv6 = <0>;
   xlnx,clkout1-sequence-number = <1>;
   xlnx,mmcmbufgcediv7 = <0>;
   xlnx,cddcreq-port = "cddcreq";
   xlnx,clkout7-requested-out-freq = <100>;
   xlnx,use-spread-spectrum;
   xlnx,clkout3-sequence-number = <1>;
   xlnx,clkout7-mbufgce-mode = "PERFORMANCE";
   xlnx,clkout2-actual-duty-cycle = <50>;
   xlnx,clkout5-sequence-number = <1>;
   xlnx,clkout5-phase = <0>;
   xlnx,clkout7-sequence-number = <1>;
   xlnx,deskew1-delay = <0>;
   xlnx,clkfb-in-port = "clkfb_in";
   xlnx,zhold;
   xlnx,clkout2-actual-phase = <0>;
   xlnx,clkout7-dyn-ps = <00>;
   xlnx,deskew-lock-circuit-en1 = <0>;
   xlnx,clkout-dyn-ps = "None,None,None,None,None,None,None";
   xlnx,deskew-lock-circuit-en2 = <0>;
   xlnx,clkfbout-bufg = <0>;
   xlnx,clkout1-matched-routing = <0>;
   xlnx,interface-selection = <1>;
   xlnx,clkout3-matched-routing = <0>;
   xlnx,override-primitive = <0>;
   xlnx,calc-done = "empty";
   xlnx,clkout5-matched-routing = <0>;
   xlnx,clkfbin-obufds = <0>;
   xlnx,actual-pfd = <0xa98a58>;
   xlnx,clkout7-matched-routing = <0>;
   xlnx,clkin2-bufg = <0>;
   xlnx,clkout2-duty-cycle = <0x7a120>;
   xlnx,clkout4-phase = <0>;
   xlnx,clkout5-dyn-ps = <00>;
   xlnx,clkout6-mbufgce-mode = "PERFORMANCE";
   xlnx,clkout7-actual-duty-cycle = <50>;
   clocks = <&versal_clk 66>, <&versal_clk 66>;
   xlnx,deskew2-delay-en;
   xlnx,clkout7-grouping = "Auto";
   xlnx,clkfbin-ibufds = <0>;
   xlnx,clkfb-bufg = <0>;
   xlnx,clkout7-drives = "BUFG";
   xlnx,clkout-drives = "No_buffer,BUFG,BUFG,BUFG,BUFG,BUFG,BUFG";
   xlnx,clkout5-requested-duty-cycle = <50>;
   xlnx,drp-data-set1 = "4b06 , 0001 , 1600 , 8787 , 1b00 , 0202 , 0a00 , 0303 , 0a00 , 0303 , 0a00 , 0303 , f37c , 7c4d , d042 , ebd8 , ec5f , edfb , aacd , 4428 , 002f , 0000 , 0400 , 0101 , 000f , 0006 , 0000 , 0000 , 0e80 , 40e1 , 43e9 , 1188 , 0008 , 0001 , 0000 , 00c0 , 0dfd , 0961 , 0001 , 0000 , 068b , 0a00 , 0303 , 0a00 , 0303 , 0a00 , 0303 , 0000 , 0000 , 0000 , 0000 , 0000 , 0f00 , 0001";
   xlnx,divclk-divide = <3>;
   xlnx,clkfb-in-signaling = "SINGLE";
   xlnx,drp-data-set2 = "4b06 , 0001 , 1600 , 8787 , 1a00 , 0202 , 0b00 , 0101 , 0a00 , 0000 , 0a00 , 0101 , f37c , 7c4d , d042 , ebd8 , ec5f , edfb , aacd , 4428 , 002f , 0000 , 0400 , 0101 , 000f , 0006 , 0000 , 0000 , 0e80 , 40e1 , 43e9 , 1188 , 0008 , 0001 , 0000 , 00c0 , 0dfd , 0961 , 0001 , 0000 , 068b , 0a00 , 0303 , 0b00 , 0101 , 0a00 , 0202 , 0000 , 0000 , 0000 , 0000 , 0000 , 0f00 , 0001";
   xlnx,clkout1-actual-phase = <0>;
   xlnx,drp-data-set3 = "4b06 , 0001 , 1600 , 8787 , 1b00 , 0202 , 0a00 , 0303 , 0a00 , 0303 , 0a00 , 0303 , f37c , 7c4d , d042 , ebd8 , ec5f , edfb , aacd , 4428 , 002f , 0000 , 0400 , 0101 , 000f , 0006 , 0000 , 0000 , 0e80 , 40e1 , 43e9 , 1188 , 0008 , 0001 , 0000 , 00c0 , 0dfd , 0961 , 0001 , 0000 , 068b , 0a00 , 0303 , 0a00 , 0303 , 0a00 , 0303 , 0000 , 0000 , 0000 , 0000 , 0000 , 0f00 , 0001";
   xlnx,deskew2-fb = <1>;
   xlnx,secondary-port = "clk_in2";
   xlnx,clkout1-actual-out-freq = <0x11e19748>;
   xlnx,clkout3-phase = <0>;
   xlnx,numbufg = <0>;
   xlnx,clkout3-actual-out-freq = <0x5f5dd18>;
   xlnx,use-reset = <1>;
   xlnx,clkout3-dyn-ps = <00>;
   xlnx,m-min = <5>;
   xlnx,clkout5-actual-out-freq = <0x5f5dd18>;
   xlnx,clkout6-used = <0>;
   xlnx,perf-mode = "FULL";
   xlnx,clkfb-stopped-port = "clkfb_stopped";
   xlnx,clk-out7-port = "clk_out7";
   xlnx,clkout1-requested-phase = <0>;
   xlnx,clkout7-actual-out-freq = <0x5f5dd18>;
   xlnx,phaseshift-mode = "LATENCY";
   xlnx,clkfb-out-port = "clkfb_out";
   xlnx,clkout5-drives = "BUFG";
   xlnx,o-max = <432>;
   xlnx,clkout3-requested-phase = <0>;
   xlnx,jitter-options = "UI";
   xlnx,clkout3-used = <0>;
   xlnx,clkout5-requested-phase = <0>;
   xlnx,clk-out4-port = "clk_out4";
   xlnx,clkout3-duty-cycle = <0x7a120>;
   xlnx,locked-deskew2-port = "locked_deskew2";
   xlnx,clkout7-requested-phase = <0>;
   xlnx,secondary-in-freq = <48>;
   xlnx,clkout5-mbufgce-mode = "PERFORMANCE";
   xlnx,use-min-power = <0>;
   #clock-cells = <1>;
   xlnx,nummbufgce = <0>;
  };
  blp_blp_logic_ulp_clocking_clkwiz_aclk_kernel_01: clk_wizard@80043000 {
   xlnx,reset-type = "ACTIVE_HIGH";
   xlnx,clk-out1-port = "clk_out1";
   xlnx,clkout1-actual-duty-cycle = <50>;
   xlnx,clkout2-phase = <0>;
   xlnx,clkout1-dyn-ps = <00>;
   xlnx,use-locked-deskew1 = <0>;
   xlnx,use-locked-deskew2 = <0>;
   xlnx,clkout3-drives = "BUFG";
   xlnx,deskew-delay1 = <0>;
   reg = <0x0 0x80043000 0x0 0x1000>;
   xlnx,deskew-delay2 = <0>;
   xlnx,clkin2-deskew-port = "clkin2_deskew";
   xlnx,clkout4-grouping = "Auto";
   xlnx,d-max = <107>;
   xlnx,divide6-auto = <0>;
   xlnx,clkout1-phase = <0>;
   xlnx,clkout2-requested-out-freq = <100>;
   xlnx,clkout7-divide = <12>;
   xlnx,use-locked = <1>;
   xlnx,clkin1-ibufds = <0>;
   xlnx,input-clk-stopped-port = "input_clk_stopped";
   xlnx,clkout1-drives = "No_buffer";
   xlnx,divide3-auto = <0>;
   xlnx,clkout4-duty-cycle = <0x7a120>;
   xlnx,clkout4-mbufgce-mode = "PERFORMANCE";
   xlnx,use-dyn-reconfig = <1>;
   xlnx,clkout6-actual-duty-cycle = <50>;
   xlnx,clkout6-requested-duty-cycle = <50>;
   xlnx,deskew2-in = <0>;
   xlnx,deskew1-fb = <1>;
   xlnx,clkin2-jitter-ps = <100>;
   xlnx,feedback-source = "FDBK_AUTO";
   xlnx,clkout5-requested-out-freq = <100>;
   xlnx,bufgce-div-ce-type = "SYNC";
   xlnx,name = "blp_blp_logic_ulp_clocking_clkwiz_aclk_kernel_01";
   xlnx,clkout5-divide = <12>;
   xlnx,current-path = "clk_wizard_v1_0";
   xlnx,prim-in-freq = <0x1fc9f08>;
   xlnx,clkout-matched-routing = "false,false,false,false,false,false,false";
   xlnx,deskew2-lock-circuit-en;
   xlnx,clk-in2-board-interface = "Custom";
   xlnx,clkin1-deskew-port = "clkin1_deskew";
   xlnx,clkin1-ui-jitter = <0x2710>;
   xlnx,clkout3-mbufgce-mode = "PERFORMANCE";
   xlnx,use-inclk-switchover = <0>;
   clock-names = "clk_in1" , "s_axi_aclk";
   xlnx,clkout3-divide = <12>;
   xlnx,clkout5-duty-cycle = <0x7a120>;
   xlnx,clkout1-grouping = "Auto";
   xlnx,use-dyn-phase-shift = <0>;
   xlnx,o-min = <3>;
   xlnx,daddr-port = "daddr";
   xlnx,clkout-grouping = "Auto,Auto,Auto,Auto,Auto,Auto,Auto";
   xlnx,clkin1-bufg = <0>;
   xlnx,precision = <1>;
   clock-output-names = "0x80043000-clk_out1";
   xlnx,clkout1-divide = <12>;
   xlnx,use-phase-alignment = <0>;
   xlnx,ref-clk-freq = <100>;
   xlnx,pllbufgcediv = <0>;
   xlnx,deskew1-in = <0>;
   xlnx,inclk-sum-row0 = "Input , Clock , Freq , (MHz) , Input , Jitter , (UI)";
   xlnx,clkout7-requested-duty-cycle = <50>;
   xlnx,inclk-sum-row1 = "primary , 100.000 , 0.010";
   xlnx,inclk-sum-row2 = "secondary , 100.000 , 0.010";
   xlnx,clkout2-mbufgce-mode = "PERFORMANCE";
   xlnx,din-port = "din";
   xlnx,reset-board-interface = "Custom";
   xlnx,clkout5-actual-duty-cycle = <50>;
   xlnx,clkout-requested-phase = "0.000,0.000,0.000,0.000,0.000,0.000,0.000";
   xlnx,clkout6-duty-cycle = <0x7a120>;
   xlnx,clkout1-requested-duty-cycle = <50>;
   xlnx,vco-max = <4320>;
   xlnx,use-freq-synth = <1>;
   xlnx,clkout5-used = <0>;
   xlnx,d-min = <1>;
   xlnx,clk-out6-port = "clk_out6";
   xlnx,clk-tree1 = <0>;
   xlnx,clkout2-sequence-number = <1>;
   xlnx,clkout-used = "true,false,false,false,false,false,false";
   xlnx,clk-tree2 = <0>;
   xlnx,clk-tree3 = <0>;
   xlnx,clkin1-period = <0x1c9c4ac>;
   xlnx,clkout2-used = <0>;
   xlnx,clkout4-sequence-number = <1>;
   xlnx,psincdec-port = "psincdec";
   xlnx,clk-tree4 = <0>;
   xlnx,clkfbin-ibuf = <0>;
   xlnx,clk-tree5 = <0>;
   xlnx,clk-out3-port = "clk_out3";
   xlnx,clkout6-sequence-number = <1>;
   xlnx,clkout-port = "clk_out1,clk_out2,clk_out3,clk_out4,clk_out5,clk_out6,clk_out7";
   xlnx,locked-deskew1-port = "locked_deskew1";
   xlnx,clk-tree6 = <0>;
   xlnx,clk-tree7 = <0>;
   xlnx,clkin2-ibuf = <0>;
   xlnx,clkfbout-fract = <0>;
   xlnx,clkout5-grouping = "Auto";
   xlnx,pllbufgcediv1 = <0>;
   xlnx,nr-outputs = <1>;
   xlnx,pllbufgcediv2 = <0>;
   xlnx,pllbufgcediv3 = <0>;
   xlnx,pllbufgcediv4 = <0>;
   xlnx,clkout1-mbufgce-mode = "PERFORMANCE";
   xlnx,clkfb-deskew-port = "clkfb_deskew";
   xlnx,clkout2-matched-routing = <0>;
   xlnx,safeclock-startup-mode = "DESKEW_MODE";
   xlnx,ref-jitter1 = <0x2710>;
   xlnx,ref-jitter2 = <0x2710>;
   status = "okay";
   xlnx,clkout4-matched-routing = <0>;
   xlnx,clkout6-dyn-ps = <00>;
   xlnx,clkout6-matched-routing = <0>;
   xlnx,clkout7-duty-cycle = <0x7a120>;
   xlnx,outclk-sum-row1 = "no , clk_out1 , output";
   xlnx,outclk-sum-row2 = "no , clk_out2 , output";
   xlnx,jitter-sel = "No_Jitter";
   xlnx,outclk-sum-row3 = "no , clk_out3 , output";
   xlnx,outclk-sum-row4 = "no , clk_out4 , output";
   xlnx,outclk-sum-row5 = "no , clk_out5 , output";
   xlnx,clkout7-actual-phase = <0>;
   xlnx,outclk-sum-row6 = "no , clk_out6 , output";
   xlnx,outclk-sum-row7 = "no , clk_out7 , output";
   xlnx,divide5-auto = <0>;
   xlnx,deskew-fb1 = <1>;
   xlnx,deskew-fb2 = <1>;
   xlnx,clkfbin-obuf = <0>;
   xlnx,psdone-port = "psdone";
   xlnx,edk-iptype = "PERIPHERAL";
   xlnx,clkout3-requested-out-freq = <100>;
   xlnx,divide2-auto = <0>;
   xlnx,clkout4-dyn-ps = <00>;
   xlnx,ss-mode = "CENTER_HIGH";
   xlnx,clkfbout-mult = <1>;
   xlnx,clkout-requested-duty-cycle = "50.000,50.000,50.000,50.000,50.000,50.000,50.000";
   xlnx,clkout6-drives = "BUFG";
   xlnx,ss-mod-period = <4000>;
   xlnx,clkout2-actual-out-freq = <0x5f5dd18>;
   xlnx,clkout2-requested-duty-cycle = <50>;
   xlnx,numbufgce = <0>;
   xlnx,clkout4-actual-duty-cycle = <50>;
   xlnx,clkout4-actual-out-freq = <0x5f5dd18>;
   xlnx,primary-port = "clk_in1";
   xlnx,clkout6-actual-out-freq = <0x5f5dd18>;
   xlnx,clkout6-requested-out-freq = <100>;
   xlnx,clkfbout-oddr = <0>;
   xlnx,use-locked-fb = <0>;
   xlnx,locked-fb-port = "locked_fb";
   xlnx,clkout2-requested-phase = <0>;
   xlnx,relative-inclk = "REL_PRIMARY";
   xlnx,clkout4-requested-phase = <0>;
   xlnx,enable-user-clock0 = <0>;
   xlnx,clkout2-dyn-ps = <00>;
   xlnx,clkout2-grouping = "Auto";
   xlnx,enable-user-clock1 = <0>;
   xlnx,clkout6-actual-phase = <0>;
   xlnx,clkout6-requested-phase = <0>;
   xlnx,clkout-requested-out-frequency = "250,100.000,100.000,100.000,100.000,100.000,100.000";
   xlnx,ss-mod-freq = <250>;
   xlnx,enable-user-clock2 = <0>;
   xlnx,enable-user-clock3 = <0>;
   xlnx,primitive-type = "MMCM";
   xlnx,ce-sync-ext = <0>;
   xlnx,clkout4-drives = "BUFG";
   xlnx,den-port = "den";
   xlnx,use-safe-clock-startup = <0>;
   xlnx,dwe-port = "dwe";
   xlnx,drdy-port = "drdy";
   xlnx,vco-min = <2160>;
   xlnx,clk-in-sel-port = "clk_in_sel";
   xlnx,clkin1-jitter-ps = <100>;
   xlnx,deskew-delay-path1;
   xlnx,deskew-delay-path2;
   xlnx,enable-pll0 = <0>;
   xlnx,enable-pll1 = <0>;
   xlnx,clkin2-ibufds = <0>;
   xlnx,clkfb2-deskew-port = "clkfb2_deskew";
   xlnx,clkout2-drives = "BUFG";
   xlnx,use-inclk-stopped = <0>;
   compatible = "xlnx,clk-wizard-1.0" , "xlnx,versal-clk-wizard";
   xlnx,clkout5-actual-phase = <0>;
   xlnx,reset-port = "reset";
   xlnx,sim-device = "VERSAL_AI_EDGE";
   xlnx,speed-grade = <2>;
   xlnx,clkout6-divide = <12>;
   xlnx,clkout3-requested-duty-cycle = <50>;
   xlnx,prim-source = "No_buffer";
   xlnx,clkout7-used = <0>;
   xlnx,deskew1-delay-en;
   xlnx,use-clkfb-stopped = <0>;
   xlnx,clkout6-grouping = "Auto";
   xlnx,compensation = "AUTO";
   xlnx,mmcmbufgcediv = <0>;
   xlnx,clkin-deskew-port = "clkin_deskew";
   xlnx,clkout3-actual-duty-cycle = <50>;
   xlnx,clkout4-used = <0>;
   xlnx,clk-out5-port = "clk_out5";
   xlnx,psclk-port = "psclk";
   xlnx,ce-type = "SYNC";
   xlnx,clkfbout-phase = <0>;
   xlnx,clkout4-divide = <12>;
   xlnx,primitive = "MMCM";
   xlnx,clkout1-used = <1>;
   xlnx,deskew1-lock-circuit-en;
   xlnx,clk-in1-board-interface = "Custom";
   xlnx,clk-out2-port = "clk_out2";
   xlnx,clkout4-actual-phase = <0>;
   xlnx,power-down-port = "power_down";
   xlnx,clkfb1-deskew-port = "clkfb1_deskew";
   xlnx,bandwidth = "OPTIMIZED";
   xlnx,clkin1-ibuf = <0>;
   xlnx,user-clk-freq0 = <100>;
   xlnx,deskew1-delay-path = "ClkFb_Path";
   xlnx,user-clk-freq1 = <100>;
   xlnx,clkoutfb-phase-ctrl = <00>;
   xlnx,user-clk-freq2 = <100>;
   xlnx,user-clk-freq3 = <100>;
   xlnx,use-clock-sequencing = <0>;
   xlnx,secondary-source = "Single_ended_clock_capable_pin";
   xlnx,cddcdone-port = "cddcdone";
   xlnx,clkout2-divide = <12>;
   xlnx,actual-vco = <0xb2cfe8d0>;
   xlnx,clkout7-phase = <0>;
   xlnx,psen-port = "psen";
   xlnx,m-max = <432>;
   xlnx,deskew-delay-en1;
   xlnx,dclk-port = "dclk";
   xlnx,deskew-delay-en2;
   xlnx,outclk-sum-row0a = "Output , Output , Phase , Duty , Pk-to-Pk , Phase";
   xlnx,divide7-auto = <0>;
   xlnx,clkout1-requested-out-freq = <100>;
   xlnx,outclk-sum-row0b = "Clock , Freq , (MHz) , (degrees) , Cycle , () , Jitter , (ps) , Error , (ps)";
   xlnx,locked-port = "locked";
   xlnx,enable-clock-monitor = <0>;
   xlnx,clkin2-ui-jitter = <0x2710>;
   xlnx,ss-mod-time = <0xfa0>;
   xlnx,divide4-auto = <0>;
   xlnx,auto-primitive = "MMCM";
   xlnx,drp-addr-set1 = "00000328 , 0000032c , 00000330 , 00000334 , 00000338 , 0000033c , 00000340 , 00000344 , 00000348 , 0000034c , 00000350 , 00000354 , 00000358 , 0000035c , 00000360 , 00000364 , 00000368 , 0000036c , 00000370 , 00000374 , 00000378 , 0000037c , 00000380 , 00000384 , 00000388 , 0000038c , 00000390 , 00000394 , 00000398 , 0000039c , 000003a0 , 000003a4 , 000003a8 , 000003ac , 000003b0 , 000003b4 , 000003b8 , 000003bc , 000003c0 , 000003c4 , 000003c8 , 000003cc , 000003d0 , 000003d4 , 000003d8 , 000003dc , 000003e0 , 000003e4 , 000003e8 , 000003ec , 000003f0 , 000003f4 , 000003f8 , 000003fc";
   xlnx,drp-addr-set2 = "00000328 , 0000032c , 00000330 , 00000334 , 00000338 , 0000033c , 00000340 , 00000344 , 00000348 , 0000034c , 00000350 , 00000354 , 00000358 , 0000035c , 00000360 , 00000364 , 00000368 , 0000036c , 00000370 , 00000374 , 00000378 , 0000037c , 00000380 , 00000384 , 00000388 , 0000038c , 00000390 , 00000394 , 00000398 , 0000039c , 000003a0 , 000003a4 , 000003a8 , 000003ac , 000003b0 , 000003b4 , 000003b8 , 000003bc , 000003c0 , 000003c4 , 000003c8 , 000003cc , 000003d0 , 000003d4 , 000003d8 , 000003dc , 000003e0 , 000003e4 , 000003e8 , 000003ec , 000003f0 , 000003f4 , 000003f8 , 000003fc";
   xlnx,drp-addr-set3 = "00000328 , 0000032c , 00000330 , 00000334 , 00000338 , 0000033c , 00000340 , 00000344 , 00000348 , 0000034c , 00000350 , 00000354 , 00000358 , 0000035c , 00000360 , 00000364 , 00000368 , 0000036c , 00000370 , 00000374 , 00000378 , 0000037c , 00000380 , 00000384 , 00000388 , 0000038c , 00000390 , 00000394 , 00000398 , 0000039c , 000003a0 , 000003a4 , 000003a8 , 000003ac , 000003b0 , 000003b4 , 000003b8 , 000003bc , 000003c0 , 000003c4 , 000003c8 , 000003cc , 000003d0 , 000003d4 , 000003d8 , 000003dc , 000003e0 , 000003e4 , 000003e8 , 000003ec , 000003f0 , 000003f4 , 000003f8 , 000003fc";
   xlnx,clkout3-actual-phase = <0>;
   xlnx,clkout-mbufgce-mode = "PERFORMANCE,PERFORMANCE,PERFORMANCE,PERFORMANCE,PERFORMANCE,PERFORMANCE,PERFORMANCE";
   xlnx,use-power-down = <1>;
   xlnx,divide1-auto = <0>;
   xlnx,clkout3-grouping = "Auto";
   xlnx,clkout4-requested-duty-cycle = <50>;
   xlnx,clkout4-requested-out-freq = <100>;
   xlnx,rable = <0>;
   xlnx,clkout6-phase = <0>;
   xlnx,num-out-clks = <1>;
   xlnx,ip-name = "clk_wizard";
   xlnx,auto-nummbufgce = <0>;
   xlnx,deskew-in1 = <0>;
   xlnx,deskew2-delay = <0>;
   xlnx,deskew-in2 = <0>;
   xlnx,mmcmbufgcediv1 = <0>;
   xlnx,deskew2-delay-path = "ClkFb_Path";
   xlnx,mmcmbufgcediv2 = <0>;
   xlnx,clkin2-period = <0x13de432>;
   xlnx,clkout1-duty-cycle = <0x7a120>;
   xlnx,mmcmbufgcediv3 = <0>;
   xlnx,mmcmbufgcediv4 = <0>;
   xlnx,mmcmbufgcediv5 = <0>;
   xlnx,dout-port = "dout";
   xlnx,mmcmbufgcediv6 = <0>;
   xlnx,clkout1-sequence-number = <1>;
   xlnx,mmcmbufgcediv7 = <0>;
   xlnx,cddcreq-port = "cddcreq";
   xlnx,clkout7-requested-out-freq = <100>;
   xlnx,use-spread-spectrum;
   xlnx,clkout3-sequence-number = <1>;
   xlnx,clkout7-mbufgce-mode = "PERFORMANCE";
   xlnx,clkout2-actual-duty-cycle = <50>;
   xlnx,clkout5-sequence-number = <1>;
   xlnx,clkout5-phase = <0>;
   xlnx,clkout7-sequence-number = <1>;
   xlnx,deskew1-delay = <0>;
   xlnx,clkfb-in-port = "clkfb_in";
   xlnx,zhold;
   xlnx,clkout2-actual-phase = <0>;
   xlnx,clkout7-dyn-ps = <00>;
   xlnx,deskew-lock-circuit-en1 = <0>;
   xlnx,clkout-dyn-ps = "None,None,None,None,None,None,None";
   xlnx,deskew-lock-circuit-en2 = <0>;
   xlnx,clkfbout-bufg = <0>;
   xlnx,clkout1-matched-routing = <0>;
   xlnx,interface-selection = <1>;
   xlnx,clkout3-matched-routing = <0>;
   xlnx,override-primitive = <0>;
   xlnx,calc-done = "empty";
   xlnx,clkout5-matched-routing = <0>;
   xlnx,clkfbin-obufds = <0>;
   xlnx,actual-pfd = <0xa98a58>;
   xlnx,clkout7-matched-routing = <0>;
   xlnx,clkin2-bufg = <0>;
   xlnx,clkout2-duty-cycle = <0x7a120>;
   xlnx,clkout4-phase = <0>;
   xlnx,clkout5-dyn-ps = <00>;
   xlnx,clkout6-mbufgce-mode = "PERFORMANCE";
   xlnx,clkout7-actual-duty-cycle = <50>;
   clocks = <&versal_clk 66>, <&versal_clk 66>;
   xlnx,deskew2-delay-en;
   xlnx,clkout7-grouping = "Auto";
   xlnx,clkfbin-ibufds = <0>;
   xlnx,clkfb-bufg = <0>;
   xlnx,clkout7-drives = "BUFG";
   xlnx,clkout-drives = "No_buffer,BUFG,BUFG,BUFG,BUFG,BUFG,BUFG";
   xlnx,clkout5-requested-duty-cycle = <50>;
   xlnx,drp-data-set1 = "4b06 , 0001 , 1600 , 8787 , 1a00 , 0303 , 0a00 , 0303 , 0a00 , 0303 , 0a00 , 0303 , f37c , 7c4d , d042 , ebd8 , ec5f , edfb , aacd , 4428 , 002f , 0000 , 0400 , 0101 , 000f , 0006 , 0000 , 0000 , 0e80 , 40e1 , 43e9 , 1188 , 0008 , 0001 , 0000 , 00c0 , 0dfd , 0961 , 0001 , 0000 , 068b , 0a00 , 0303 , 0a00 , 0303 , 0a00 , 0303 , 0000 , 0000 , 0000 , 0000 , 0000 , 0f00 , 0001";
   xlnx,divclk-divide = <3>;
   xlnx,clkfb-in-signaling = "SINGLE";
   xlnx,drp-data-set2 = "4b06 , 0001 , 1600 , 8787 , 1a00 , 0202 , 0b00 , 0101 , 0a00 , 0000 , 0a00 , 0101 , f37c , 7c4d , d042 , ebd8 , ec5f , edfb , aacd , 4428 , 002f , 0000 , 0400 , 0101 , 000f , 0006 , 0000 , 0000 , 0e80 , 40e1 , 43e9 , 1188 , 0008 , 0001 , 0000 , 00c0 , 0dfd , 0961 , 0001 , 0000 , 068b , 0a00 , 0303 , 0b00 , 0101 , 0a00 , 0202 , 0000 , 0000 , 0000 , 0000 , 0000 , 0f00 , 0001";
   xlnx,clkout1-actual-phase = <0>;
   xlnx,drp-data-set3 = "4b06 , 0001 , 1600 , 8787 , 1a00 , 0303 , 0a00 , 0303 , 0a00 , 0303 , 0a00 , 0303 , f37c , 7c4d , d042 , ebd8 , ec5f , edfb , aacd , 4428 , 002f , 0000 , 0400 , 0101 , 000f , 0006 , 0000 , 0000 , 0e80 , 40e1 , 43e9 , 1188 , 0008 , 0001 , 0000 , 00c0 , 0dfd , 0961 , 0001 , 0000 , 068b , 0a00 , 0303 , 0a00 , 0303 , 0a00 , 0303 , 0000 , 0000 , 0000 , 0000 , 0000 , 0f00 , 0001";
   xlnx,deskew2-fb = <1>;
   xlnx,secondary-port = "clk_in2";
   xlnx,clkout1-actual-out-freq = <0xee6a8bc>;
   xlnx,clkout3-phase = <0>;
   xlnx,numbufg = <0>;
   xlnx,clkout3-actual-out-freq = <0x5f5dd18>;
   xlnx,use-reset = <1>;
   xlnx,clkout3-dyn-ps = <00>;
   xlnx,m-min = <5>;
   xlnx,clkout5-actual-out-freq = <0x5f5dd18>;
   xlnx,clkout6-used = <0>;
   xlnx,perf-mode = "FULL";
   xlnx,clkfb-stopped-port = "clkfb_stopped";
   xlnx,clk-out7-port = "clk_out7";
   xlnx,clkout1-requested-phase = <0>;
   xlnx,clkout7-actual-out-freq = <0x5f5dd18>;
   xlnx,phaseshift-mode = "LATENCY";
   xlnx,clkfb-out-port = "clkfb_out";
   xlnx,clkout5-drives = "BUFG";
   xlnx,o-max = <432>;
   xlnx,clkout3-requested-phase = <0>;
   xlnx,jitter-options = "UI";
   xlnx,clkout3-used = <0>;
   xlnx,clkout5-requested-phase = <0>;
   xlnx,clk-out4-port = "clk_out4";
   xlnx,clkout3-duty-cycle = <0x7a120>;
   xlnx,locked-deskew2-port = "locked_deskew2";
   xlnx,clkout7-requested-phase = <0>;
   xlnx,secondary-in-freq = <48>;
   xlnx,clkout5-mbufgce-mode = "PERFORMANCE";
   xlnx,use-min-power = <0>;
   #clock-cells = <1>;
   xlnx,nummbufgce = <0>;
  };
  blp_blp_logic_ulp_clocking_shell_utils_ucc: shell_utils_ucc@80030000 {
   compatible = "xlnx,shell-utils-ucc-1.0";
   xlnx,ext-tog-enable = <1>;
   xlnx,num-clocks = <2>;
   xlnx,rable = <0>;
   xlnx,ip-name = "shell_utils_ucc";
   reg = <0x0 0x80030000 0x0 0x10000>;
   xlnx,freq-cnt-ref-clk-hz = <33333>;
   clocks = <&versal_clk 65>, <&versal_clk 66>, <&misc_clk_0>, <&blp_blp_logic_ulp_clocking_clkwiz_aclk_kernel_00 0>, <&blp_blp_logic_ulp_clocking_clkwiz_aclk_kernel_01 0>;
   xlnx,edk-iptype = "PERIPHERAL";
   status = "okay";
   clock-names = "aclk_ctrl" , "aclk_freerun" , "aclk_pcie" , "clk_in_kernel_00" , "clk_in_kernel_01";
   xlnx,name = "blp_blp_logic_ulp_clocking_shell_utils_ucc";
  };
  blp_blp_logic_uuid_register: uuid_register@20102002000 {
   xlnx,rable = <0>;
   compatible = "xlnx,uuid-register-1.0";
   status = "okay";
   clock-names = "S_AXI_ACLK";
   xlnx,ip-name = "uuid_register";
   xlnx,edk-iptype = "PERIPHERAL";
   reg = <0x0 0x80045000 0x0 0x1000 0x00000201 0x02002000 0x0 0x1000>;
   clocks = <&versal_clk 65>;
   xlnx,name = "blp_blp_logic_uuid_register";
  };
  blp_qdma_0: axi-pcie@20107000000 {
   xlnx,num-vfs-pf3 = <0>;
   xlnx,dbg-en = "DEBUG_NONE";
   xlnx,pf0-bar1-control = <0x0>;
   xlnx,pf3-bar6-control = <0x0>;
   reg = <0x00000201 0x07000000 0x0 0x4000>;
   xlnx,pf1-msix-cap-pba-bir-qdma = "BAR_1:0";
   xlnx,pf0-sriov-bar3-control = <0x0>;
   xlnx,pf2-sriov-bar2-scale = "Kilobytes";
   xlnx,pf2-bar1-type-qdma = "AXI_Bridge_Master";
   xlnx,dma-2rp;
   xlnx,pf2-sriov-bar3-type = "AXI_Bridge_Master";
   xlnx,pf3-bar4-size-qdma = <128>;
   xlnx,select-quad = "GTH_Quad_128";
   xlnx,pf2-sriov-bar0-type = "DMA";
   xlnx,pf1-class-code-qdma = <120000>;
   xlnx,pf1-msix-cap-pba-offset-qdma = <34000>;
   xlnx,sys-rst-n-board-interface = "Custom";
   xlnx,ats-cap-nextptr = <0x0>;
   xlnx,pf3-sriov-bar3-control = <0x0>;
   xlnx,coreclk-freq = <500>;
   xlnx,pf2-bar1-scale-qdma = "Megabytes";
   xlnx,pf2-sriov-bar1-scale = "Kilobytes";
   xlnx,example-design-type = "RTL";
   xlnx,pf0-expansion-rom-size-qdma = <4>;
   xlnx,pf1-bar0-prefetchable-qdma;
   xlnx,pf2-bar6-control = <0x0>;
   xlnx,pf3-msix-cap-table-bir-qdma = "BAR_1:0";
   xlnx,pf0-bar3-aperture-size = <0x0>;
   xlnx,pf0-msi-cap-multimsgcap = <0>;
   xlnx,usr-irq-exdes;
   xlnx,pf1-msix-cap-pba-offset = <00010050>;
   xlnx,timeout-mult = <0x3>;
   xlnx,pf2-sriov-bar0-scale = "Kilobytes";
   xlnx,pf0-bar0-enabled-qdma;
   xlnx,pf1-msix-cap-pba-bir = "BAR_0";
   xlnx,pf3-bar3-aperture-size = <00000000>;
   xlnx,pf1-vendor-id = <0x10ee>;
   xlnx,minimal-dma-en;
   xlnx,msix-impl-ext;
   clock-names = "user_clk_sd";
   xlnx,vfg0-msix-cap-table-size-qdma = <007>;
   xlnx,pf2-bar2-scale-qdma = "Kilobytes";
   xlnx,pf1-sriov-bar4-type = "AXI_Bridge_Master";
   xlnx,pf2-bar2-size-qdma = <4>;
   xlnx,pf1-bar6-control = <0x0>;
   xlnx,pf2-bar0-64bit-qdma;
   xlnx,pf1-sriov-bar1-type = "AXI_Bridge_Master";
   xlnx,pf2-rbar-num = <1>;
   xlnx,pf2-sriov-bar1-control = <0x0>;
   xlnx,rx-ssc-ppm = <0>;
   xlnx,pcie-board-interface = "Custom";
   xlnx,vdm-en;
   xlnx,ref-clk-freq = <0>;
   xlnx,pf1-msi-cap-multimsgcap = "1_vector";
   xlnx,axilite-master-en;
   xlnx,pf0-msix-cap-pba-offset-qdma = <34000>;
   xlnx,pf2-bar3-scale-qdma = "Kilobytes";
   xlnx,wrb-coal-loop-fix-disable = <0>;
   xlnx,pf0-bar6-control = <0x0>;
   xlnx,csr-axilite-slave;
   xlnx,pf3-sriov-bar5-size = <4>;
   xlnx,pf1-sriov-first-vf-offset = <0>;
   xlnx,pf3-bar2-type-qdma = "AXI_Lite_Master";
   xlnx,pf1-msix-enabled-qdma;
   xlnx,pf3-sriov-bar2-size = <4>;
   xlnx,xdma-aperture-size = <0xd>;
   xlnx,pf1-bar0-size-qdma = <256>;
   xlnx,pf0-sriov-bar5-type = "AXI_Bridge_Master";
   xlnx,num-queues = <512>;
   status = "okay";
   xlnx,pf0-subsystem-vendor-id = <0x10ee>;
   xlnx,pf1-msix-cap-table-offset-qdma = <30000>;
   xlnx,pcie-extended-tag;
   xlnx,pf0-sriov-func-dep-link = <0000>;
   xlnx,pf0-sriov-bar2-type = "AXI_Lite_Master";
   xlnx,pf2-msi-cap-multimsgcap = "1_vector";
   xlnx,pf2-bar4-scale-qdma = "Kilobytes";
   xlnx,barlite-msix-pf0 = <0x4>;
   xlnx,barlite-msix-pf1 = <000001>;
   xlnx,pf2-bar6-aperture-size = <00000000>;
   xlnx,barlite-msix-pf2 = <000000>;
   xlnx,barlite-msix-pf3 = <000000>;
   xlnx,pf2-bar2-64bit-qdma;
   xlnx,pf3-addr-mask = <0xfff>;
   xlnx,bar5-indicator = <0>;
   xlnx,pf3-bar2-enabled-qdma;
   xlnx,pf3-revision-id = <0x0>;
   xlnx,pf2-bar1-aperture-size = <00000000>;
   xlnx,vfg1-msix-cap-table-bir-qdma = "BAR_1:0";
   xlnx,enable-jtag-dbg;
   xlnx,en-bridge;
   xlnx,dedicate-perst;
   xlnx,msix-int-table-en = <0>;
   xlnx,pf2-bar0-type-qdma = "DMA";
   xlnx,shared-logic = <0>;
   xlnx,split-dma;
   xlnx,pf2-bar5-scale-qdma = "Kilobytes";
   xlnx,pf2-sriov-bar3-size = <4>;
   xlnx,xdma-num-pcie-tag = <256>;
   xlnx,pf3-bar3-size-qdma = <128>;
   xlnx,pf1-subsystem-vendor-id = <0x10ee>;
   xlnx,ccix-dvsec;
   xlnx,pf1-sriov-func-dep-link = <0001>;
   xlnx,pf3-bar0-control = <0x0>;
   xlnx,xdma-en;
   xlnx,pf2-sriov-bar0-size = <32>;
   xlnx,pf3-msi-cap-multimsgcap = "1_vector";
   xlnx,vfg2-msix-cap-table-offset-qdma = <4000>;
   xlnx,pf2-sriov-bar2-prefetchable;
   xlnx,pf0-class-code-interface-qdma = <00>;
   xlnx,pf2-rbar-cap-bar0 = <0xfff0>;
   xlnx,axi-vip-in-exdes;
   xlnx,pf1-sriov-cap-initial-vf = <0>;
   xlnx,pf2-rbar-cap-bar1 = <0x0>;
   xlnx,pf2-rbar-cap-bar2 = <0x0>;
   xlnx,barlite-mb-pf0 = <0>;
   xlnx,pf2-rbar-cap-bar3 = <0x0>;
   xlnx,barlite-mb-pf1 = <0>;
   xlnx,pf2-rbar-cap-bar4 = <0x0>;
   xlnx,barlite-mb-pf2 = <0>;
   xlnx,axibar-0 = <0x0>;
   xlnx,pf2-rbar-cap-bar5 = <0x0>;
   xlnx,barlite-mb-pf3 = <0>;
   xlnx,axibar-1 = <0x0>;
   xlnx,pf2-base-class-menu-qdma = "Memory_controller";
   xlnx,axibar-2 = <0x0>;
   xlnx,axilite-master-scale = "Megabytes";
   xlnx,axibar-3 = <0x0>;
   xlnx,xdma-dsc-bypass;
   xlnx,include-baroffset-reg = <0x1>;
   xlnx,axibar-4 = <0x0>;
   xlnx,axibar-5 = <0x0>;
   xlnx,pf1-sriov-bar2-64bit;
   xlnx,pf1-class-code-base-qdma = <12>;
   xlnx,axist-bypass-aperture-size = <0xd>;
   xlnx,pf2-bar0-control = <0x0>;
   xlnx,pf2-sub-class-interface-menu-qdma = "Other_memory_controller";
   xlnx,pf0-vendor-id = <0x10ee>;
   xlnx,pf3-bar0-enabled-qdma;
   xlnx,legacy-cfg-ext-if;
   xlnx,pf1-msix-cap-table-bir-qdma = "BAR_1:0";
   xlnx,pf0-vf-bar3-aperture-size = <00000000>;
   xlnx,pf2-subsystem-vendor-id = <0x10ee>;
   xlnx,pf2-sriov-func-dep-link = <0002>;
   xlnx,pf1-sriov-bar2-enabled;
   xlnx,pf1-sriov-bar4-control = <0x0>;
   xlnx,pf2-bar1-size-qdma = <128>;
   xlnx,pf1-sriov-bar4-size = <4>;
   xlnx,pf1-vf-bar6-aperture-size = <0x0>;
   xlnx,pf2-class-code-interface-qdma = <00>;
   xlnx,pf1-bar4-aperture-size = <0x0>;
   xlnx,pf1-sriov-bar1-size = <4>;
   xlnx,enable-resource-reduction;
   xlnx,cfg-mgmt-if;
   xlnx,parity-settings = "None";
   xlnx,pf1-bar0-control = <0x7>;
   xlnx,pf1-sriov-bar0-64bit;
   xlnx,pf1-vf-bar1-aperture-size = <00000000>;
   xlnx,pf2-sriov-bar0-prefetchable;
   xlnx,pf2-vf-bar4-aperture-size = <00000000>;
   xlnx,pf0-msix-cap-table-offset = "00008000";
   xlnx,cmp-col-reg-0 = <1>;
   xlnx,cmp-col-reg-1 = <0>;
   xlnx,cmp-col-reg-2 = <0>;
   xlnx,vfg2-msix-cap-pba-bir-qdma = "BAR_1:0";
   xlnx,cmp-col-reg-3 = <0>;
   xlnx,cmp-col-reg-4 = <0>;
   xlnx,cmp-col-reg-5 = <0>;
   xlnx,msix-type = "HARD";
   xlnx,cmp-col-reg-6 = <0>;
   xlnx,pf3-subsystem-vendor-id = <0x10ee>;
   xlnx,cmp-col-reg-7 = <0>;
   xlnx,pf0-msix-cap-table-size = <020>;
   xlnx,pf3-vf-bar2-aperture-size = <00000000>;
   xlnx,pf3-sriov-func-dep-link = <0003>;
   xlnx,sriov-en = <0>;
   xlnx,pf3-bar1-type-qdma = "AXI_Bridge_Master";
   xlnx,soft-nic-bridge;
   xlnx,pf3-expansion-rom-type-qdma = "Expansion_ROM";
   xlnx,pf0-bar0-control = <0x7>;
   xlnx,pf3-bar5-control = <0x0>;
   xlnx,pf0-sriov-bar0-enabled;
   xlnx,pf0-sriov-bar2-control = <0x7>;
   xlnx,pf0-sriov-bar5-size = <4>;
   xlnx,pciebar2axibar-xdma = <0x0>;
   xlnx,sim-model;
   xlnx,bar-indicator = "BAR_0";
   xlnx,gtwiz-in-core = <1>;
   xlnx,pf0-sriov-bar2-size = <4>;
   xlnx,pf3-sriov-bar0-enabled;
   xlnx,pf3-sriov-bar2-control = <0x0>;
   xlnx,pcie-blk-type = <1>;
   xlnx,vu9p-board;
   xlnx,pf2-addr-mask = <0xfff>;
   xlnx,dma-en = <1>;
   xlnx,bar4-indicator = <0>;
   xlnx,pf0-bar5-type-qdma = "AXI_Bridge_Master";
   xlnx,pf0-msix-cap-table-bir = "BAR_0";
   xlnx,pf0-vc-cap-enabled;
   xlnx,pf2-bar5-control = <0x0>;
   xlnx,pf3-interrupt-pin = <001>;
   xlnx,pf1-msix-cap-table-size = <020>;
   xlnx,csr-slcr = <0x90000000>;
   xlnx,pf3-msix-cap-pba-bir-qdma = "BAR_1:0";
   xlnx,pf3-pciebar2axibar-0 = <0x0>;
   xlnx,pf3-pciebar2axibar-1 = <0x30000000>;
   xlnx,dsc-byp-mode = "NONE";
   xlnx,pf3-pciebar2axibar-2 = <0x30000000>;
   xlnx,pf3-bar2-size-qdma = <4>;
   xlnx,pf3-pciebar2axibar-3 = <0x0>;
   xlnx,pf3-pciebar2axibar-4 = <0x0>;
   xlnx,pf0-bar2-aperture-size = <0xb>;
   xlnx,pf3-pciebar2axibar-5 = <0x0>;
   xlnx,pf3-pciebar2axibar-6 = <0000000000000000000000000000000000000000000000000000000000000000>;
   xlnx,pf1-bar5-control = <0x0>;
   xlnx,pf2-sriov-bar0-control = <0x0>;
   xlnx,pf3-bar2-aperture-size = <00000000>;
   xlnx,pciebar2axibar-0 = <0x201 0x00000000>;
   xlnx,pciebar2axibar-1 = <0x0>;
   xlnx,pciebar2axibar-2 = <0x0>;
   xlnx,pciebar2axibar-3 = <0x0>;
   xlnx,pciebar2axibar-4 = <0x0>;
   xlnx,pf3-device-id = <0xb338>;
   xlnx,pciebar2axibar-5 = <0x0>;
   xlnx,pciebar2axibar-6 = <0000000000000000000000000000000000000000000000000000000000000000>;
   xlnx,pf0-sriov-bar2-prefetchable;
   xlnx,xdma-axist-bypass;
   xlnx,xdma-rnum-rids = <32>;
   xlnx,pf0-bar5-control = <0x0>;
   xlnx,pf3-msix-cap-table-size-qdma = <007>;
   xlnx,en-axi-slave-if;
   xlnx,pf2-bar0-size-qdma = <256>;
   xlnx,pf3-class-code-qdma = "058000";
   xlnx,sriov-first-vf-offset = <16>;
   xlnx,pf0-bar5-index = <7>;
   xlnx,h2c-num-chnl = <4>;
   xlnx,dma-mm = <1>;
   xlnx,axi-addr-width = <64>;
   xlnx,s-axi-num-read = <8>;
   xlnx,egw-is-parent-ip = <1>;
   xlnx,async-clk-enable;
   xlnx,pf0-bar4-index = <7>;
   xlnx,comp-timeout = <1>;
   xlnx,xdma-control = <0x4>;
   xlnx,rx-detect = <0>;
   xlnx,pf0-sriov-bar0-prefetchable;
   xlnx,pf3-bar0-type-qdma = "DMA";
   xlnx,pf3-sriov-first-vf-offset = <0>;
   xlnx,pf1-bar5-index = <7>;
   xlnx,use-standard-interfaces;
   xlnx,pf2-bar5-aperture-size = <00000000>;
   xlnx,pf3-sriov-bar4-type = "AXI_Bridge_Master";
   xlnx,pcie-id-if;
   xlnx,pf0-bar3-index = <7>;
   xlnx,pf0-sub-class-interface-menu-qdma = "Other_memory_controller";
   xlnx,pf3-sriov-bar1-type = "AXI_Bridge_Master";
   xlnx,pf2-sriov-bar5-control = <0x0>;
   xlnx,enable-pcie-debug-ports;
   xlnx,func-mode = <1>;
   xlnx,num-of-bars = <0x2>;
   xlnx,pf2-bar0-aperture-size = <00000000>;
   reg-names = "cfg" , "breg";
   xlnx,xlnx-ref-board = "EMB-PLUS-VPR-4616";
   xlnx,dma-reset-source-sel = <0>;
   #interrupt-cells = <1>;
   xlnx,pf1-bar4-index = <7>;
   xlnx,pl-link-cap-max-link-width = <8>;
   xlnx,pf1-expansion-rom-type-qdma = "Expansion_ROM";
   xlnx,pf2-msix-cap-table-size-qdma = <007>;
   xlnx,vcu118-board;
   xlnx,pf0-sriov-vf-device-id = "C038";
   xlnx,pf0-bar2-index = <7>;
   xlnx,pf1-addr-mask = <0x7ffffff>;
   xlnx,bar3-indicator = <0>;
   xlnx,silicon-rev = "Pre-Production";
   xlnx,mhost-en;
   xlnx,pf0-bar4-type-qdma = "AXI_Bridge_Master";
   xlnx,pf2-bar5-index = <7>;
   xlnx,xdma-wnum-rids = <32>;
   xlnx,cmp-err-reg-0 = <2>;
   xlnx,cmp-err-reg-1 = <0>;
   xlnx,pf0-pciebar2axibar-0 = <0x201 0x00000000>;
   xlnx,cmp-err-reg-2 = <0>;
   xlnx,pf0-pciebar2axibar-1 = <0x0>;
   xlnx,pf3-sriov-vf-device-id = "C338";
   xlnx,cmp-err-reg-3 = <0>;
   xlnx,pf0-pciebar2axibar-2 = <0x0>;
   xlnx,pf1-bar3-index = <7>;
   xlnx,cmp-err-reg-4 = <0>;
   xlnx,pf0-pciebar2axibar-3 = <0x0>;
   xlnx,cmp-err-reg-5 = <0>;
   xlnx,pf0-pciebar2axibar-4 = <0x0>;
   xlnx,pf1-sriov-bar5-scale = "Kilobytes";
   xlnx,cmp-err-reg-6 = <0>;
   xlnx,pf0-pciebar2axibar-5 = <0x0>;
   xlnx,cmp-err-reg-7 = <0>;
   xlnx,pf0-pciebar2axibar-6 = <0x0>;
   xlnx,pf0-bar1-index = <7>;
   xlnx,pf1-rbar-cap-bar0 = <0xfff0>;
   xlnx,pl-upstream-facing;
   xlnx,pf1-rbar-cap-bar1 = <0x0>;
   xlnx,pf1-rbar-cap-bar2 = <0x0>;
   xlnx,pf1-rbar-cap-bar3 = <0x0>;
   xlnx,pf1-rbar-cap-bar4 = <0x0>;
   xlnx,pf1-rbar-cap-bar5 = <0x0>;
   xlnx,pf2-bar4-index = <7>;
   xlnx,pf3-bar1-size-qdma = <128>;
   xlnx,dma-st = <0>;
   xlnx,pf2-sriov-bar5-type = "AXI_Bridge_Master";
   xlnx,pf3-expansion-rom-size-qdma = <4>;
   xlnx,pf1-bar2-index = <7>;
   xlnx,tl-pf-enable-reg = <2>;
   xlnx,pf1-sriov-bar3-control = <0x0>;
   xlnx,pf1-sriov-bar4-scale = "Kilobytes";
   xlnx,pf2-sriov-bar2-type = "AXI_Lite_Master";
   xlnx,pf0-bar0-index = <0>;
   xlnx,pf3-bar5-index = <7>;
   xlnx,xdma-axi-intf-mm = <1>;
   xlnx,rq-seq-num-ignore = <0>;
   xlnx,axisten-freq = <250>;
   xlnx,enable-code = <0000>;
   xlnx,pf2-bar3-index = <7>;
   xlnx,edk-iptype = "PERIPHERAL";
   xlnx,cfg-space-enable;
   xlnx,gen4-eieos-0s7;
   xlnx,pf1-bar1-index = <7>;
   xlnx,pf2-device-id = <0x923f>;
   xlnx,vendor-id = "10EE";
   xlnx,pf0-vf-bar2-aperture-size = <00000000>;
   xlnx,axilite-master-size = <1>;
   xlnx,gt-available = "GTYP_QUAD_X0Y0,GTYP_QUAD_X0Y1";
   xlnx,pf1-sriov-bar3-scale = "Kilobytes";
   xlnx,port-type = <0x1>;
   xlnx,pf1-vf-bar5-aperture-size = <00000000>;
   xlnx,pf3-bar4-index = <7>;
   xlnx,pf0-bar5-size-qdma = <128>;
   xlnx,pf1-bar3-aperture-size = <0x0>;
   xlnx,pf2-bar2-index = <7>;
   xlnx,pf1-msix-cap-table-size-qdma = "01F";
   xlnx,pf3-sriov-cap-ver = <1>;
   xlnx,pf1-sriov-supported-page-size = <00000553>;
   xlnx,pf1-bar0-index = <0>;
   xlnx,pf1-bar0-scale-qdma = "Kilobytes";
   xlnx,pf1-vf-bar0-aperture-size = <00000000>;
   xlnx,pf1-sriov-bar2-scale = "Kilobytes";
   xlnx,pf3-rbar-num = <1>;
   xlnx,pf2-vf-bar3-aperture-size = <00000000>;
   xlnx,pf3-bar3-index = <7>;
   xlnx,dma-mode-en;
   xlnx,pf0-msix-enabled-qdma;
   xlnx,pf3-bar4-control = <0x0>;
   xlnx,pf3-vf-bar6-aperture-size = <0x0>;
   xlnx,pf0-sriov-bar1-control = <0x0>;
   xlnx,pf2-bar1-index = <7>;
   xlnx,pf1-sriov-bar3-type = "AXI_Bridge_Master";
   xlnx,xdma-non-incremental-exdes;
   xlnx,type1-prefetchable-membase-memlimit = "Disabled";
   xlnx,axilite-master-control = <0x4>;
   xlnx,pf1-sriov-bar1-scale = "Kilobytes";
   xlnx,versal-part-type = "HXX";
   xlnx,pf1-sriov-bar0-type = "DMA";
   xlnx,pf0-class-code-qdma = <120000>;
   xlnx,pf3-msix-cap-table-offset-qdma = <30000>;
   xlnx,pf3-vf-bar1-aperture-size = <00000000>;
   xlnx,enable-auto-rxeq;
   xlnx,cfg-ext-if;
   compatible = "xlnx,qdma-5.0" , "xlnx,qdma-host-3.00";
   xlnx,pf3-bar2-index = <7>;
   xlnx,pf3-sriov-bar1-control = <0x0>;
   xlnx,pf1-bar5-type-qdma = "AXI_Bridge_Master";
   xlnx,pf0-msix-cap-pba-bir-qdma = "BAR_3:2";
   xlnx,pf1-bar1-scale-qdma = "Megabytes";
   xlnx,pf2-bar0-index = <0>;
   device_type = "pci";
   xlnx,pl-disable-lane-reversal;
   xlnx,pf2-bar2-enabled-qdma;
   xlnx,pf2-bar4-control = <0x0>;
   xlnx,axist-bypass-scale = "Megabytes";
   xlnx,pf3-sriov-supported-page-size = <00000553>;
   xlnx,pf1-sriov-bar0-scale = "Kilobytes";
   xlnx,pf0-msix-cap-pba-bir = "BAR_0";
   xlnx,flr-enable;
   xlnx,pf3-bar1-index = <7>;
   xlnx,multq-en = <1>;
   xlnx,pf3-sriov-bar2-64bit;
   xlnx,pf3-sriov-bar4-size = <4>;
   xlnx,pf0-rbar-num = <1>;
   xlnx,mdma-pfch-cache-depth = <16>;
   xlnx,testname = "mm";
   xlnx,pf3-sriov-bar1-size = <4>;
   xlnx,pf2-interrupt-pin = <001>;
   xlnx,pf1-bar2-scale-qdma = "Megabytes";
   xlnx,pf3-bar0-index = <0>;
   xlnx,pf2-sriov-cap-initial-vf = <0>;
   xlnx,m-axi-num-read = <8>;
   xlnx,pf0-msix-cap-table-size-qdma = "01F";
   xlnx,pf0-bar6-aperture-size = <0x0>;
   xlnx,pf0-sriov-bar4-type = "AXI_Bridge_Master";
   xlnx,pf1-bar4-control = <0x0>;
   xlnx,metering-on = <1>;
   xlnx,pf3-base-class-menu-qdma = "Memory_controller";
   xlnx,pf0-addr-mask = <0x3ffff>;
   xlnx,pf1-bar0-64bit-qdma;
   xlnx,xdma-axilite-master;
   xlnx,mailbox-enable;
   xlnx,pf0-sriov-bar1-type = "AXI_Bridge_Master";
   xlnx,bar2-indicator = <0>;
   xlnx,pf0-bar3-type-qdma = "AXI_Bridge_Master";
   interrupt-map-mask = < 0 0 0 7 >;
   xlnx,axisten-if-msix-rx-parity-en;
   xlnx,pf2-class-code-base-qdma = <05>;
   xlnx,pf1-bar2-prefetchable-qdma;
   xlnx,pf0-bar1-aperture-size = <0x0>;
   xlnx,pf3-bar6-aperture-size = <00000000>;
   xlnx,pf3-sriov-bar0-64bit;
   xlnx,pf0-msix-cap-table-offset-qdma = <30000>;
   xlnx,pf1-bar3-scale-qdma = "Kilobytes";
   xlnx,pf3-bar1-aperture-size = <00000000>;
   xlnx,enable-gen4;
   xlnx,pf0-bar4-control = <0x0>;
   xlnx,pf2-bar0-enabled-qdma;
   xlnx,pf3-bar0-size-qdma = <256>;
   xlnx,pf0-revision-id = <0x0>;
   xlnx,pf2-sriov-bar5-size = <4>;
   xlnx,s-axi-id-width = <4>;
   xlnx,msix-enabled;
   xlnx,pf2-sriov-bar2-size = <4>;
   xlnx,xlnx-ddr-ex;
   xlnx,enable-ccix;
   xlnx,last-core-cap-addr = <0x100>;
   xlnx,pf1-expansion-rom-size-qdma = <4>;
   xlnx,mult-pf-des;
   xlnx,pf1-device-id = <0x5701>;
   xlnx,pll-type = <2>;
   xlnx,timeout0-sel = <0xe>;
   xlnx,pf0-sriov-first-vf-offset = <16>;
   xlnx,lane-order = "Bottom";
   xlnx,pf1-bar4-scale-qdma = "Kilobytes";
   xlnx,soft-nic;
   xlnx,barlite-ext-pf0 = <000000>;
   xlnx,pf0-bar4-size-qdma = <128>;
   xlnx,barlite-ext-pf1 = <000000>;
   xlnx,barlite-ext-pf2 = <000000>;
   xlnx,barlite-ext-pf3 = <000000>;
   xlnx,pf1-bar2-64bit-qdma;
   xlnx,pf3-enabled = <0>;
   xlnx,vfg1-msix-cap-table-offset-qdma = <4000>;
   xlnx,enable-error-injection;
   xlnx,debug-mode = "DEBUG_NONE";
   xlnx,gt-selected = "GTYP_QUAD_X0Y0,GTYP_QUAD_X0Y1";
   xlnx,pf3-msix-enabled-qdma;
   xlnx,pf1-bar5-scale-qdma = "Kilobytes";
   xlnx,pf1-sriov-bar3-size = <4>;
   xlnx,pf2-sriov-bar2-enabled;
   xlnx,pf2-sriov-bar4-control = <0x0>;
   xlnx,mcap-enablement = "NONE";
   xlnx,pf1-sriov-bar0-size = <32>;
   xlnx,csr-module = <1>;
   xlnx,pf2-bar4-aperture-size = <00000000>;
   xlnx,pf1-bar4-type-qdma = "AXI_Bridge_Master";
   xlnx,vf-barlite-ext-pf0 = <000000>;
   xlnx,vf-barlite-ext-pf1 = <000000>;
   xlnx,vf-barlite-ext-pf2 = <000000>;
   xlnx,vf-barlite-ext-pf3 = <000000>;
   xlnx,pf0-sriov-bar2-64bit;
   xlnx,pf3-msix-vectors = <0>;
   xlnx,versal-part-type-hxx = "HXX";
   xlnx,msi-x-options = "MSI-X_External";
   xlnx,copy-sriov-pf0;
   xlnx,rx-ppm-offset = <0>;
   xlnx,axisten-if-enable-msg-route-override;
   xlnx,axibar-highaddr-0 = <0x0>;
   xlnx,versal;
   xlnx,axibar-highaddr-1 = <0x0>;
   xlnx,axibar-highaddr-2 = <0x0>;
   xlnx,axibar-highaddr-3 = <0x0>;
   xlnx,axibar-highaddr-4 = <0x0>;
   xlnx,vfg3-msix-cap-pba-offset-qdma = <4800>;
   xlnx,name = "blp_qdma_0";
   xlnx,axibar-highaddr-5 = <0x0>;
   xlnx,pf1-sriov-bar0-enabled;
   xlnx,pf1-sriov-bar2-control = <0x7>;
   xlnx,pf2-msix-vectors = <8>;
   xlnx,pf0-bar0-prefetchable-qdma;
   xlnx,pf0-sriov-bar4-size = <4>;
   xlnx,pf0-rbar-cap-bar0 = <0xfff0>;
   xlnx,h2c-xdma-chnl = <0x1>;
   xlnx,pf0-rbar-cap-bar1 = <0x0>;
   xlnx,pf0-sriov-bar0-64bit;
   xlnx,pf0-rbar-cap-bar2 = <0x0>;
   xlnx,bar1-indicator = <0>;
   xlnx,pf0-rbar-cap-bar3 = <0x0>;
   xlnx,pf0-bar2-type-qdma = "DMA";
   xlnx,pf0-rbar-cap-bar4 = <0x0>;
   xlnx,pf0-sriov-bar1-size = <4>;
   xlnx,enable-clock-delay-grp;
   xlnx,pf0-rbar-cap-bar5 = <0x0>;
   xlnx,c2h-stream-cpl-err-bit-pos0 = <2>;
   xlnx,c2h-stream-cpl-err-bit-pos1 = <0>;
   xlnx,c2h-stream-cpl-err-bit-pos2 = <0>;
   xlnx,c2h-stream-cpl-err-bit-pos3 = <0>;
   xlnx,pf1-bar5-size-qdma = <128>;
   xlnx,c2h-stream-cpl-err-bit-pos4 = <0>;
   xlnx,c2h-stream-cpl-err-bit-pos5 = <0>;
   xlnx,c2h-stream-cpl-err-bit-pos6 = <0>;
   xlnx,c2h-stream-cpl-err-bit-pos7 = <0>;
   xlnx,vfg2-msix-cap-table-bir-qdma = "BAR_1:0";
   xlnx,pf0-vf-bar6-aperture-size = <0x0>;
   xlnx,pf1-msix-cap-table-bir = "BAR_0";
   xlnx,pf1-msix-vectors = <32>;
   xlnx,pf0-base-class-menu-qdma = "Memory_controller";
   xlnx,axibar-notranslate = <0>;
   xlnx,pf0-vf-bar1-aperture-size = <00000000>;
   xlnx,enable-pcie-debug-axi4-st;
   xlnx,xdma-st-infinite-desc-exdes;
   xlnx,pf1-vf-bar4-aperture-size = <00000000>;
   xlnx,pf3-bar3-control = <0x0>;
   xlnx,pf0-sriov-bar0-control = <0x7>;
   xlnx,pf3-sriov-bar2-prefetchable;
   xlnx,pf1-bar2-aperture-size = <0x14>;
   xlnx,user-clk-freq = <2>;
   xlnx,shell-bridge = <0>;
   xlnx,pf3-sub-class-interface-menu-qdma = "Other_memory_controller";
   xlnx,pf2-sriov-cap-ver = <1>;
   xlnx,vfg1-msix-cap-pba-bir-qdma = "BAR_1:0";
   xlnx,pf0-device-id = <0x5700>;
   xlnx,pf2-bar5-type-qdma = "AXI_Bridge_Master";
   xlnx,pf0-msix-vectors = <32>;
   xlnx,pf3-sriov-bar0-control = <0x0>;
   xlnx,pf2-vf-bar2-aperture-size = <00000000>;
   xlnx,xdma-rnum-chnl = <4>;
   xlnx,pf0-bar3-size-qdma = <128>;
   xlnx,all-speeds-all-sides;
   xlnx,pf3-vf-bar5-aperture-size = <00000000>;
   xlnx,vfg2-msix-cap-pba-offset-qdma = <4800>;
   xlnx,mode-selection = "Advanced";
   xlnx,pf2-bar3-control = <0x0>;
   xlnx,pf2-msix-cap-table-bir-qdma = "BAR_1:0";
   xlnx,enable-more;
   xlnx,pf3-vf-bar0-aperture-size = <00000000>;
   xlnx,pf2-pciebar2axibar-0 = <0x0>;
   xlnx,pf2-pciebar2axibar-1 = <0x20000000>;
   xlnx,tandem-rfsoc;
   xlnx,gt-loc-num = "X99Y99";
   xlnx,pf2-pciebar2axibar-2 = <0x20000000>;
   xlnx,pf2-pciebar2axibar-3 = <0x0>;
   xlnx,pf3-sriov-bar5-scale = "Kilobytes";
   xlnx,is-board-project = <1>;
   xlnx,pf2-pciebar2axibar-4 = <0x0>;
   xlnx,pf2-pciebar2axibar-5 = <0x0>;
   xlnx,pf2-pciebar2axibar-6 = <0000000000000000000000000000000000000000000000000000000000000000>;
   xlnx,pcie-pfs-supported = <2>;
   xlnx,pipe-line-stage = <2>;
   xlnx,pciebar2axibar-axist-bypass = <0x0>;
   xlnx,axist-bypass-en;
   xlnx,pf1-bar3-control = <0x0>;
   xlnx,pf1-bar3-type-qdma = "AXI_Bridge_Master";
   xlnx,wrb-coal-max-buf = <16>;
   xlnx,pl-link-cap-max-link-speed = <4>;
   xlnx,pf3-sriov-bar4-scale = "Kilobytes";
   xlnx,pf3-sriov-bar0-prefetchable;
   xlnx,pcie-blk-locn = <0>;
   xlnx,pf2-msix-cap-pba-bir-qdma = "BAR_1:0";
   xlnx,pf1-interrupt-pin = <001>;
   xlnx,pf0-vf-pciebar2axibar-0 = <0x0>;
   xlnx,pf3-bar0-scale-qdma = "Kilobytes";
   xlnx,pf0-vf-pciebar2axibar-1 = <0x40000000>;
   xlnx,pf0-bar5-aperture-size = <0x0>;
   xlnx,pf0-vf-pciebar2axibar-2 = <0x40000000>;
   xlnx,pf3-sriov-bar3-scale = "Kilobytes";
   xlnx,pf0-vf-pciebar2axibar-3 = <0x0>;
   xlnx,pf0-vf-pciebar2axibar-4 = <0x0>;
   xlnx,pf0-link-status-slot-clock-config;
   xlnx,pf0-vf-pciebar2axibar-5 = <0x0>;
   xlnx,msix-pcie-internal = <0>;
   xlnx,pf0-bar3-control = <0x0>;
   xlnx,enable-ibert;
   xlnx,pf0-sriov-bar5-control = <0x0>;
   xlnx,pf3-sriov-bar3-type = "AXI_Bridge_Master";
   xlnx,functional-mode = "QDMA";
   xlnx,pf0-bar0-aperture-size = <0x15>;
   xlnx,pf3-bar5-aperture-size = <00000000>;
   xlnx,disable-bram-pipeline;
   xlnx,vfg1-msix-cap-pba-offset-qdma = <4800>;
   xlnx,pf3-subsystem-id = <0x7>;
   interrupt-names = "misc" , "msi0" , "msi1";
   xlnx,data-mover;
   xlnx,pf3-sriov-bar0-type = "DMA";
   xlnx,pf3-sriov-bar2-scale = "Kilobytes";
   xlnx,pf2-class-code-qdma = "058000";
   xlnx,gtwiz-in-core-us = <1>;
   xlnx,pf3-sriov-bar5-control = <0x0>;
   xlnx,enable-at-ports;
   xlnx,bar0-indicator = <1>;
   xlnx,xdma-wnum-chnl = <4>;
   xlnx,pf0-bar1-type-qdma = "AXI_Bridge_Master";
   xlnx,pf1-class-code-interface-qdma = <00>;
   xlnx,pf3-bar0-aperture-size = <00000000>;
   xlnx,pf3-bar1-scale-qdma = "Megabytes";
   xlnx,ccix-enable;
   xlnx,pf1-bar4-size-qdma = <128>;
   xlnx,pf1-sriov-vf-device-id = "C138";
   xlnx,pf1-vf-pciebar2axibar-0 = <0x0>;
   xlnx,pf3-sriov-bar1-scale = "Kilobytes";
   xlnx,pf1-vf-pciebar2axibar-1 = <0x50000000>;
   xlnx,pf1-vf-pciebar2axibar-2 = <0x50000000>;
   xlnx,pf1-vf-pciebar2axibar-3 = <0x0>;
   xlnx,pf1-vf-pciebar2axibar-4 = <0x0>;
   xlnx,pf1-vf-pciebar2axibar-5 = <0x0>;
   xlnx,pf2-subsystem-id = <0x7>;
   xlnx,pf2-enabled = <0>;
   xlnx,pf3-expansion-rom-scale-qdma = "Kilobytes";
   xlnx,pf1-revision-id = <0x0>;
   xlnx,parity-prop = <0>;
   xlnx,ultrascale;
   xlnx,pf3-sriov-bar0-scale = "Kilobytes";
   xlnx,vfg0-msix-cap-table-bir-qdma = "BAR_1:0";
   xlnx,pf3-bar2-scale-qdma = "Kilobytes";
   xlnx,pf2-sriov-bar4-type = "AXI_Bridge_Master";
   xlnx,pf3-bar0-64bit-qdma;
   xlnx,pf2-sriov-bar1-type = "AXI_Bridge_Master";
   xlnx,pf3-class-code-interface-qdma = <00>;
   xlnx,pf2-sriov-bar3-control = <0x0>;
   xlnx,old-bridge-timeout = <0>;
   xlnx,pf1-subsystem-id = <0xe>;
   xlnx,pf2-bar4-type-qdma = "AXI_Bridge_Master";
   xlnx,pf0-bar2-size-qdma = <256>;
   xlnx,pf2-sriov-first-vf-offset = <0>;
   xlnx,pf2-vf-pciebar2axibar-0 = <0x0>;
   xlnx,pf2-vf-pciebar2axibar-1 = <0x60000000>;
   xlnx,en-debug-ports;
   xlnx,pf2-vf-pciebar2axibar-2 = <0x60000000>;
   xlnx,ext-sys-clk-bufg;
   xlnx,pf1-sriov-bar2-prefetchable;
   xlnx,pf2-vf-pciebar2axibar-3 = <0x0>;
   xlnx,vfg0-msix-cap-pba-offset-qdma = <4800>;
   xlnx,rable = <0>;
   xlnx,axilite-master-aperture-size = <0xd>;
   xlnx,pf2-vf-pciebar2axibar-4 = <0x0>;
   xlnx,ip-name = "qdma";
   xlnx,pf2-vf-pciebar2axibar-5 = <0x0>;
   xlnx,bridge-burst;
   xlnx,pf0-sriov-bar5-scale = "Kilobytes";
   xlnx,pciebar2axibar-axil-master = <0x0>;
   xlnx,pf1-bar2-enabled-qdma;
   xlnx,pf3-bar3-scale-qdma = "Kilobytes";
   xlnx,pf2-bar3-aperture-size = <00000000>;
   xlnx,pf0-subsystem-id = <0xe>;
   xlnx,phy-lp-txpreset = <4>;
   xlnx,pf0-sriov-bar4-scale = "Kilobytes";
   xlnx,pf3-sriov-cap-initial-vf = <0>;
   xlnx,pf0-msix-cap-table-bir-qdma = "BAR_3:2";
   xlnx,pf1-sriov-bar5-type = "AXI_Bridge_Master";
   xlnx,xdma-scale = "Megabytes";
   xlnx,pf1-sriov-bar1-control = <0x0>;
   xlnx,pf1-bar2-type-qdma = "AXI_Bridge_Master";
   xlnx,pf1-sriov-bar2-type = "AXI_Lite_Master";
   xlnx,pf2-expansion-rom-scale-qdma = "Kilobytes";
   xlnx,pf3-vf-pciebar2axibar-0 = <0x0>;
   xlnx,pf3-vf-pciebar2axibar-1 = <0x70000000>;
   xlnx,gtcom-in-core = <2>;
   xlnx,pf3-bar4-scale-qdma = "Kilobytes";
   xlnx,pf3-class-code-base-qdma = <05>;
   xlnx,pf3-vf-pciebar2axibar-2 = <0x70000000>;
   xlnx,num-of-sc = <1>;
   xlnx,pf3-vf-pciebar2axibar-3 = <0x0>;
   xlnx,pf3-vf-pciebar2axibar-4 = <0x0>;
   xlnx,pf2-bar5-size-qdma = <128>;
   xlnx,pf3-vf-pciebar2axibar-5 = <0x0>;
   xlnx,pf0-sriov-bar3-scale = "Kilobytes";
   clocks = <&misc_clk_0>;
   xlnx,pf1-sub-class-interface-menu-qdma = "Other_memory_controller";
   xlnx,pf3-vf-addr-mask = <0xfff>;
   xlnx,pf3-bar2-64bit-qdma;
   xlnx,sys-reset-polarity = <0>;
   xlnx,pf1-rbar-num = <1>;
   xlnx,en-axi-mm-qdma;
   xlnx,pf1-sriov-bar0-prefetchable;
   xlnx,pf0-sriov-bar2-scale = "Kilobytes";
   xlnx,pf2-msix-cap-table-offset-qdma = <30000>;
   xlnx,pf1-bar0-enabled-qdma;
   xlnx,barlite1 = <1>;
   xlnx,barlite2 = <7>;
   xlnx,pf0-bar0-scale-qdma = "Megabytes";
   xlnx,pf3-bar5-scale-qdma = "Kilobytes";
   xlnx,xdma-sts-ports;
   xlnx,pf3-sriov-bar3-size = <4>;
   xlnx,s-axi-num-write = <8>;
   xlnx,pf2-vf-addr-mask = <0xfff>;
   xlnx,pf0-vf-bar5-aperture-size = <00000000>;
   xlnx,pf3-bar2-control = <0x0>;
   xlnx,pf3-sriov-bar0-size = <32>;
   xlnx,pf2-expansion-rom-type-qdma = "Expansion_ROM";
   xlnx,pf0-sriov-bar1-scale = "Kilobytes";
   xlnx,pf0-bar0-type-qdma = "AXI_Bridge_Master";
   xlnx,pf3-bar5-type-qdma = "AXI_Bridge_Master";
   #size-cells = <2>;
   xlnx,adv-int-usr;
   xlnx,pf0-sriov-bar3-type = "AXI_Bridge_Master";
   xlnx,c2h-num-chnl = <4>;
   xlnx,pf1-bar3-size-qdma = <128>;
   xlnx,pf1-bar6-aperture-size = <0x0>;
   xlnx,en-gt-selection;
   xlnx,barlite-int-pf0 = <0x4>;
   xlnx,pf0-vf-bar0-aperture-size = <00000000>;
   xlnx,tl-credits-cd = <15>;
   xlnx,barlite-int-pf1 = <000001>;
   xlnx,pf0-sriov-bar0-type = "DMA";
   xlnx,barlite-int-pf2 = <000000>;
   xlnx,barlite-int-pf3 = <000000>;
   xlnx,disable-user-clock-root;
   xlnx,pf1-vf-bar3-aperture-size = <00000000>;
   xlnx,tl-credits-ch = <15>;
   xlnx,pf0-sriov-bar0-scale = "Kilobytes";
   xlnx,pf0-bar1-scale-qdma = "Megabytes";
   xlnx,pf2-vf-bar6-aperture-size = <0x0>;
   xlnx,pf1-bar1-aperture-size = <0x0>;
   xlnx,pf1-expansion-rom-scale-qdma = "Kilobytes";
   xlnx,pf1-vf-addr-mask = <0xfff>;
   ranges = <0x43000000 0x00000000 0x00000000 0x00000000 0x00000000 0x00000000 0x00000001>;
   xlnx,pf1-sriov-cap-ver = <1>;
   xlnx,pf2-bar2-control = <0x0>;
   xlnx,pf2-sriov-bar2-64bit;
   xlnx,vfg3-msix-cap-table-offset-qdma = <4000>;
   xlnx,xdma-num-usr-irq = <16>;
   xlnx,pf2-vf-bar1-aperture-size = <00000000>;
   xlnx,plltype = "QPLL1";
   xlnx,vsec-cap-addr = <0xe00>;
   xlnx,pf3-vf-bar4-aperture-size = <00000000>;
   xlnx,pf2-msix-enabled-qdma;
   xlnx,pf2-sriov-bar4-size = <4>;
   xlnx,usr-irq-xdma-type-interface;
   xlnx,pf1-msix-cap-table-offset = <00010040>;
   xlnx,c2h-stream-cpl-data-size = <0>;
   xlnx,en-qdma;
   xlnx,pf2-sriov-bar1-size = <4>;
   xlnx,dsc-bypass-rd = <0>;
   xlnx,axisten-if-enable-msg-route = <0x1efff>;
   xlnx,pf2-bar3-type-qdma = "AXI_Bridge_Master";
   xlnx,pf1-msix-enabled;
   xlnx,vfg3-msix-cap-pba-bir-qdma = "BAR_1:0";
   xlnx,vf-barlite-int-pf0 = <000000>;
   xlnx,pf0-bar2-scale-qdma = "Kilobytes";
   xlnx,vf-barlite-int-pf1 = <000000>;
   xlnx,pf0-vf-addr-mask = <0xfff>;
   xlnx,vf-barlite-int-pf2 = <000000>;
   xlnx,dma-completion = <0>;
   xlnx,msix-preset = <0>;
   xlnx,pf0-bar1-size-qdma = <128>;
   xlnx,pf1-bar2-control = <0x7>;
   xlnx,vf-barlite-int-pf3 = <000000>;
   xlnx,enable-64bit;
   xlnx,pf0-bar0-64bit-qdma;
   xlnx,vu9p-tul-ex;
   xlnx,pf2-sriov-bar0-64bit;
   xlnx,virtio-en;
   xlnx,type1-membase-memlimit-enable = "Disabled";
   xlnx,dsc-bypass-rd-out = <0>;
   xlnx,enable-dvsec;
   xlnx,acs-ext-cap-enable;
   xlnx,en-transceiver-status-ports;
   xlnx,pf0-msix-enabled;
   xlnx,rp-msi-enabled;
   xlnx,pf0-bar2-control = <0x7>;
   xlnx,pf0-bar3-scale-qdma = "Kilobytes";
   xlnx,pf0-sriov-bar2-enabled;
   xlnx,pf0-sriov-bar4-control = <0x0>;
   #address-cells = <3>;
   xlnx,pf0-interrupt-pin = <0x1>;
   xlnx,pr-cap-nextptr = <0x0>;
   xlnx,pf3-vendor-id = <0x10ee>;
   xlnx,axist-bypass-control = <0x4>;
   xlnx,pf1-sriov-bar5-size = <4>;
   xlnx,pf0-expansion-rom-scale-qdma = "Kilobytes";
   xlnx,pf0-bar4-aperture-size = <0x0>;
   xlnx,pf1-bar1-type-qdma = "AXI_Bridge_Master";
   xlnx,vfg0-msix-cap-table-offset-qdma = <4000>;
   xlnx,pf1-sriov-bar2-size = <4>;
   xlnx,pf3-sriov-bar4-control = <0x0>;
   xlnx,pf3-sriov-bar2-enabled;
   xlnx,pf2-bar4-size-qdma = <128>;
   xlnx,en-axi-master-if;
   xlnx,dsc-bypass-wr-out = <0>;
   xlnx,pf3-bar4-aperture-size = <00000000>;
   xlnx,pf0-sriov-cap-initial-vf = <8>;
   xlnx,dsc-bypass-rd-csr = <1>;
   xlnx,pf0-bar4-scale-qdma = "Kilobytes";
   xlnx,pf1-base-class-menu-qdma = "Memory_controller";
   xlnx,dsc-bypass-wr = <0>;
   xlnx,pf1-enabled = <1>;
   xlnx,pf0-bar2-64bit-qdma;
   xlnx,pf0-class-code-base-qdma = <12>;
   xlnx,rq-rcfg-en;
   xlnx,pf0-sriov-supported-page-size = <00000553>;
   xlnx,drp-clk-sel = <0>;
   xlnx,ins-loss-profile = "Add-in_Card";
   xlnx,alf-cap-enable;
   xlnx,pf3-bar4-type-qdma = "AXI_Bridge_Master";
   xlnx,xdma-size = <1>;
   xlnx,pf0-bar5-scale-qdma = "Kilobytes";
   xlnx,pf2-sriov-bar0-enabled;
   xlnx,pf2-sriov-bar2-control = <0x0>;
   xlnx,pf0-sriov-bar3-size = <4>;
   xlnx,pf1-bar2-size-qdma = <128>;
   xlnx,dsc-bypass-wr-csr = <1>;
   xlnx,max-num-queue = <512>;
   xlnx,pf0-sriov-bar0-size = <32>;
   xlnx,dma-intf-sel-qdma = "AXI_MM";
   xlnx,timeout1-sel = <0xf>;
   xlnx,axi-aclk-loopback;
   xlnx,pf0-expansion-rom-type-qdma = "Expansion_ROM";
   xlnx,enable-ats-switch;
   xlnx,vfg3-msix-cap-table-size-qdma = <007>;
   xlnx,pf2-sriov-supported-page-size = <00000553>;
   xlnx,pf2-revision-id = <0x0>;
   xlnx,v7-gen3;
   xlnx,c2h-stream-cpl-col-bit-pos0 = <1>;
   xlnx,pf0-class-code-sub-qdma = <00>;
   xlnx,c2h-stream-cpl-col-bit-pos1 = <0>;
   xlnx,c2h-stream-cpl-col-bit-pos2 = <0>;
   xlnx,c2h-stream-cpl-col-bit-pos3 = <0>;
   xlnx,c2h-stream-cpl-col-bit-pos4 = <0>;
   xlnx,gtwiz-in-core-usp = <1>;
   xlnx,c2h-stream-cpl-col-bit-pos5 = <0>;
   xlnx,c2h-xdma-chnl = <0x1>;
   xlnx,c2h-stream-cpl-col-bit-pos6 = <0>;
   xlnx,c2h-stream-cpl-col-bit-pos7 = <0>;
   xlnx,master-cal-only;
   xlnx,pf2-bar2-type-qdma = "AXI_Lite_Master";
   xlnx,pipe-sim;
   xlnx,pf2-expansion-rom-size-qdma = <4>;
   xlnx,xdma-axilite-slave;
   xlnx,pf1-sriov-bar0-control = <0x7>;
   xlnx,dev-port-type = <0>;
   xlnx,pf0-bar0-size-qdma = <256>;
   xlnx,pf3-bar5-size-qdma = <128>;
   xlnx,msi-enabled;
   xlnx,pf2-bar2-aperture-size = <00000000>;
   xlnx,mm-slave-en = <0>;
   xlnx,pf3-msix-cap-pba-offset-qdma = <34000>;
   xlnx,ins-loss-nyq = <15>;
   xlnx,pf1-class-code-sub-qdma = <00>;
   xlnx,pf3-rbar-cap-bar0 = <0xfff0>;
   xlnx,axi-id-width = <4>;
   xlnx,pf3-rbar-cap-bar1 = <0x0>;
   xlnx,pf3-rbar-cap-bar2 = <0x0>;
   xlnx,core-clk-freq = <2>;
   xlnx,firstvf-offset-pf0 = <16>;
   xlnx,pf3-rbar-cap-bar3 = <0x0>;
   xlnx,axibar2pciebar-0 = <0x0>;
   xlnx,firstvf-offset-pf1 = <0>;
   xlnx,pf3-rbar-cap-bar4 = <0x0>;
   xlnx,axibar2pciebar-1 = <0x0>;
   xlnx,firstvf-offset-pf2 = <0>;
   xlnx,pf2-vendor-id = <0x10ee>;
   xlnx,pf3-rbar-cap-bar5 = <0x0>;
   xlnx,axibar2pciebar-2 = <0x0>;
   xlnx,firstvf-offset-pf3 = <0>;
   xlnx,axibar2pciebar-3 = <0x0>;
   xlnx,axibar2pciebar-4 = <0x0>;
   xlnx,pf1-bar0-type-qdma = "DMA";
   xlnx,vfg2-msix-cap-table-size-qdma = <007>;
   xlnx,axibar2pciebar-5 = <0x0>;
   xlnx,pf3-bar1-control = <0x0>;
   xlnx,pf0-bar2-prefetchable-qdma;
   xlnx,pf2-bar3-size-qdma = <128>;
   xlnx,axist-bypass-size = <1>;
   xlnx,gtcom-in-core-usp = <2>;
   xlnx,disable-eq-synchronizer;
   xlnx,axi-data-width = <256>;
   xlnx,en-pcie-debug-ports;
   xlnx,pf0-vf-bar4-aperture-size = <00000000>;
   xlnx,pf2-class-code-sub-qdma = <80>;
   xlnx,pciebar-num = <6>;
   xlnx,pfch-cache-depth = <16>;
   xlnx,axibar-num = <1>;
   xlnx,iep-en;
   xlnx,free-run-freq = <0>;
   xlnx,pf1-pciebar2axibar-0 = <0x0>;
   xlnx,ultrascale-plus;
   xlnx,m-axi-num-write = <32>;
   xlnx,enable-pcie-debug;
   xlnx,pf1-pciebar2axibar-1 = <0x10000000>;
   xlnx,pf2-bar1-control = <0x0>;
   xlnx,pf1-pciebar2axibar-2 = <0x202 0x00000000>;
   xlnx,pf1-bar5-aperture-size = <0x0>;
   xlnx,pf1-pciebar2axibar-3 = <0x0>;
   xlnx,pf2-msix-cap-pba-offset-qdma = <34000>;
   xlnx,vfg0-msix-cap-pba-bir-qdma = "BAR_1:0";
   xlnx,pf0-msix-impl-locn = "External";
   xlnx,pf1-pciebar2axibar-4 = <0x0>;
   xlnx,pf2-sriov-bar5-scale = "Kilobytes";
   xlnx,pf1-pciebar2axibar-5 = <0x0>;
   xlnx,pf1-pciebar2axibar-6 = <0000000000000000000000000000000000000000000000000000000000000000>;
   xlnx,pf3-sriov-bar5-type = "AXI_Bridge_Master";
   xlnx,pf1-vf-bar2-aperture-size = <00000000>;
   interrupt-map = <0 0 0 1 &pcie_intc_1 0>, <0 0 0 2 &pcie_intc_1 1>, <0 0 0 3 &pcie_intc_1 2>, <0 0 0 4 &pcie_intc_1 3>;
   xlnx,pf1-sriov-bar5-control = <0x0>;
   xlnx,pf3-sriov-bar2-type = "AXI_Lite_Master";
   xlnx,pf2-vf-bar5-aperture-size = <00000000>;
   xlnx,pf3-bar3-type-qdma = "AXI_Bridge_Master";
   xlnx,pf1-bar0-aperture-size = <0xb>;
   xlnx,ext-xvc-vsec-enable;
   xlnx,pf0-sriov-cap-ver = <1>;
   xlnx,pf1-bar1-size-qdma = <128>;
   xlnx,pf2-sriov-bar4-scale = "Kilobytes";
   xlnx,pf1-bar1-control = <0x0>;
   xlnx,pf2-vf-bar0-aperture-size = <00000000>;
   xlnx,rbar-enable;
   xlnx,pf3-class-code-sub-qdma = <80>;
   xlnx,vfg3-msix-cap-table-bir-qdma = "BAR_1:0";
   xlnx,pf3-vf-bar3-aperture-size = <00000000>;
   xlnx,vfg1-msix-cap-table-size-qdma = <007>;
   xlnx,pf2-sriov-vf-device-id = "C238";
   xlnx,pf0-bar2-enabled-qdma;
   xlnx,pf2-sriov-bar3-scale = "Kilobytes";
   xlnx,num-vfs-pf0 = <8>;
   xlnx,pf2-bar0-scale-qdma = "Kilobytes";
   xlnx,num-vfs-pf1 = <0>;
   xlnx,num-vfs-pf2 = <0>;
   xlnx,pf0-msix-cap-pba-offset = "00008FE0";
   pcie_intc_1: interrupt-controller {
    #interrupt-cells = <1>;
    #address-cells = <0>;
    interrupt-controller;
   };
  };
 };
};
# 5 "/scratch/jenkins-sdt_artifactory_upload_2024.2-52/build_cfg/hw-description/emb-plus-ve2302-sdt_2024.2_1111_2/system-top.dts" 2
# 1 "/scratch/jenkins-sdt_artifactory_upload_2024.2-52/build_cfg/hw-description/emb-plus-ve2302-sdt_2024.2_1111_2/pcw.dtsi" 1
 &psv_cortexa72_0 {
  xlnx,rable = <0>;
  xlnx,timestamp-clk-freq = <99999908>;
  xlnx,pss-ref-clk-freq = <33333300>;
  stamp-frequency = <99999908>;
  xlnx,ip-name = "psv_cortexa72";
  xlnx,cpu-clk-freq-hz = <1399998657>;
  cpu-frequency = <1399998657>;
  bus-handle = <&amba>;
 };
 &psv_cortexa72_1 {
  xlnx,rable = <0>;
  xlnx,timestamp-clk-freq = <99999908>;
  xlnx,pss-ref-clk-freq = <33333300>;
  stamp-frequency = <99999908>;
  xlnx,ip-name = "psv_cortexa72";
  xlnx,cpu-clk-freq-hz = <1399998657>;
  cpu-frequency = <1399998657>;
  bus-handle = <&amba>;
 };
 &amba {
  blp_cips_pspmc_0_psv_apu_0: blp_cips_pspmc_0_psv_apu_0@fd5c0000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-apu-1.0";
   status = "okay";
   xlnx,ip-name = "psv_apu";
   reg = <0x0 0xfd5c0000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_apu_0";
  };
  blp_cips_pspmc_0_psv_coresight_a720_cti: blp_cips_pspmc_0_psv_coresight_a720_cti@f0d10000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-coresight-a720-cti-1.0";
   status = "okay";
   xlnx,ip-name = "psv_coresight_a720_cti";
   reg = <0x0 0xf0d10000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_coresight_a720_cti";
  };
  blp_cips_pspmc_0_psv_coresight_a720_dbg: blp_cips_pspmc_0_psv_coresight_a720_dbg@f0d00000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-coresight-a720-dbg-1.0";
   status = "okay";
   xlnx,ip-name = "psv_coresight_a720_dbg";
   reg = <0x0 0xf0d00000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_coresight_a720_dbg";
  };
  blp_cips_pspmc_0_psv_coresight_a720_etm: blp_cips_pspmc_0_psv_coresight_a720_etm@f0d30000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-coresight-a720-etm-1.0";
   status = "okay";
   xlnx,ip-name = "psv_coresight_a720_etm";
   reg = <0x0 0xf0d30000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_coresight_a720_etm";
  };
  blp_cips_pspmc_0_psv_coresight_a720_pmu: blp_cips_pspmc_0_psv_coresight_a720_pmu@f0d20000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-coresight-a720-pmu-1.0";
   status = "okay";
   xlnx,ip-name = "psv_coresight_a720_pmu";
   reg = <0x0 0xf0d20000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_coresight_a720_pmu";
  };
  blp_cips_pspmc_0_psv_coresight_a721_cti: blp_cips_pspmc_0_psv_coresight_a721_cti@f0d50000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-coresight-a721-cti-1.0";
   status = "okay";
   xlnx,ip-name = "psv_coresight_a721_cti";
   reg = <0x0 0xf0d50000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_coresight_a721_cti";
  };
  blp_cips_pspmc_0_psv_coresight_a721_dbg: blp_cips_pspmc_0_psv_coresight_a721_dbg@f0d40000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-coresight-a721-dbg-1.0";
   status = "okay";
   xlnx,ip-name = "psv_coresight_a721_dbg";
   reg = <0x0 0xf0d40000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_coresight_a721_dbg";
  };
  blp_cips_pspmc_0_psv_coresight_a721_etm: blp_cips_pspmc_0_psv_coresight_a721_etm@f0d70000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-coresight-a721-etm-1.0";
   status = "okay";
   xlnx,ip-name = "psv_coresight_a721_etm";
   reg = <0x0 0xf0d70000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_coresight_a721_etm";
  };
  blp_cips_pspmc_0_psv_coresight_a721_pmu: blp_cips_pspmc_0_psv_coresight_a721_pmu@f0d60000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-coresight-a721-pmu-1.0";
   status = "okay";
   xlnx,ip-name = "psv_coresight_a721_pmu";
   reg = <0x0 0xf0d60000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_coresight_a721_pmu";
  };
  blp_cips_pspmc_0_psv_coresight_apu_cti: blp_cips_pspmc_0_psv_coresight_apu_cti@f0ca0000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-coresight-apu-cti-1.0";
   status = "okay";
   xlnx,ip-name = "psv_coresight_apu_cti";
   reg = <0x0 0xf0ca0000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_coresight_apu_cti";
  };
  blp_cips_pspmc_0_psv_coresight_apu_ela: blp_cips_pspmc_0_psv_coresight_apu_ela@f0c60000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-coresight-apu-ela-1.0";
   status = "okay";
   xlnx,ip-name = "psv_coresight_apu_ela";
   reg = <0x0 0xf0c60000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_coresight_apu_ela";
  };
  blp_cips_pspmc_0_psv_coresight_apu_etf: blp_cips_pspmc_0_psv_coresight_apu_etf@f0c30000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-coresight-apu-etf-1.0";
   status = "okay";
   xlnx,ip-name = "psv_coresight_apu_etf";
   reg = <0x0 0xf0c30000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_coresight_apu_etf";
  };
  blp_cips_pspmc_0_psv_coresight_apu_fun: blp_cips_pspmc_0_psv_coresight_apu_fun@f0c20000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-coresight-apu-fun-1.0";
   status = "okay";
   xlnx,ip-name = "psv_coresight_apu_fun";
   reg = <0x0 0xf0c20000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_coresight_apu_fun";
  };
  blp_cips_pspmc_0_psv_coresight_cpm_atm: blp_cips_pspmc_0_psv_coresight_cpm_atm@f0f80000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-coresight-cpm-atm-1.0";
   status = "okay";
   xlnx,ip-name = "psv_coresight_cpm_atm";
   reg = <0x0 0xf0f80000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_coresight_cpm_atm";
  };
  blp_cips_pspmc_0_psv_coresight_cpm_cti2a: blp_cips_pspmc_0_psv_coresight_cpm_cti2a@f0fa0000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-coresight-cpm-cti2a-1.0";
   status = "okay";
   xlnx,ip-name = "psv_coresight_cpm_cti2a";
   reg = <0x0 0xf0fa0000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_coresight_cpm_cti2a";
  };
  blp_cips_pspmc_0_psv_coresight_cpm_cti2d: blp_cips_pspmc_0_psv_coresight_cpm_cti2d@f0fd0000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-coresight-cpm-cti2d-1.0";
   status = "okay";
   xlnx,ip-name = "psv_coresight_cpm_cti2d";
   reg = <0x0 0xf0fd0000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_coresight_cpm_cti2d";
  };
  blp_cips_pspmc_0_psv_coresight_cpm_ela2a: blp_cips_pspmc_0_psv_coresight_cpm_ela2a@f0f40000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-coresight-cpm-ela2a-1.0";
   status = "okay";
   xlnx,ip-name = "psv_coresight_cpm_ela2a";
   reg = <0x0 0xf0f40000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_coresight_cpm_ela2a";
  };
  blp_cips_pspmc_0_psv_coresight_cpm_ela2b: blp_cips_pspmc_0_psv_coresight_cpm_ela2b@f0f50000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-coresight-cpm-ela2b-1.0";
   status = "okay";
   xlnx,ip-name = "psv_coresight_cpm_ela2b";
   reg = <0x0 0xf0f50000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_coresight_cpm_ela2b";
  };
  blp_cips_pspmc_0_psv_coresight_cpm_ela2c: blp_cips_pspmc_0_psv_coresight_cpm_ela2c@f0f60000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-coresight-cpm-ela2c-1.0";
   status = "okay";
   xlnx,ip-name = "psv_coresight_cpm_ela2c";
   reg = <0x0 0xf0f60000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_coresight_cpm_ela2c";
  };
  blp_cips_pspmc_0_psv_coresight_cpm_ela2d: blp_cips_pspmc_0_psv_coresight_cpm_ela2d@f0f70000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-coresight-cpm-ela2d-1.0";
   status = "okay";
   xlnx,ip-name = "psv_coresight_cpm_ela2d";
   reg = <0x0 0xf0f70000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_coresight_cpm_ela2d";
  };
  blp_cips_pspmc_0_psv_coresight_cpm_fun: blp_cips_pspmc_0_psv_coresight_cpm_fun@f0f20000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-coresight-cpm-fun-1.0";
   status = "okay";
   xlnx,ip-name = "psv_coresight_cpm_fun";
   reg = <0x0 0xf0f20000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_coresight_cpm_fun";
  };
  blp_cips_pspmc_0_psv_coresight_cpm_rom: blp_cips_pspmc_0_psv_coresight_cpm_rom@f0f00000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-coresight-cpm-rom-1.0";
   status = "okay";
   xlnx,ip-name = "psv_coresight_cpm_rom";
   reg = <0x0 0xf0f00000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_coresight_cpm_rom";
  };
  blp_cips_pspmc_0_psv_coresight_fpd_atm: blp_cips_pspmc_0_psv_coresight_fpd_atm@f0b80000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-coresight-fpd-atm-1.0";
   status = "okay";
   xlnx,ip-name = "psv_coresight_fpd_atm";
   reg = <0x0 0xf0b80000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_coresight_fpd_atm";
  };
  blp_cips_pspmc_0_psv_coresight_fpd_stm: blp_cips_pspmc_0_psv_coresight_fpd_stm@f0b70000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-coresight-fpd-stm-1.0";
   status = "okay";
   xlnx,ip-name = "psv_coresight_fpd_stm";
   reg = <0x0 0xf0b70000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_coresight_fpd_stm";
  };
  blp_cips_pspmc_0_psv_coresight_lpd_atm: blp_cips_pspmc_0_psv_coresight_lpd_atm@f0980000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-coresight-lpd-atm-1.0";
   status = "okay";
   xlnx,ip-name = "psv_coresight_lpd_atm";
   reg = <0x0 0xf0980000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_coresight_lpd_atm";
  };
  blp_cips_pspmc_0_psv_cpm: blp_cips_pspmc_0_psv_cpm@0 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-cpm-1.0";
   status = "okay";
   xlnx,ip-name = "psv_cpm";
   reg = <0x0 0xfc000000 0x0 0x1000000>;
   xlnx,name = "blp_cips_pspmc_0_psv_cpm";
  };
  blp_cips_pspmc_0_psv_crf_0: blp_cips_pspmc_0_psv_crf_0@fd1a0000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-crf-1.0";
   status = "okay";
   xlnx,ip-name = "psv_crf";
   reg = <0x0 0xfd1a0000 0x0 0x140000>;
   xlnx,name = "blp_cips_pspmc_0_psv_crf_0";
  };
  blp_cips_pspmc_0_psv_crl_0: blp_cips_pspmc_0_psv_crl_0@ff5e0000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-crl-1.0";
   status = "okay";
   xlnx,ip-name = "psv_crl";
   reg = <0x0 0xff5e0000 0x0 0x300000>;
   xlnx,name = "blp_cips_pspmc_0_psv_crl_0";
  };
  blp_cips_pspmc_0_psv_crp_0: blp_cips_pspmc_0_psv_crp_0@f1260000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-crp-1.0";
   status = "okay";
   xlnx,ip-name = "psv_crp";
   reg = <0x0 0xf1260000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_crp_0";
  };
  blp_cips_pspmc_0_psv_fpd_afi_0: blp_cips_pspmc_0_psv_fpd_afi_0@fd360000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-fpd-afi-1.0";
   status = "okay";
   xlnx,ip-name = "psv_fpd_afi";
   reg = <0x0 0xfd360000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_fpd_afi_0";
  };
  blp_cips_pspmc_0_psv_fpd_afi_2: blp_cips_pspmc_0_psv_fpd_afi_2@fd380000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-fpd-afi-1.0";
   status = "okay";
   xlnx,ip-name = "psv_fpd_afi";
   reg = <0x0 0xfd380000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_fpd_afi_2";
  };
  blp_cips_pspmc_0_psv_fpd_afi_mem_0: blp_cips_pspmc_0_psv_fpd_afi_mem_0@a4000000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-fpd-afi-mem-1.0";
   status = "okay";
   xlnx,ip-name = "psv_fpd_afi_mem";
   xlnx,is-hierarchy;
   reg = <0x0 0xa4000000 0x0 0xc000000>;
   xlnx,name = "blp_cips_pspmc_0_psv_fpd_afi_mem_0";
  };
  blp_cips_pspmc_0_psv_fpd_afi_mem_2: blp_cips_pspmc_0_psv_fpd_afi_mem_2@b0000000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-fpd-afi-mem-1.0";
   status = "okay";
   xlnx,ip-name = "psv_fpd_afi_mem";
   xlnx,is-hierarchy;
   reg = <0x0 0xb0000000 0x0 0x10000000>;
   xlnx,name = "blp_cips_pspmc_0_psv_fpd_afi_mem_2";
  };
  blp_cips_pspmc_0_psv_fpd_cci_0: blp_cips_pspmc_0_psv_fpd_cci_0@fd5e0000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-fpd-cci-1.0";
   status = "okay";
   xlnx,ip-name = "psv_fpd_cci";
   reg = <0x0 0xfd5e0000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_fpd_cci_0";
  };
  blp_cips_pspmc_0_psv_fpd_gpv_0: blp_cips_pspmc_0_psv_fpd_gpv_0@fd700000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-fpd-gpv-1.0";
   status = "okay";
   xlnx,ip-name = "psv_fpd_gpv";
   reg = <0x0 0xfd700000 0x0 0x100000>;
   xlnx,name = "blp_cips_pspmc_0_psv_fpd_gpv_0";
  };
  blp_cips_pspmc_0_psv_fpd_slcr_0: blp_cips_pspmc_0_psv_fpd_slcr_0@fd610000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-fpd-slcr-1.0";
   status = "okay";
   xlnx,ip-name = "psv_fpd_slcr";
   reg = <0x0 0xfd610000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_fpd_slcr_0";
  };
  blp_cips_pspmc_0_psv_fpd_slcr_secure_0: blp_cips_pspmc_0_psv_fpd_slcr_secure_0@fd690000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-fpd-slcr-secure-1.0";
   status = "okay";
   xlnx,ip-name = "psv_fpd_slcr_secure";
   reg = <0x0 0xfd690000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_fpd_slcr_secure_0";
  };
  blp_cips_pspmc_0_psv_fpd_smmu_0: blp_cips_pspmc_0_psv_fpd_smmu_0@fd5f0000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-fpd-smmu-1.0";
   status = "okay";
   xlnx,ip-name = "psv_fpd_smmu";
   reg = <0x0 0xfd5f0000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_fpd_smmu_0";
  };
  blp_cips_pspmc_0_psv_ipi_buffer: blp_cips_pspmc_0_psv_ipi_buffer@ff3f0000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-ipi-buffer-1.0";
   status = "okay";
   xlnx,ip-name = "psv_ipi_buffer";
   reg = <0x0 0xff3f0000 0x0 0x1000>;
   xlnx,name = "blp_cips_pspmc_0_psv_ipi_buffer";
  };
  blp_cips_pspmc_0_psv_lpd_afi_0: blp_cips_pspmc_0_psv_lpd_afi_0@ff9b0000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-lpd-afi-1.0";
   status = "okay";
   xlnx,ip-name = "psv_lpd_afi";
   reg = <0x0 0xff9b0000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_lpd_afi_0";
  };
  blp_cips_pspmc_0_psv_lpd_afi_mem_0: blp_cips_pspmc_0_psv_lpd_afi_mem_0@80000000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-lpd-afi-mem-1.0";
   status = "okay";
   xlnx,ip-name = "psv_lpd_afi_mem";
   xlnx,is-hierarchy;
   reg = <0x0 0x80000000 0x0 0x20000000>;
   xlnx,name = "blp_cips_pspmc_0_psv_lpd_afi_mem_0";
  };
  blp_cips_pspmc_0_psv_lpd_iou_secure_slcr_0: blp_cips_pspmc_0_psv_lpd_iou_secure_slcr_0@ff0a0000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-lpd-iou-secure-slcr-1.0";
   status = "okay";
   xlnx,ip-name = "psv_lpd_iou_secure_slcr";
   reg = <0x0 0xff0a0000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_lpd_iou_secure_slcr_0";
  };
  blp_cips_pspmc_0_psv_lpd_iou_slcr_0: blp_cips_pspmc_0_psv_lpd_iou_slcr_0@ff080000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-lpd-iou-slcr-1.0";
   status = "okay";
   xlnx,ip-name = "psv_lpd_iou_slcr";
   reg = <0x0 0xff080000 0x0 0x20000>;
   xlnx,name = "blp_cips_pspmc_0_psv_lpd_iou_slcr_0";
  };
  blp_cips_pspmc_0_psv_lpd_slcr_0: blp_cips_pspmc_0_psv_lpd_slcr_0@ff410000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-lpd-slcr-1.0";
   status = "okay";
   xlnx,ip-name = "psv_lpd_slcr";
   reg = <0x0 0xff410000 0x0 0x100000>;
   xlnx,name = "blp_cips_pspmc_0_psv_lpd_slcr_0";
  };
  blp_cips_pspmc_0_psv_lpd_slcr_secure_0: blp_cips_pspmc_0_psv_lpd_slcr_secure_0@ff510000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-lpd-slcr-secure-1.0";
   status = "okay";
   xlnx,ip-name = "psv_lpd_slcr_secure";
   reg = <0x0 0xff510000 0x0 0x40000>;
   xlnx,name = "blp_cips_pspmc_0_psv_lpd_slcr_secure_0";
  };
  blp_cips_pspmc_0_psv_ocm_ctrl: blp_cips_pspmc_0_psv_ocm_ctrl@ff960000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-ocm-1.0";
   status = "okay";
   power-domains = <&versal_firmware 0x18314007>;
   xlnx,ip-name = "psv_ocm";
   reg = <0x0 0xff960000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_ocm_ctrl";
  };
  blp_cips_pspmc_0_psv_pmc_aes: blp_cips_pspmc_0_psv_pmc_aes@f11e0000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-pmc-aes-1.0";
   status = "okay";
   xlnx,ip-name = "psv_pmc_aes";
   reg = <0x0 0xf11e0000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_pmc_aes";
  };
  blp_cips_pspmc_0_psv_pmc_bbram_ctrl: blp_cips_pspmc_0_psv_pmc_bbram_ctrl@f11f0000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-pmc-bbram-ctrl-1.0";
   status = "okay";
   xlnx,ip-name = "psv_pmc_bbram_ctrl";
   reg = <0x0 0xf11f0000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_pmc_bbram_ctrl";
  };
  blp_cips_pspmc_0_psv_pmc_cfi_cframe_0: blp_cips_pspmc_0_psv_pmc_cfi_cframe_0@f12d0000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-pmc-cfi-cframe-1.0";
   status = "okay";
   xlnx,ip-name = "psv_pmc_cfi_cframe";
   reg = <0x0 0xf12d0000 0x0 0x1000>;
   xlnx,name = "blp_cips_pspmc_0_psv_pmc_cfi_cframe_0";
  };
  blp_cips_pspmc_0_psv_pmc_cfu_apb_0: blp_cips_pspmc_0_psv_pmc_cfu_apb_0@f12b0000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-pmc-cfu-apb-1.0";
   status = "okay";
   xlnx,ip-name = "psv_pmc_cfu_apb";
   reg = <0x0 0xf12b0000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_pmc_cfu_apb_0";
  };
  blp_cips_pspmc_0_psv_pmc_efuse_cache: blp_cips_pspmc_0_psv_pmc_efuse_cache@f1250000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-pmc-efuse-cache-1.0";
   status = "okay";
   xlnx,ip-name = "psv_pmc_efuse_cache";
   reg = <0x0 0xf1250000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_pmc_efuse_cache";
  };
  blp_cips_pspmc_0_psv_pmc_efuse_ctrl: blp_cips_pspmc_0_psv_pmc_efuse_ctrl@f1240000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-pmc-efuse-ctrl-1.0";
   status = "okay";
   xlnx,ip-name = "psv_pmc_efuse_ctrl";
   reg = <0x0 0xf1240000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_pmc_efuse_ctrl";
  };
  blp_cips_pspmc_0_psv_pmc_global_0: blp_cips_pspmc_0_psv_pmc_global_0@f1110000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-pmc-global-1.0";
   status = "okay";
   xlnx,ip-name = "psv_pmc_global";
   reg = <0x0 0xf1110000 0x0 0x50000>;
   xlnx,npi-scan = <0>;
   xlnx,event-log = <0>;
   xlnx,cram-scan = <0>;
   xlnx,name = "blp_cips_pspmc_0_psv_pmc_global_0";
  };
  blp_cips_pspmc_0_psv_pmc_ppu1_mdm_0: blp_cips_pspmc_0_psv_pmc_ppu1_mdm_0@f0310000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-pmc-ppu1-mdm-1.0";
   status = "okay";
   xlnx,ip-name = "psv_pmc_ppu1_mdm";
   reg = <0x0 0xf0310000 0x0 0x8000>;
   xlnx,name = "blp_cips_pspmc_0_psv_pmc_ppu1_mdm_0";
  };
  blp_cips_pspmc_0_psv_pmc_ram: blp_cips_pspmc_0_psv_pmc_ram@f2000000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-pmc-ram-1.0";
   status = "okay";
   xlnx,ip-name = "psv_pmc_ram";
   reg = <0x0 0xf2000000 0x0 0x20000>;
   xlnx,name = "blp_cips_pspmc_0_psv_pmc_ram";
  };
  blp_cips_pspmc_0_psv_pmc_ram_data_cntlr: blp_cips_pspmc_0_psv_pmc_ram_data_cntlr@f0240000 {
   xlnx,edk-special = "BRAM_CTRL";
   xlnx,write-access = <2>;
   compatible = "xlnx,ram-data-cntlr-1.0";
   xlnx,ecc-onoff-register = <1>;
   xlnx,ecc-onoff-reset-value = <1>;
   xlnx,s-axi-ctrl-protocol = "AXI4LITE";
   xlnx,mask = <0xffffffff 0xffffe000>;
   xlnx,mask1 = <0xffffffff 0xffffe000>;
   xlnx,rable = <0>;
   xlnx,s-axi-ctrl-aclk-freq-hz = <100000000>;
   xlnx,mask2 = <0x800000>;
   xlnx,fault-inject = <1>;
   xlnx,mask3 = <0x800000>;
   xlnx,ip-name = "ram_data_cntlr";
   xlnx,num-lmb = <2>;
   reg = <0x0 0xf0240000 0x0 0x20000>;
   xlnx,s-axi-ctrl-addr-width = <32>;
   xlnx,ecc-status-registers = <1>;
   xlnx,ce-counter-width = <16>;
   xlnx,ecc = <1>;
   xlnx,edk-iptype = "PERIPHERAL";
   xlnx,lmb-dwidth = <32>;
   xlnx,interconnect = <2>;
   xlnx,ce-failing-registers = <1>;
   xlnx,ue-failing-registers = <1>;
   status = "okay";
   xlnx,s-axi-ctrl-data-width = <32>;
   xlnx,bram-awidth = <32>;
   xlnx,lmb-awidth = <32>;
   xlnx,name = "blp_cips_pspmc_0_psv_pmc_ram_data_cntlr";
  };
  blp_cips_pspmc_0_psv_pmc_ram_instr_cntlr: blp_cips_pspmc_0_psv_pmc_ram_instr_cntlr@f0200000 {
   xlnx,edk-special = "BRAM_CTRL";
   xlnx,write-access = <2>;
   compatible = "xlnx,ram-instr-cntlr-1.0";
   xlnx,ecc-onoff-register = <1>;
   xlnx,ecc-onoff-reset-value = <1>;
   xlnx,s-axi-ctrl-protocol = "AXI4LITE";
   xlnx,mask = <0xfffe0000>;
   xlnx,mask1 = <0xfffe0000>;
   xlnx,rable = <0>;
   xlnx,s-axi-ctrl-aclk-freq-hz = <100000000>;
   xlnx,mask2 = <0x800000>;
   xlnx,fault-inject = <1>;
   xlnx,mask3 = <0x800000>;
   xlnx,ip-name = "ram_instr_cntlr";
   xlnx,num-lmb = <2>;
   reg = <0x0 0xf0200000 0x0 0x40000>;
   xlnx,s-axi-ctrl-addr-width = <32>;
   xlnx,ecc-status-registers = <1>;
   xlnx,ce-counter-width = <16>;
   xlnx,ecc = <1>;
   xlnx,edk-iptype = "PERIPHERAL";
   xlnx,lmb-dwidth = <32>;
   xlnx,interconnect = <2>;
   xlnx,ce-failing-registers = <1>;
   xlnx,ue-failing-registers = <1>;
   status = "okay";
   xlnx,s-axi-ctrl-data-width = <32>;
   xlnx,bram-awidth = <32>;
   xlnx,lmb-awidth = <32>;
   xlnx,name = "blp_cips_pspmc_0_psv_pmc_ram_instr_cntlr";
  };
  blp_cips_pspmc_0_psv_pmc_ram_npi: blp_cips_pspmc_0_psv_pmc_ram_npi@f6000000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-pmc-ram-npi-1.0";
   status = "okay";
   xlnx,ip-name = "psv_pmc_ram_npi";
   reg = <0x0 0xf6000000 0x0 0x2000000>;
   xlnx,name = "blp_cips_pspmc_0_psv_pmc_ram_npi";
  };
  blp_cips_pspmc_0_psv_pmc_rsa: blp_cips_pspmc_0_psv_pmc_rsa@f1200000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-pmc-rsa-1.0";
   status = "okay";
   xlnx,ip-name = "psv_pmc_rsa";
   reg = <0x0 0xf1200000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_pmc_rsa";
  };
  blp_cips_pspmc_0_psv_pmc_sha: blp_cips_pspmc_0_psv_pmc_sha@f1210000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-pmc-sha-1.0";
   status = "okay";
   xlnx,ip-name = "psv_pmc_sha";
   reg = <0x0 0xf1210000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_pmc_sha";
  };
  blp_cips_pspmc_0_psv_pmc_slave_boot: blp_cips_pspmc_0_psv_pmc_slave_boot@f1220000 {
   xlnx,rable = <0>;
   xlnx,device-id = <0>;
   compatible = "xlnx,psv-pmc-slave-boot-1.0";
   status = "okay";
   xlnx,ip-name = "psv_pmc_slave_boot";
   reg = <0x0 0xf1220000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_pmc_slave_boot";
  };
  blp_cips_pspmc_0_psv_pmc_slave_boot_stream: blp_cips_pspmc_0_psv_pmc_slave_boot_stream@f2100000 {
   xlnx,rable = <0>;
   xlnx,device-id = <0>;
   compatible = "xlnx,psv-pmc-slave-boot-stream-1.0";
   status = "okay";
   xlnx,ip-name = "psv_pmc_slave_boot_stream";
   reg = <0x0 0xf2100000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_pmc_slave_boot_stream";
  };
  blp_cips_pspmc_0_psv_pmc_tmr_inject_0: blp_cips_pspmc_0_psv_pmc_tmr_inject_0@f0083000 {
   compatible = "xlnx,tmr-inject-1.0";
   xlnx,cpu-id = <1>;
   xlnx,edk-special = "tmr_inject";
   xlnx,mask = <0x84000>;
   xlnx,rable = <0>;
   xlnx,ip-name = "tmr_inject";
   reg = <0x0 0xf0083000 0x0 0x1000>;
   xlnx,magic = <0x27>;
   xlnx,lmb-dwidth = <32>;
   xlnx,edk-iptype = "PROCESSOR";
   status = "okay";
   xlnx,name = "blp_cips_pspmc_0_psv_pmc_tmr_inject_0";
   xlnx,lmb-awidth = <32>;
  };
  blp_cips_pspmc_0_psv_pmc_tmr_manager_0: blp_cips_pspmc_0_psv_pmc_tmr_manager_0@f0283000 {
   xlnx,edk-special = "BRAM_CTRL";
   xlnx,use-debug-disable = <0>;
   xlnx,sem-interface-type = <1>;
   compatible = "xlnx,tmr-manager-1.0";
   xlnx,magic1 = <0x0>;
   xlnx,tmr = <1>;
   xlnx,magic2 = <0x0>;
   xlnx,brk-delay-rst-value = <0x0>;
   xlnx,mask = <0x83000>;
   xlnx,sem-heartbeat-watchdog-width = <10>;
   xlnx,rable = <0>;
   xlnx,watchdog-width = <30>;
   xlnx,use-tmr-disable = <0>;
   xlnx,ue-width = <3>;
   xlnx,ip-name = "tmr_manager";
   xlnx,async-ff = <2>;
   xlnx,ue-is-fatal = <0>;
   xlnx,sem-heartbeat-watchdog = <0>;
   reg = <0x0 0xf0283000 0x0 0x1000>;
   xlnx,brk-delay-width = <0>;
   xlnx,watchdog = <0>;
   xlnx,sem-interface = <0>;
   xlnx,edk-iptype = "PERIPHERAL";
   xlnx,mask-rst-value = <0xffffffff 0xffffffff>;
   xlnx,comparators-mask = <0>;
   xlnx,lmb-dwidth = <32>;
   xlnx,test-comparator = <0>;
   xlnx,strict-miscompare = <0>;
   status = "okay";
   xlnx,no-of-comparators = <1>;
   xlnx,sem-async = <0>;
   xlnx,name = "blp_cips_pspmc_0_psv_pmc_tmr_manager_0";
   xlnx,lmb-awidth = <32>;
  };
  blp_cips_pspmc_0_psv_pmc_trng: blp_cips_pspmc_0_psv_pmc_trng@f1230000 {
   xlnx,rable = <0>;
   xlnx,device-id = <0>;
   compatible = "xlnx,psv-pmc-trng-1.0";
   status = "okay";
   xlnx,ip-name = "psv_pmc_trng";
   reg = <0x0 0xf1230000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_pmc_trng";
  };
  blp_cips_pspmc_0_psv_psm_global_reg: blp_cips_pspmc_0_psv_psm_global_reg@ffc90000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-psm-global-reg-1.0";
   status = "okay";
   xlnx,ip-name = "psv_psm_global_reg";
   reg = <0x0 0xffc90000 0x0 0xf000>;
   xlnx,name = "blp_cips_pspmc_0_psv_psm_global_reg";
  };
  blp_cips_pspmc_0_psv_psm_iomodule_0: blp_cips_pspmc_0_psv_psm_iomodule_0@ffc80000 {
   xlnx,gpo4-size = <32>;
   xlnx,tmr = <0>;
   xlnx,pit1-readable = <1>;
   xlnx,mask = <0xffff8000>;
   xlnx,pit-size = < 32 32 32 32 >;
   xlnx,pit2-prescaler = <0>;
   xlnx,gpi3-interrupt = <0>;
   xlnx,intc-level-edge = <0x7fff>;
   xlnx,rable = <0>;
   xlnx,intc-positive = <0xffff>;
   xlnx,ip-name = "iomodule";
   xlnx,gpo1-size = <3>;
   xlnx,max-intr-size = <32>;
   xlnx,pit3-size = <32>;
   xlnx,fit3-interrupt = <0>;
   reg = <0x0 0xffc80000 0x0 0x8000>;
   xlnx,fit1-no-clocks = <6216>;
   xlnx,gpi2-size = <32>;
   xlnx,pit2-readable = <1>;
   xlnx,intc-irq-connection = <0>;
   xlnx,uart-tx-interrupt = <1>;
   xlnx,use-config-reset = <0>;
   xlnx,pit2-interrupt = <1>;
   xlnx,intc-base-vectors = <0xffc00000>;
   compatible = "xlnx,iomodule-1.0" , "xlnx,iomodule-3.1";
   xlnx,gpo4-init = <0x0>;
   xlnx,pit3-readable = <1>;
   xlnx,pit3-prescaler = <9>;
   xlnx,gpi4-interrupt = <0>;
   xlnx,gpo1-init = <0x0>;
   xlnx,use-io-bus = <0>;
   xlnx,use-gpo1 = <1>;
   xlnx,uart-baudrate = <115200>;
   xlnx,fit4-interrupt = <0>;
   xlnx,gpo3-size = <32>;
   xlnx,use-gpo2 = <0>;
   xlnx,uart-data-bits = <8>;
   xlnx,pit-prescaler = < 9 0 9 0 >;
   xlnx,gpio1-board-interface = "Custom";
   xlnx,use-gpo3 = <0>;
   xlnx,fit2-no-clocks = <6216>;
   xlnx,options = <1>;
   xlnx,gpio2-board-interface = "Custom";
   xlnx,use-gpo4 = <0>;
   xlnx,gpi4-size = <32>;
   xlnx,gpio3-board-interface = "Custom";
   xlnx,uart-rx-interrupt = <1>;
   xlnx,uart-error-interrupt = <1>;
   xlnx,gpio4-board-interface = "Custom";
   xlnx,pit4-readable = <1>;
   status = "okay";
   xlnx,intc-use-irq-out = <0>;
   xlnx,clock-freq = <100000000>;
   xlnx,gpo-init = < 0 0 0 0 >;
   xlnx,use-board-flow;
   xlnx,pit2-size = <32>;
   xlnx,intc-intr-size = <16>;
   xlnx,intc-use-ext-intr = <1>;
   xlnx,name = "blp_cips_pspmc_0_psv_psm_iomodule_0";
   xlnx,gpi1-size = <32>;
   xlnx,edk-special = "INTR_CTRL";
   xlnx,pit3-interrupt = <1>;
   xlnx,intc-has-fast = <0>;
   xlnx,pit-used = < 1 1 1 1 >;
   xlnx,use-gpi1 = <0>;
   xlnx,gpi1-interrupt = <0>;
   xlnx,use-gpi2 = <0>;
   xlnx,use-gpi3 = <0>;
   xlnx,use-gpi4 = <0>;
   xlnx,fit1-interrupt = <0>;
   xlnx,pit4-prescaler = <0>;
   xlnx,gpo3-init = <0x0>;
   xlnx,intc-addr-width = <32>;
   xlnx,edk-iptype = "PERIPHERAL";
   xlnx,fit3-no-clocks = <6216>;
   xlnx,use-uart-rx = <1>;
   xlnx,instance = "iomodule_0";
   xlnx,pit-mask = <0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF>;
   xlnx,uart-prog-baudrate = <1>;
   xlnx,use-pit1 = <1>;
   xlnx,gpo2-size = <32>;
   xlnx,use-pit2 = <1>;
   xlnx,pit4-size = <32>;
   xlnx,pit-readable = < 1 1 1 1 >;
   xlnx,use-pit3 = <1>;
   xlnx,use-pit4 = <1>;
   xlnx,pit4-interrupt = <1>;
   xlnx,gpi3-size = <32>;
   xlnx,intc-async-intr = <0xffff>;
   xlnx,pit1-prescaler = <9>;
   xlnx,avoid-primitives = <0>;
   xlnx,gpi2-interrupt = <0>;
   xlnx,use-tmr-disable = <0>;
   xlnx,use-fit1 = <0>;
   xlnx,pit1-size = <32>;
   xlnx,intc-num-sync-ff = <2>;
   xlnx,uart-board-interface = "rs232_uart";
   xlnx,use-fit2 = <0>;
   xlnx,fit2-interrupt = <0>;
   xlnx,use-fit3 = <0>;
   xlnx,use-fit4 = <0>;
   xlnx,uart-use-parity = <0>;
   xlnx,lmb-dwidth = <32>;
   xlnx,fit4-no-clocks = <6216>;
   xlnx,uart-odd-parity = <0>;
   xlnx,freq = <100000000>;
   xlnx,use-uart-tx = <1>;
   xlnx,pit1-interrupt = <1>;
   xlnx,gpo2-init = <0x0>;
   xlnx,io-mask = <0xfffe0000>;
   xlnx,lmb-awidth = <32>;
  };
  blp_cips_pspmc_0_psv_psm_ram_data_cntlr: blp_cips_pspmc_0_psv_psm_ram_data_cntlr@ffc20000 {
   xlnx,edk-special = "BRAM_CTRL";
   xlnx,write-access = <2>;
   compatible = "xlnx,PSM-PPU-1.0";
   xlnx,ecc-onoff-register = <1>;
   xlnx,ecc-onoff-reset-value = <1>;
   xlnx,s-axi-ctrl-protocol = "AXI4LITE";
   xlnx,mask = <0xffffffff 0xffffe000>;
   xlnx,mask1 = <0xffffffff 0xffffe000>;
   xlnx,rable = <0>;
   xlnx,s-axi-ctrl-aclk-freq-hz = <100000000>;
   xlnx,mask2 = <0x800000>;
   xlnx,fault-inject = <1>;
   xlnx,mask3 = <0x800000>;
   xlnx,ip-name = "PSM_PPU";
   xlnx,num-lmb = <2>;
   reg = <0x0 0xffc20000 0x0 0x20000>;
   xlnx,s-axi-ctrl-addr-width = <32>;
   xlnx,ecc-status-registers = <1>;
   xlnx,ce-counter-width = <16>;
   xlnx,ecc = <1>;
   xlnx,edk-iptype = "PERIPHERAL";
   xlnx,lmb-dwidth = <32>;
   xlnx,interconnect = <2>;
   xlnx,ce-failing-registers = <1>;
   xlnx,ue-failing-registers = <1>;
   status = "okay";
   xlnx,s-axi-ctrl-data-width = <32>;
   xlnx,bram-awidth = <32>;
   xlnx,lmb-awidth = <32>;
   xlnx,name = "blp_cips_pspmc_0_psv_psm_ram_data_cntlr";
  };
  blp_cips_pspmc_0_psv_psm_ram_instr_cntlr: blp_cips_pspmc_0_psv_psm_ram_instr_cntlr@ffc00000 {
   xlnx,edk-special = "BRAM_CTRL";
   xlnx,write-access = <2>;
   compatible = "xlnx,ram-instr-cntlr-1.0";
   xlnx,ecc-onoff-register = <1>;
   xlnx,ecc-onoff-reset-value = <1>;
   xlnx,s-axi-ctrl-protocol = "AXI4LITE";
   xlnx,mask = <0xffffffff 0xfffe0000>;
   xlnx,mask1 = <0xffffffff 0xfffe0000>;
   xlnx,rable = <0>;
   xlnx,s-axi-ctrl-aclk-freq-hz = <100000000>;
   xlnx,mask2 = <0x800000>;
   xlnx,fault-inject = <1>;
   xlnx,mask3 = <0x800000>;
   xlnx,ip-name = "ram_instr_cntlr";
   xlnx,num-lmb = <2>;
   reg = <0x0 0xffc00000 0x0 0x20000>;
   xlnx,s-axi-ctrl-addr-width = <32>;
   xlnx,ecc-status-registers = <1>;
   xlnx,ce-counter-width = <16>;
   xlnx,ecc = <1>;
   xlnx,edk-iptype = "PERIPHERAL";
   xlnx,lmb-dwidth = <32>;
   xlnx,interconnect = <2>;
   xlnx,ce-failing-registers = <1>;
   xlnx,ue-failing-registers = <1>;
   status = "okay";
   xlnx,s-axi-ctrl-data-width = <32>;
   xlnx,bram-awidth = <32>;
   xlnx,lmb-awidth = <32>;
   xlnx,name = "blp_cips_pspmc_0_psv_psm_ram_instr_cntlr";
  };
  blp_cips_pspmc_0_psv_psm_tmr_inject_0: blp_cips_pspmc_0_psv_psm_tmr_inject_0@ffcd0000 {
   compatible = "xlnx,tmr-inject-1.0";
   xlnx,cpu-id = <1>;
   xlnx,edk-special = "tmr_inject";
   xlnx,mask = <0x50000>;
   xlnx,rable = <0>;
   xlnx,ip-name = "tmr_inject";
   reg = <0x0 0xffcd0000 0x0 0x10000>;
   xlnx,magic = <0x27>;
   xlnx,lmb-dwidth = <32>;
   xlnx,edk-iptype = "PROCESSOR";
   status = "okay";
   xlnx,name = "blp_cips_pspmc_0_psv_psm_tmr_inject_0";
   xlnx,lmb-awidth = <32>;
  };
  blp_cips_pspmc_0_psv_psm_tmr_manager_0: blp_cips_pspmc_0_psv_psm_tmr_manager_0@ffcc0000 {
   xlnx,edk-special = "BRAM_CTRL";
   xlnx,use-debug-disable = <0>;
   xlnx,sem-interface-type = <1>;
   compatible = "xlnx,tmr-manager-1.0";
   xlnx,magic1 = <0x0>;
   xlnx,tmr = <1>;
   xlnx,magic2 = <0x0>;
   xlnx,brk-delay-rst-value = <0x0>;
   xlnx,mask = <0x50000>;
   xlnx,sem-heartbeat-watchdog-width = <10>;
   xlnx,rable = <0>;
   xlnx,watchdog-width = <30>;
   xlnx,use-tmr-disable = <0>;
   xlnx,ue-width = <3>;
   xlnx,ip-name = "tmr_manager";
   xlnx,async-ff = <2>;
   xlnx,ue-is-fatal = <0>;
   xlnx,sem-heartbeat-watchdog = <0>;
   reg = <0x0 0xffcc0000 0x0 0x10000>;
   xlnx,brk-delay-width = <0>;
   xlnx,watchdog = <0>;
   xlnx,sem-interface = <0>;
   xlnx,edk-iptype = "PERIPHERAL";
   xlnx,mask-rst-value = <0xffffffff 0xffffffff>;
   xlnx,comparators-mask = <0>;
   xlnx,lmb-dwidth = <32>;
   xlnx,test-comparator = <0>;
   xlnx,strict-miscompare = <0>;
   status = "okay";
   xlnx,no-of-comparators = <1>;
   xlnx,sem-async = <0>;
   xlnx,name = "blp_cips_pspmc_0_psv_psm_tmr_manager_0";
   xlnx,lmb-awidth = <32>;
  };
  blp_cips_pspmc_0_psv_r5_0_atcm: blp_cips_pspmc_0_psv_r5_0_atcm@0 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-r5-tcm-1.0";
   status = "okay";
   xlnx,ip-name = "psv_r5_tcm";
   reg = <0x0 0x0000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_r5_0_atcm";
  };
  blp_cips_pspmc_0_psv_r5_0_atcm_lockstep: blp_cips_pspmc_0_psv_r5_0_atcm_lockstep@ffe10000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-r5-0-atcm-lockstep-1.0" , "mmio-sram";
   status = "okay";
   power-domains = <&versal_firmware 0x1831800b>;
   xlnx,ip-name = "psv_r5_0_atcm_lockstep";
   xlnx,is-hierarchy;
   reg = <0x0 0xffe10000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_r5_0_atcm_lockstep";
  };
  blp_cips_pspmc_0_psv_r5_0_btcm: blp_cips_pspmc_0_psv_r5_0_btcm@20000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-r5-tcm-1.0";
   status = "okay";
   xlnx,ip-name = "psv_r5_tcm";
   reg = <0x0 0x20000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_r5_0_btcm";
  };
  blp_cips_pspmc_0_psv_r5_0_btcm_lockstep: blp_cips_pspmc_0_psv_r5_0_btcm_lockstep@ffe30000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-r5-0-btcm-lockstep-1.0" , "mmio-sram";
   status = "okay";
   power-domains = <&versal_firmware 0x1831800c>;
   xlnx,ip-name = "psv_r5_0_btcm_lockstep";
   xlnx,is-hierarchy;
   reg = <0x0 0xffe30000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_r5_0_btcm_lockstep";
  };
  blp_cips_pspmc_0_psv_r5_0_data_cache: blp_cips_pspmc_0_psv_r5_0_data_cache@ffe50000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-r5-0-data-cache-1.0";
   status = "okay";
   xlnx,ip-name = "psv_r5_0_data_cache";
   reg = <0x0 0xffe50000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_r5_0_data_cache";
  };
  blp_cips_pspmc_0_psv_r5_0_instruction_cache: blp_cips_pspmc_0_psv_r5_0_instruction_cache@ffe40000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-r5-0-instruction-cache-1.0";
   status = "okay";
   xlnx,ip-name = "psv_r5_0_instruction_cache";
   reg = <0x0 0xffe40000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_r5_0_instruction_cache";
  };
  blp_cips_pspmc_0_psv_r5_1_atcm: blp_cips_pspmc_0_psv_r5_1_atcm@0 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-r5-tcm-1.0";
   status = "okay";
   xlnx,ip-name = "psv_r5_tcm";
   reg = <0x0 0x0000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_r5_1_atcm";
  };
  blp_cips_pspmc_0_psv_r5_1_btcm: blp_cips_pspmc_0_psv_r5_1_btcm@20000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-r5-tcm-1.0";
   status = "okay";
   xlnx,ip-name = "psv_r5_tcm";
   reg = <0x0 0x20000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_r5_1_btcm";
  };
  blp_cips_pspmc_0_psv_r5_1_data_cache: blp_cips_pspmc_0_psv_r5_1_data_cache@ffed0000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-r5-1-data-cache-1.0";
   status = "okay";
   xlnx,ip-name = "psv_r5_1_data_cache";
   reg = <0x0 0xffed0000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_r5_1_data_cache";
  };
  blp_cips_pspmc_0_psv_r5_1_instruction_cache: blp_cips_pspmc_0_psv_r5_1_instruction_cache@ffec0000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-r5-1-instruction-cache-1.0";
   status = "okay";
   xlnx,ip-name = "psv_r5_1_instruction_cache";
   reg = <0x0 0xffec0000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_r5_1_instruction_cache";
  };
  blp_cips_pspmc_0_psv_r5_tcm_ram_0: blp_cips_pspmc_0_psv_r5_tcm_ram_0@0 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-r5-tcm-1.0";
   status = "okay";
   xlnx,ip-name = "psv_r5_tcm";
   reg = <0x0 0x00000 0x0 0x40000>;
   xlnx,name = "blp_cips_pspmc_0_psv_r5_tcm_ram_0";
  };
  blp_cips_pspmc_0_psv_rpu_0: blp_cips_pspmc_0_psv_rpu_0@ff9a0000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-rpu-1.0";
   status = "okay";
   xlnx,ip-name = "psv_rpu";
   reg = <0x0 0xff9a0000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_rpu_0";
  };
  blp_cips_pspmc_0_psv_scntr_0: blp_cips_pspmc_0_psv_scntr_0@ff130000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-scntr-1.0";
   status = "okay";
   xlnx,ip-name = "psv_scntr";
   reg = <0x0 0xff130000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_scntr_0";
  };
  blp_cips_pspmc_0_psv_scntrs_0: blp_cips_pspmc_0_psv_scntrs_0@ff140000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-scntrs-1.0";
   status = "okay";
   xlnx,ip-name = "psv_scntrs";
   reg = <0x0 0xff140000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_scntrs_0";
  };
  blp_cips_pspmc_0_psv_xram_atm: blp_cips_pspmc_0_psv_xram_atm@ff970000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-atm-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_atm";
   reg = <0x0 0xff970000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_xram_atm";
  };
  blp_cips_pspmc_0_psv_xram_bank_1: blp_cips_pspmc_0_psv_xram_bank_1@fe800000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-bank-1-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_bank_1";
   reg = <0x0 0xfe800000 0x0 0x100000>;
   xlnx,name = "blp_cips_pspmc_0_psv_xram_bank_1";
  };
  blp_cips_pspmc_0_psv_xram_bank_2: blp_cips_pspmc_0_psv_xram_bank_2@fe900000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-bank-2-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_bank_2";
   reg = <0x0 0xfe900000 0x0 0x100000>;
   xlnx,name = "blp_cips_pspmc_0_psv_xram_bank_2";
  };
  blp_cips_pspmc_0_psv_xram_bank_3: blp_cips_pspmc_0_psv_xram_bank_3@fea00000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-bank-3-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_bank_3";
   reg = <0x0 0xfea00000 0x0 0x100000>;
   xlnx,name = "blp_cips_pspmc_0_psv_xram_bank_3";
  };
  blp_cips_pspmc_0_psv_xram_bank_4: blp_cips_pspmc_0_psv_xram_bank_4@feb00000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-bank-4-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_bank_4";
   reg = <0x0 0xfeb00000 0x0 0x100000>;
   xlnx,name = "blp_cips_pspmc_0_psv_xram_bank_4";
  };
  blp_cips_pspmc_0_psv_xram_ctrl_1: blp_cips_pspmc_0_psv_xram_ctrl_1@ff8e0000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-ctrl-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_ctrl";
   reg = <0x0 0xff8e0000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_xram_ctrl_1";
  };
  blp_cips_pspmc_0_psv_xram_ctrl_2: blp_cips_pspmc_0_psv_xram_ctrl_2@ff8f0000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-ctrl-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_ctrl";
   reg = <0x0 0xff8f0000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_xram_ctrl_2";
  };
  blp_cips_pspmc_0_psv_xram_ctrl_3: blp_cips_pspmc_0_psv_xram_ctrl_3@ff900000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-ctrl-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_ctrl";
   reg = <0x0 0xff900000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_xram_ctrl_3";
  };
  blp_cips_pspmc_0_psv_xram_ctrl_4: blp_cips_pspmc_0_psv_xram_ctrl_4@ff910000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-ctrl-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_ctrl";
   reg = <0x0 0xff910000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_xram_ctrl_4";
  };
  blp_cips_pspmc_0_psv_xram_global_ctrl: blp_cips_pspmc_0_psv_xram_global_ctrl@ff950000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-global-ctrl-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_global_ctrl";
   reg = <0x0 0xff950000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_xram_global_ctrl";
  };
  blp_cips_pspmc_0_psv_xram_gpv: blp_cips_pspmc_0_psv_xram_gpv@ff940000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-gpv-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_gpv";
   reg = <0x0 0xff940000 0x0 0x10000>;
   xlnx,name = "blp_cips_pspmc_0_psv_xram_gpv";
  };
  blp_cips_pspmc_0_psv_xram_xmpu_bank_1: blp_cips_pspmc_0_psv_xram_xmpu_bank_1@ff930000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-xmpu-bank-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_xmpu_bank";
   reg = <0x0 0xff930000 0x0 0x4000>;
   xlnx,name = "blp_cips_pspmc_0_psv_xram_xmpu_bank_1";
  };
  blp_cips_pspmc_0_psv_xram_xmpu_bank_2: blp_cips_pspmc_0_psv_xram_xmpu_bank_2@ff934000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-xmpu-bank-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_xmpu_bank";
   reg = <0x0 0xff934000 0x0 0x4000>;
   xlnx,name = "blp_cips_pspmc_0_psv_xram_xmpu_bank_2";
  };
  blp_cips_pspmc_0_psv_xram_xmpu_bank_3: blp_cips_pspmc_0_psv_xram_xmpu_bank_3@ff938000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-xmpu-bank-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_xmpu_bank";
   reg = <0x0 0xff938000 0x0 0x4000>;
   xlnx,name = "blp_cips_pspmc_0_psv_xram_xmpu_bank_3";
  };
  blp_cips_pspmc_0_psv_xram_xmpu_bank_4: blp_cips_pspmc_0_psv_xram_xmpu_bank_4@ff93c000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-xmpu-bank-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_xmpu_bank";
   reg = <0x0 0xff93c000 0x0 0x4000>;
   xlnx,name = "blp_cips_pspmc_0_psv_xram_xmpu_bank_4";
  };
  blp_cips_xram_psv_xram_atm: blp_cips_xram_psv_xram_atm@ff970000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-atm-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_atm";
   xlnx,is-hierarchy;
   reg = <0x0 0xff970000 0x0 0x10000>;
   xlnx,name = "blp_cips_xram_psv_xram_atm";
  };
  blp_cips_xram_psv_xram_bank_1: blp_cips_xram_psv_xram_bank_1@fe800000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-bank-1-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_bank_1";
   reg = <0x0 0xfe800000 0x0 0x100000>;
   xlnx,name = "blp_cips_xram_psv_xram_bank_1";
  };
  blp_cips_xram_psv_xram_bank_2: blp_cips_xram_psv_xram_bank_2@fe900000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-bank-2-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_bank_2";
   reg = <0x0 0xfe900000 0x0 0x100000>;
   xlnx,name = "blp_cips_xram_psv_xram_bank_2";
  };
  blp_cips_xram_psv_xram_bank_3: blp_cips_xram_psv_xram_bank_3@fea00000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-bank-3-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_bank_3";
   reg = <0x0 0xfea00000 0x0 0x100000>;
   xlnx,name = "blp_cips_xram_psv_xram_bank_3";
  };
  blp_cips_xram_psv_xram_bank_4: blp_cips_xram_psv_xram_bank_4@feb00000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-bank-4-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_bank_4";
   reg = <0x0 0xfeb00000 0x0 0x100000>;
   xlnx,name = "blp_cips_xram_psv_xram_bank_4";
  };
  blp_cips_xram_psv_xram_ctrl_1: blp_cips_xram_psv_xram_ctrl_1@ff8e0000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-ctrl-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_ctrl";
   xlnx,is-hierarchy;
   reg = <0x0 0xff8e0000 0x0 0x10000>;
   xlnx,name = "blp_cips_xram_psv_xram_ctrl_1";
  };
  blp_cips_xram_psv_xram_ctrl_2: blp_cips_xram_psv_xram_ctrl_2@ff8f0000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-ctrl-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_ctrl";
   xlnx,is-hierarchy;
   reg = <0x0 0xff8f0000 0x0 0x10000>;
   xlnx,name = "blp_cips_xram_psv_xram_ctrl_2";
  };
  blp_cips_xram_psv_xram_ctrl_3: blp_cips_xram_psv_xram_ctrl_3@ff900000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-ctrl-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_ctrl";
   xlnx,is-hierarchy;
   reg = <0x0 0xff900000 0x0 0xfffffffffff10000>;
   xlnx,name = "blp_cips_xram_psv_xram_ctrl_3";
  };
  blp_cips_xram_psv_xram_ctrl_4: blp_cips_xram_psv_xram_ctrl_4@ff910000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-ctrl-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_ctrl";
   xlnx,is-hierarchy;
   reg = <0x0 0xff910000 0x0 0x10000>;
   xlnx,name = "blp_cips_xram_psv_xram_ctrl_4";
  };
  blp_cips_xram_psv_xram_global_ctrl: blp_cips_xram_psv_xram_global_ctrl@ff950000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-global-ctrl-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_global_ctrl";
   xlnx,is-hierarchy;
   reg = <0x0 0xff950000 0x0 0x10000>;
   xlnx,name = "blp_cips_xram_psv_xram_global_ctrl";
  };
  blp_cips_xram_psv_xram_gpv: blp_cips_xram_psv_xram_gpv@ff940000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-gpv-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_gpv";
   xlnx,is-hierarchy;
   reg = <0x0 0xff940000 0x0 0x10000>;
   xlnx,name = "blp_cips_xram_psv_xram_gpv";
  };
  blp_cips_xram_psv_xram_xmpu_bank_1: blp_cips_xram_psv_xram_xmpu_bank_1@ff930000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-xmpu-bank-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_xmpu_bank";
   xlnx,is-hierarchy;
   reg = <0x0 0xff930000 0x0 0x4000>;
   xlnx,name = "blp_cips_xram_psv_xram_xmpu_bank_1";
  };
  blp_cips_xram_psv_xram_xmpu_bank_2: blp_cips_xram_psv_xram_xmpu_bank_2@ff934000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-xmpu-bank-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_xmpu_bank";
   xlnx,is-hierarchy;
   reg = <0x0 0xff934000 0x0 0x4000>;
   xlnx,name = "blp_cips_xram_psv_xram_xmpu_bank_2";
  };
  blp_cips_xram_psv_xram_xmpu_bank_3: blp_cips_xram_psv_xram_xmpu_bank_3@ff938000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-xmpu-bank-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_xmpu_bank";
   xlnx,is-hierarchy;
   reg = <0x0 0xff938000 0x0 0x4000>;
   xlnx,name = "blp_cips_xram_psv_xram_xmpu_bank_3";
  };
  blp_cips_xram_psv_xram_xmpu_bank_4: blp_cips_xram_psv_xram_xmpu_bank_4@ff93c000 {
   xlnx,rable = <0>;
   compatible = "xlnx,psv-xram-xmpu-bank-1.0";
   status = "okay";
   xlnx,ip-name = "psv_xram_xmpu_bank";
   xlnx,is-hierarchy;
   reg = <0x0 0xff93c000 0x0 0x1000>;
   xlnx,name = "blp_cips_xram_psv_xram_xmpu_bank_4";
  };
 };
 &psv_pmc_0 {
  xlnx,d-axi = <1>;
  xlnx,addr-tag-bits = <0>;
  xlnx,m-axi-dc-thread-id-width = <1>;
  xlnx,m0-axis-protocol = "GENERIC";
  xlnx,dcache-force-tag-lutram = <0>;
  xlnx,interrupt-is-edge = <0>;
  xlnx,use-mmu = <0>;
  xlnx,m-axi-dp-exclusive-access = <0>;
  xlnx,use-reorder-instr = <1>;
  xlnx,m14-axis-protocol = "GENERIC";
  xlnx,use-div = <1>;
  xlnx,dc-axi-mon = <0>;
  xlnx,m-axi-ic-user-signals = <0>;
  xlnx,use-config-reset = <0>;
  xlnx,s14-axis-protocol = "GENERIC";
  xlnx,mmu-zones = <16>;
  xlnx,enable-discrete-ports = <0>;
  xlnx,d-lmb = <1>;
  xlnx,m-axi-dc-exclusive-access = <0>;
  xlnx,debug-interface = <0>;
  xlnx,s9-axis-protocol = "GENERIC";
  xlnx,sco = <0>;
  xlnx,use-ext-brk = <0>;
  xlnx,debug-enabled = <1>;
  xlnx,daddr-size = <32>;
  xlnx,s0-axis-data-width = <32>;
  xlnx,use-extended-fsl-instr = <0>;
  xlnx,m-axi-dc-user-signals = <0>;
  xlnx,reset-msr = <0x0>;
  xlnx,branch-target-cache-size = <0>;
  xlnx,s2-axis-data-width = <32>;
  xlnx,cache-byte-size = <8192>;
  bus-handle = <&amba>;
  xlnx,mmu-tlb-access = <3>;
  xlnx,s4-axis-data-width = <32>;
  xlnx,m-axi-ic-awuser-width = <5>;
  xlnx,s6-axis-data-width = <32>;
  xlnx,s4-axis-protocol = "GENERIC";
  xlnx,s8-axis-data-width = <32>;
  xlnx,edk-special = "microblaze";
  xlnx,use-dcache = <0>;
  xlnx,m-axi-dp-addr-width = <32>;
  xlnx,m-axi-ic-wuser-width = <1>;
  xlnx,i-axi = <0>;
  xlnx,icache-streams = <0>;
  xlnx,m-axi-dc-awuser-width = <5>;
  xlnx,pss-ref-clk-freq = <33333300>;
  xlnx,use-stack-protection = <1>;
  xlnx,m6-axis-protocol = "GENERIC";
  xlnx,num-sync-ff-dbg-clk = <1>;
  xlnx,m-axi-ip-data-width = <32>;
  d-cache-size = <8192>;
  xlnx,use-pcmp-instr = <1>;
  xlnx,area-optimized = <0>;
  xlnx,avoid-primitives = <0>;
  xlnx,m1-axis-protocol = "GENERIC";
  xlnx,i-lmb = <1>;
  xlnx,lockstep-select = <0>;
  xlnx,dcache-data-width = <0>;
  xlnx,icache-force-tag-lutram = <0>;
  xlnx,m15-axis-protocol = "GENERIC";
  xlnx,use-branch-target-cache = <0>;
  xlnx,m-axi-ip-thread-id-width = <1>;
  xlnx,mmu-itlb-size = <2>;
  xlnx,number-of-pc-brk = <2>;
  xlnx,imprecise-exceptions = <0>;
  xlnx,m-axi-ic-buser-width = <1>;
  xlnx,m-axi-ic-addr-width = <32>;
  xlnx,s15-axis-protocol = "GENERIC";
  d-cache-highaddr = <0x3fffffff>;
  xlnx,m10-axis-protocol = "GENERIC";
  xlnx,optimization = <0>;
  xlnx,m-axi-ic-aruser-width = <5>;
  xlnx,d-lmb-mon = <0>;
  xlnx,s10-axis-protocol = "GENERIC";
  xlnx,m-axi-ic-ruser-width = <1>;
  xlnx,s5-axis-protocol = "GENERIC";
  xlnx,fault-tolerant = <1>;
  d-cache-line-size = <16>;
  xlnx,m-axi-dc-aruser-width = <5>;
  xlnx,mmu-privileged-instr = <0>;
  xlnx,m-axi-i-bus-exception = <0>;
  xlnx,reset-msr-eip = <0>;
  xlnx,endianness = <1>;
  xlnx,reset-msr-ice = <0>;
  xlnx,dp-axi-mon = <0>;
  xlnx,s10-axis-data-width = <32>;
  xlnx,s0-axis-protocol = "GENERIC";
  xlnx,s12-axis-data-width = <32>;
  xlnx,m7-axis-protocol = "GENERIC";
  xlnx,s14-axis-data-width = <32>;
  xlnx,m-axi-d-bus-exception = <1>;
  xlnx,reset-msr-bip = <1>;
  xlnx,debug-external-trace = <0>;
  xlnx,addr-size = <32>;
  xlnx,m-axi-ic-user-value = <31>;
  xlnx,m1-axis-data-width = <32>;
  xlnx,debug-event-counters = <5>;
  xlnx,m3-axis-data-width = <32>;
  xlnx,fpu-exception = <0>;
  xlnx,m2-axis-protocol = "GENERIC";
  xlnx,m5-axis-data-width = <32>;
  xlnx,m7-axis-data-width = <32>;
  xlnx,edk-iptype = "PROCESSOR";
  xlnx,debug-latency-counters = <1>;
  xlnx,interconnect = <2>;
  xlnx,m9-axis-data-width = <32>;
  xlnx,edge-is-positive = <1>;
  xlnx,use-icache = <0>;
  xlnx,async-wakeup = <3>;
  xlnx,m10-axis-data-width = <32>;
  xlnx,m12-axis-data-width = <32>;
  xlnx,use-ext-nm-brk = <0>;
  xlnx,m11-axis-protocol = "GENERIC";
  xlnx,m14-axis-data-width = <32>;
  xlnx,icache-always-used = <0>;
  xlnx,ic-axi-mon = <0>;
  xlnx,num-sync-ff-clk-irq = <1>;
  xlnx,freq = <320000000>;
  xlnx,lockstep-master = <0>;
  xlnx,s11-axis-protocol = "GENERIC";
  xlnx,use-msr-instr = <1>;
  xlnx,s6-axis-protocol = "GENERIC";
  xlnx,iaddr-size = <32>;
  xlnx,interrupt-mon = <0>;
  xlnx,m-axi-dc-data-width = <32>;
  xlnx,dynamic-bus-sizing = <0>;
  xlnx,number-of-wr-addr-brk = <1>;
  xlnx,use-interrupt = <1>;
  xlnx,m-axi-ip-addr-width = <32>;
  xlnx,async-interrupt = <1>;
  xlnx,pc-width = <32>;
  xlnx,icache-victims = <0>;
  xlnx,reset-msr-ee = <0>;
  xlnx,s1-axis-protocol = "GENERIC";
  xlnx,m8-axis-protocol = "GENERIC";
  i-cache-baseaddr = <0x0>;
  xlnx,i-lmb-mon = <0>;
  xlnx,dcache-byte-size = <8192>;
  xlnx,m-axi-dp-thread-id-width = <1>;
  xlnx,data-size = <32>;
  xlnx,m-axi-dc-wuser-width = <1>;
  xlnx,fsl-exception = <0>;
  xlnx,m3-axis-protocol = "GENERIC";
  xlnx,s1-axis-data-width = <32>;
  xlnx,dcache-use-writeback = <0>;
  xlnx,div-zero-exception = <1>;
  xlnx,s3-axis-data-width = <32>;
  xlnx,base-vectors = <0xf0240000>;
  xlnx,icache-line-len = <4>;
  xlnx,s5-axis-data-width = <32>;
  xlnx,s7-axis-data-width = <32>;
  xlnx,allow-dcache-wr = <1>;
  xlnx,s9-axis-data-width = <32>;
  xlnx,use-barrel = <1>;
  xlnx,g-use-exceptions = <1>;
  xlnx,dcache-line-len = <4>;
  xlnx,m12-axis-protocol = "GENERIC";
  xlnx,num-sync-ff-clk = <2>;
  i-cache-size = <8192>;
  xlnx,instance = "design_1_microblaze_0_0";
  xlnx,reset-msr-ie = <0>;
  xlnx,s12-axis-protocol = "GENERIC";
  xlnx,dcache-addr-tag = <0>;
  xlnx,m-axi-ic-thread-id-width = <1>;
  xlnx,number-of-rd-addr-brk = <1>;
  xlnx,m-axi-dc-buser-width = <1>;
  xlnx,s7-axis-protocol = "GENERIC";
  xlnx,lockstep-slave = <0>;
  xlnx,debug-profile-size = <0>;
  xlnx,s2-axis-protocol = "GENERIC";
  xlnx,m9-axis-protocol = "GENERIC";
  xlnx,debug-counter-width = <32>;
  xlnx,icache-data-width = <0>;
  xlnx,m-axi-dc-ruser-width = <1>;
  xlnx,reset-msr-dce = <0>;
  xlnx,rable = <0>;
  xlnx,ip-name = "psv_pmc";
  xlnx,ip-axi-mon = <0>;
  xlnx,m-axi-dp-data-width = <32>;
  xlnx,m4-axis-protocol = "GENERIC";
  xlnx,dcache-always-used = <0>;
  xlnx,ill-opcode-exception = <1>;
  xlnx,trace = <1>;
  xlnx,pvr = <2>;
  xlnx,debug-trace-size = <8192>;
  i-cache-line-size = <16>;
  xlnx,m13-axis-protocol = "GENERIC";
  xlnx,s11-axis-data-width = <32>;
  xlnx,m-axi-dc-addr-width = <32>;
  xlnx,s13-axis-data-width = <32>;
  xlnx,ecc-use-ce-exception = <0>;
  xlnx,opcode-0x0-illegal = <1>;
  xlnx,pvr-user2 = <0x0>;
  xlnx,s15-axis-data-width = <32>;
  xlnx,s13-axis-protocol = "GENERIC";
  xlnx,m0-axis-data-width = <32>;
  i-cache-highaddr = <0x3fffffff>;
  xlnx,s8-axis-protocol = "GENERIC";
  xlnx,m2-axis-data-width = <32>;
  xlnx,num-sync-ff-clk-debug = <2>;
  xlnx,allow-icache-wr = <1>;
  xlnx,m4-axis-data-width = <32>;
  xlnx,g-template-list = <0>;
  xlnx,m6-axis-data-width = <32>;
  xlnx,m-axi-ic-data-width = <32>;
  xlnx,m8-axis-data-width = <32>;
  xlnx,use-hw-mul = <2>;
  xlnx,use-fpu = <0>;
  xlnx,s3-axis-protocol = "GENERIC";
  xlnx,use-non-secure = <0>;
  d-cache-baseaddr = <0x0>;
  xlnx,m11-axis-data-width = <32>;
  xlnx,m13-axis-data-width = <32>;
  xlnx,instr-size = <32>;
  xlnx,m15-axis-data-width = <32>;
  xlnx,mmu-dtlb-size = <4>;
  xlnx,fsl-links = <0>;
  xlnx,m5-axis-protocol = "GENERIC";
  xlnx,dcache-victims = <0>;
  xlnx,m-axi-dc-user-value = <31>;
  xlnx,unaligned-exceptions = <1>;
 };
 &psv_psm_0 {
  xlnx,d-axi = <1>;
  xlnx,addr-tag-bits = <0>;
  xlnx,m-axi-dc-thread-id-width = <1>;
  xlnx,m0-axis-protocol = "GENERIC";
  xlnx,dcache-force-tag-lutram = <0>;
  xlnx,interrupt-is-edge = <0>;
  xlnx,use-mmu = <0>;
  xlnx,m-axi-dp-exclusive-access = <0>;
  xlnx,use-reorder-instr = <1>;
  xlnx,m14-axis-protocol = "GENERIC";
  xlnx,use-div = <1>;
  xlnx,dc-axi-mon = <0>;
  xlnx,m-axi-ic-user-signals = <0>;
  xlnx,use-config-reset = <0>;
  xlnx,s14-axis-protocol = "GENERIC";
  xlnx,mmu-zones = <16>;
  xlnx,enable-discrete-ports = <0>;
  xlnx,d-lmb = <1>;
  xlnx,m-axi-dc-exclusive-access = <0>;
  xlnx,debug-interface = <0>;
  xlnx,s9-axis-protocol = "GENERIC";
  xlnx,sco = <0>;
  xlnx,use-ext-brk = <0>;
  xlnx,debug-enabled = <1>;
  xlnx,daddr-size = <32>;
  xlnx,s0-axis-data-width = <32>;
  xlnx,use-extended-fsl-instr = <0>;
  xlnx,m-axi-dc-user-signals = <0>;
  xlnx,reset-msr = <0x0>;
  xlnx,branch-target-cache-size = <0>;
  xlnx,s2-axis-data-width = <32>;
  bus-handle = <&amba>;
  xlnx,cache-byte-size = <8192>;
  xlnx,mmu-tlb-access = <3>;
  xlnx,s4-axis-data-width = <32>;
  xlnx,m-axi-ic-awuser-width = <5>;
  xlnx,s6-axis-data-width = <32>;
  xlnx,s4-axis-protocol = "GENERIC";
  xlnx,s8-axis-data-width = <32>;
  xlnx,edk-special = "microblaze";
  xlnx,use-dcache = <0>;
  xlnx,m-axi-dp-addr-width = <32>;
  xlnx,m-axi-ic-wuser-width = <1>;
  xlnx,i-axi = <0>;
  xlnx,icache-streams = <0>;
  xlnx,m-axi-dc-awuser-width = <5>;
  xlnx,pss-ref-clk-freq = <33333300>;
  xlnx,use-stack-protection = <1>;
  xlnx,m6-axis-protocol = "GENERIC";
  xlnx,num-sync-ff-dbg-clk = <1>;
  xlnx,m-axi-ip-data-width = <32>;
  d-cache-size = <8192>;
  xlnx,use-pcmp-instr = <1>;
  xlnx,area-optimized = <0>;
  xlnx,avoid-primitives = <0>;
  xlnx,m1-axis-protocol = "GENERIC";
  xlnx,i-lmb = <1>;
  xlnx,lockstep-select = <0>;
  xlnx,dcache-data-width = <0>;
  xlnx,icache-force-tag-lutram = <0>;
  xlnx,m15-axis-protocol = "GENERIC";
  xlnx,use-branch-target-cache = <0>;
  xlnx,m-axi-ip-thread-id-width = <1>;
  xlnx,mmu-itlb-size = <2>;
  xlnx,number-of-pc-brk = <2>;
  xlnx,imprecise-exceptions = <0>;
  xlnx,m-axi-ic-buser-width = <1>;
  xlnx,m-axi-ic-addr-width = <32>;
  xlnx,s15-axis-protocol = "GENERIC";
  d-cache-highaddr = <0x3fffffff>;
  xlnx,m10-axis-protocol = "GENERIC";
  xlnx,optimization = <0>;
  xlnx,m-axi-ic-aruser-width = <5>;
  xlnx,d-lmb-mon = <0>;
  xlnx,s10-axis-protocol = "GENERIC";
  xlnx,m-axi-ic-ruser-width = <1>;
  xlnx,s5-axis-protocol = "GENERIC";
  xlnx,fault-tolerant = <1>;
  d-cache-line-size = <16>;
  xlnx,m-axi-dc-aruser-width = <5>;
  xlnx,mmu-privileged-instr = <0>;
  xlnx,m-axi-i-bus-exception = <0>;
  xlnx,reset-msr-eip = <0>;
  xlnx,endianness = <1>;
  xlnx,reset-msr-ice = <0>;
  xlnx,dp-axi-mon = <0>;
  xlnx,s10-axis-data-width = <32>;
  xlnx,s0-axis-protocol = "GENERIC";
  xlnx,s12-axis-data-width = <32>;
  xlnx,m7-axis-protocol = "GENERIC";
  xlnx,s14-axis-data-width = <32>;
  xlnx,m-axi-d-bus-exception = <1>;
  xlnx,reset-msr-bip = <1>;
  xlnx,debug-external-trace = <0>;
  xlnx,addr-size = <32>;
  xlnx,m-axi-ic-user-value = <31>;
  xlnx,m1-axis-data-width = <32>;
  xlnx,debug-event-counters = <5>;
  xlnx,m3-axis-data-width = <32>;
  xlnx,fpu-exception = <0>;
  xlnx,m2-axis-protocol = "GENERIC";
  xlnx,m5-axis-data-width = <32>;
  xlnx,m7-axis-data-width = <32>;
  xlnx,edk-iptype = "PROCESSOR";
  xlnx,debug-latency-counters = <1>;
  xlnx,interconnect = <2>;
  xlnx,m9-axis-data-width = <32>;
  xlnx,edge-is-positive = <1>;
  xlnx,use-icache = <0>;
  xlnx,async-wakeup = <3>;
  xlnx,m10-axis-data-width = <32>;
  xlnx,m12-axis-data-width = <32>;
  xlnx,use-ext-nm-brk = <0>;
  xlnx,m11-axis-protocol = "GENERIC";
  xlnx,m14-axis-data-width = <32>;
  xlnx,icache-always-used = <0>;
  xlnx,ic-axi-mon = <0>;
  xlnx,num-sync-ff-clk-irq = <1>;
  xlnx,freq = <100000000>;
  xlnx,lockstep-master = <0>;
  xlnx,s11-axis-protocol = "GENERIC";
  xlnx,use-msr-instr = <1>;
  xlnx,s6-axis-protocol = "GENERIC";
  xlnx,iaddr-size = <32>;
  xlnx,interrupt-mon = <0>;
  xlnx,m-axi-dc-data-width = <32>;
  xlnx,dynamic-bus-sizing = <0>;
  xlnx,number-of-wr-addr-brk = <1>;
  xlnx,use-interrupt = <1>;
  xlnx,m-axi-ip-addr-width = <32>;
  xlnx,async-interrupt = <1>;
  xlnx,pc-width = <32>;
  xlnx,icache-victims = <0>;
  xlnx,reset-msr-ee = <0>;
  xlnx,s1-axis-protocol = "GENERIC";
  xlnx,m8-axis-protocol = "GENERIC";
  i-cache-baseaddr = <0x0>;
  xlnx,i-lmb-mon = <0>;
  xlnx,dcache-byte-size = <8192>;
  xlnx,m-axi-dp-thread-id-width = <1>;
  xlnx,data-size = <32>;
  xlnx,m-axi-dc-wuser-width = <1>;
  xlnx,fsl-exception = <0>;
  xlnx,m3-axis-protocol = "GENERIC";
  xlnx,s1-axis-data-width = <32>;
  xlnx,dcache-use-writeback = <0>;
  xlnx,div-zero-exception = <1>;
  xlnx,s3-axis-data-width = <32>;
  xlnx,base-vectors = <0xffc00000>;
  xlnx,icache-line-len = <4>;
  xlnx,s5-axis-data-width = <32>;
  xlnx,s7-axis-data-width = <32>;
  xlnx,allow-dcache-wr = <1>;
  xlnx,s9-axis-data-width = <32>;
  xlnx,use-barrel = <1>;
  xlnx,g-use-exceptions = <1>;
  xlnx,dcache-line-len = <4>;
  xlnx,m12-axis-protocol = "GENERIC";
  xlnx,num-sync-ff-clk = <2>;
  i-cache-size = <8192>;
  xlnx,instance = "design_1_microblaze_0_0";
  xlnx,reset-msr-ie = <0>;
  xlnx,s12-axis-protocol = "GENERIC";
  xlnx,dcache-addr-tag = <0>;
  xlnx,m-axi-ic-thread-id-width = <1>;
  xlnx,number-of-rd-addr-brk = <1>;
  xlnx,m-axi-dc-buser-width = <1>;
  xlnx,s7-axis-protocol = "GENERIC";
  xlnx,lockstep-slave = <0>;
  xlnx,debug-profile-size = <0>;
  xlnx,s2-axis-protocol = "GENERIC";
  xlnx,m9-axis-protocol = "GENERIC";
  xlnx,debug-counter-width = <32>;
  xlnx,icache-data-width = <0>;
  xlnx,m-axi-dc-ruser-width = <1>;
  xlnx,reset-msr-dce = <0>;
  xlnx,rable = <0>;
  xlnx,ip-name = "psv_psm";
  xlnx,ip-axi-mon = <0>;
  xlnx,m-axi-dp-data-width = <32>;
  xlnx,m4-axis-protocol = "GENERIC";
  xlnx,dcache-always-used = <0>;
  xlnx,ill-opcode-exception = <1>;
  xlnx,trace = <1>;
  xlnx,pvr = <2>;
  xlnx,debug-trace-size = <8192>;
  i-cache-line-size = <16>;
  xlnx,m13-axis-protocol = "GENERIC";
  xlnx,s11-axis-data-width = <32>;
  xlnx,m-axi-dc-addr-width = <32>;
  xlnx,s13-axis-data-width = <32>;
  xlnx,ecc-use-ce-exception = <0>;
  xlnx,opcode-0x0-illegal = <1>;
  xlnx,pvr-user2 = <0x0>;
  xlnx,s15-axis-data-width = <32>;
  xlnx,s13-axis-protocol = "GENERIC";
  xlnx,m0-axis-data-width = <32>;
  i-cache-highaddr = <0x3fffffff>;
  xlnx,s8-axis-protocol = "GENERIC";
  xlnx,m2-axis-data-width = <32>;
  xlnx,num-sync-ff-clk-debug = <2>;
  xlnx,allow-icache-wr = <1>;
  xlnx,m4-axis-data-width = <32>;
  xlnx,g-template-list = <0>;
  xlnx,m6-axis-data-width = <32>;
  xlnx,m-axi-ic-data-width = <32>;
  xlnx,m8-axis-data-width = <32>;
  xlnx,use-hw-mul = <2>;
  xlnx,use-fpu = <0>;
  xlnx,s3-axis-protocol = "GENERIC";
  xlnx,use-non-secure = <0>;
  d-cache-baseaddr = <0x0>;
  xlnx,m11-axis-data-width = <32>;
  xlnx,m13-axis-data-width = <32>;
  xlnx,instr-size = <32>;
  xlnx,m15-axis-data-width = <32>;
  xlnx,mmu-dtlb-size = <4>;
  xlnx,fsl-links = <0>;
  xlnx,m5-axis-protocol = "GENERIC";
  xlnx,dcache-victims = <0>;
  xlnx,m-axi-dc-user-value = <31>;
  xlnx,unaligned-exceptions = <1>;
 };
 &lpd_dma_chan0 {
  xlnx,rable = <0>;
  xlnx,is-cache-coherent = <0>;
  status = "okay";
  xlnx,ip-name = "psv_adma";
  xlnx,dma-mode = <1>;
  xlnx,name = "blp_cips_pspmc_0_psv_adma_0";
 };
 &lpd_dma_chan1 {
  xlnx,rable = <0>;
  xlnx,is-cache-coherent = <0>;
  status = "okay";
  xlnx,ip-name = "psv_adma";
  xlnx,dma-mode = <1>;
  xlnx,name = "blp_cips_pspmc_0_psv_adma_1";
 };
 &lpd_dma_chan2 {
  xlnx,rable = <0>;
  xlnx,is-cache-coherent = <0>;
  status = "okay";
  xlnx,ip-name = "psv_adma";
  xlnx,dma-mode = <1>;
  xlnx,name = "blp_cips_pspmc_0_psv_adma_2";
 };
 &lpd_dma_chan3 {
  xlnx,rable = <0>;
  xlnx,is-cache-coherent = <0>;
  status = "okay";
  xlnx,ip-name = "psv_adma";
  xlnx,dma-mode = <1>;
  xlnx,name = "blp_cips_pspmc_0_psv_adma_3";
 };
 &lpd_dma_chan4 {
  xlnx,rable = <0>;
  xlnx,is-cache-coherent = <0>;
  status = "okay";
  xlnx,ip-name = "psv_adma";
  xlnx,dma-mode = <1>;
  xlnx,name = "blp_cips_pspmc_0_psv_adma_4";
 };
 &lpd_dma_chan5 {
  xlnx,rable = <0>;
  xlnx,is-cache-coherent = <0>;
  status = "okay";
  xlnx,ip-name = "psv_adma";
  xlnx,dma-mode = <1>;
  xlnx,name = "blp_cips_pspmc_0_psv_adma_5";
 };
 &lpd_dma_chan6 {
  xlnx,rable = <0>;
  xlnx,is-cache-coherent = <0>;
  status = "okay";
  xlnx,ip-name = "psv_adma";
  xlnx,dma-mode = <1>;
  xlnx,name = "blp_cips_pspmc_0_psv_adma_6";
 };
 &lpd_dma_chan7 {
  xlnx,rable = <0>;
  xlnx,is-cache-coherent = <0>;
  status = "okay";
  xlnx,ip-name = "psv_adma";
  xlnx,dma-mode = <1>;
  xlnx,name = "blp_cips_pspmc_0_psv_adma_7";
 };
 &coresight {
  xlnx,rable = <0>;
  status = "okay";
  xlnx,ip-name = "psv_coresight";
  xlnx,name = "blp_cips_pspmc_0_psv_coresight_0";
 };
 &cci {
  xlnx,rable = <0>;
  status = "okay";
  xlnx,ip-name = "psv_fpd_maincci";
  xlnx,name = "blp_cips_pspmc_0_psv_fpd_maincci_0";
 };
 &fpd_xmpu {
  xlnx,rable = <0>;
  status = "okay";
  xlnx,ip-name = "psv_fpd_slave_xmpu";
  xlnx,name = "blp_cips_pspmc_0_psv_fpd_slave_xmpu_0";
 };
 &smmu {
  xlnx,rable = <0>;
  status = "okay";
  xlnx,ip-name = "psv_fpd_smmutcu";
  xlnx,name = "blp_cips_pspmc_0_psv_fpd_smmutcu_0";
 };
 &gpio0 {
  xlnx,rable = <0>;
  status = "okay";
  xlnx,ip-name = "psv_gpio";
  emio-gpio-width = "";
  xlnx,name = "blp_cips_pspmc_0_psv_gpio_2";
 };
 &ipi0 {
  xlnx,rable = <0>;
  xlnx,cpu-name = "A72";
  xlnx,buffer-base = <0xff3f0400>;
  status = "okay";
  xlnx,buffer-index = <0x2>;
  xlnx,ip-name = "psv_ipi";
  xlnx,ipi-target-count = <10>;
  xlnx,int-id = <62>;
  xlnx,bit-position = <2>;
  xlnx,name = "blp_cips_pspmc_0_psv_ipi_0";
  blp_cips_pspmc_0_psv_ipi_0_0: child@0 {
   xlnx,ipi-bitmask = <4>;
   xlnx,ipi-rsp-msg-buf = <0xff3f04a0>;
   xlnx,ipi-id = <2>;
   xlnx,ipi-buf-index = <0x2>;
   xlnx,ipi-req-msg-buf = <0xff3f0480>;
  };
  blp_cips_pspmc_0_psv_ipi_0_1: child@1 {
   xlnx,ipi-bitmask = <8>;
   xlnx,ipi-rsp-msg-buf = <0xff3f04e0>;
   xlnx,ipi-id = <3>;
   xlnx,ipi-buf-index = <0x3>;
   xlnx,ipi-req-msg-buf = <0xff3f04c0>;
  };
  blp_cips_pspmc_0_psv_ipi_0_2: child@2 {
   xlnx,ipi-bitmask = <16>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0520>;
   xlnx,ipi-id = <4>;
   xlnx,ipi-buf-index = <0x4>;
   xlnx,ipi-req-msg-buf = <0xff3f0500>;
  };
  blp_cips_pspmc_0_psv_ipi_0_3: child@3 {
   xlnx,ipi-bitmask = <32>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0560>;
   xlnx,ipi-id = <5>;
   xlnx,ipi-buf-index = <0x5>;
   xlnx,ipi-req-msg-buf = <0xff3f0540>;
  };
  blp_cips_pspmc_0_psv_ipi_0_4: child@4 {
   xlnx,ipi-bitmask = <64>;
   xlnx,ipi-rsp-msg-buf = <0xff3f05a0>;
   xlnx,ipi-id = <6>;
   xlnx,ipi-buf-index = <0x6>;
   xlnx,ipi-req-msg-buf = <0xff3f0580>;
  };
  blp_cips_pspmc_0_psv_ipi_0_5: child@5 {
   xlnx,ipi-bitmask = <128>;
   xlnx,ipi-rsp-msg-buf = <0xff3f05e0>;
   xlnx,ipi-id = <7>;
   xlnx,ipi-buf-index = <0x7>;
   xlnx,ipi-req-msg-buf = <0xff3f05c0>;
  };
  blp_cips_pspmc_0_psv_ipi_0_6: child@6 {
   xlnx,ipi-bitmask = <512>;
   xlnx,ipi-id = <9>;
   xlnx,ipi-buf-index = <0xffff>;
  };
  blp_cips_pspmc_0_psv_ipi_0_7: child@7 {
   xlnx,ipi-bitmask = <2>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0460>;
   xlnx,ipi-id = <1>;
   xlnx,ipi-buf-index = <0x1>;
   xlnx,ipi-req-msg-buf = <0xff3f0440>;
  };
  blp_cips_pspmc_0_psv_ipi_0_8: child@8 {
   xlnx,ipi-bitmask = <256>;
   xlnx,ipi-id = <8>;
   xlnx,ipi-buf-index = <0xffff>;
  };
  blp_cips_pspmc_0_psv_ipi_0_9: child@9 {
   xlnx,ipi-bitmask = <1>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0420>;
   xlnx,ipi-id = <0>;
   xlnx,ipi-buf-index = <0x0>;
   xlnx,ipi-req-msg-buf = <0xff3f0400>;
  };
 };
 &ipi1 {
  xlnx,rable = <0>;
  xlnx,cpu-name = "A72";
  xlnx,buffer-base = <0xff3f0600>;
  status = "okay";
  xlnx,buffer-index = <0x3>;
  xlnx,ip-name = "psv_ipi";
  xlnx,ipi-target-count = <10>;
  xlnx,int-id = <63>;
  xlnx,bit-position = <3>;
  xlnx,name = "blp_cips_pspmc_0_psv_ipi_1";
  blp_cips_pspmc_0_psv_ipi_1_0: child@0 {
   xlnx,ipi-bitmask = <4>;
   xlnx,ipi-rsp-msg-buf = <0xff3f06a0>;
   xlnx,ipi-id = <2>;
   xlnx,ipi-buf-index = <0x2>;
   xlnx,ipi-req-msg-buf = <0xff3f0680>;
  };
  blp_cips_pspmc_0_psv_ipi_1_1: child@1 {
   xlnx,ipi-bitmask = <8>;
   xlnx,ipi-rsp-msg-buf = <0xff3f06e0>;
   xlnx,ipi-id = <3>;
   xlnx,ipi-buf-index = <0x3>;
   xlnx,ipi-req-msg-buf = <0xff3f06c0>;
  };
  blp_cips_pspmc_0_psv_ipi_1_2: child@2 {
   xlnx,ipi-bitmask = <16>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0720>;
   xlnx,ipi-id = <4>;
   xlnx,ipi-buf-index = <0x4>;
   xlnx,ipi-req-msg-buf = <0xff3f0700>;
  };
  blp_cips_pspmc_0_psv_ipi_1_3: child@3 {
   xlnx,ipi-bitmask = <32>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0760>;
   xlnx,ipi-id = <5>;
   xlnx,ipi-buf-index = <0x5>;
   xlnx,ipi-req-msg-buf = <0xff3f0740>;
  };
  blp_cips_pspmc_0_psv_ipi_1_4: child@4 {
   xlnx,ipi-bitmask = <64>;
   xlnx,ipi-rsp-msg-buf = <0xff3f07a0>;
   xlnx,ipi-id = <6>;
   xlnx,ipi-buf-index = <0x6>;
   xlnx,ipi-req-msg-buf = <0xff3f0780>;
  };
  blp_cips_pspmc_0_psv_ipi_1_5: child@5 {
   xlnx,ipi-bitmask = <128>;
   xlnx,ipi-rsp-msg-buf = <0xff3f07e0>;
   xlnx,ipi-id = <7>;
   xlnx,ipi-buf-index = <0x7>;
   xlnx,ipi-req-msg-buf = <0xff3f07c0>;
  };
  blp_cips_pspmc_0_psv_ipi_1_6: child@6 {
   xlnx,ipi-bitmask = <512>;
   xlnx,ipi-id = <9>;
   xlnx,ipi-buf-index = <0xffff>;
  };
  blp_cips_pspmc_0_psv_ipi_1_7: child@7 {
   xlnx,ipi-bitmask = <2>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0660>;
   xlnx,ipi-id = <1>;
   xlnx,ipi-buf-index = <0x1>;
   xlnx,ipi-req-msg-buf = <0xff3f0640>;
  };
  blp_cips_pspmc_0_psv_ipi_1_8: child@8 {
   xlnx,ipi-bitmask = <256>;
   xlnx,ipi-id = <8>;
   xlnx,ipi-buf-index = <0xffff>;
  };
  blp_cips_pspmc_0_psv_ipi_1_9: child@9 {
   xlnx,ipi-bitmask = <1>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0620>;
   xlnx,ipi-id = <0>;
   xlnx,ipi-buf-index = <0x0>;
   xlnx,ipi-req-msg-buf = <0xff3f0600>;
  };
 };
 &ipi2 {
  xlnx,rable = <0>;
  xlnx,cpu-name = "A72";
  xlnx,buffer-base = <0xff3f0800>;
  status = "okay";
  xlnx,buffer-index = <0x4>;
  xlnx,ip-name = "psv_ipi";
  xlnx,ipi-target-count = <10>;
  xlnx,int-id = <64>;
  xlnx,bit-position = <4>;
  xlnx,name = "blp_cips_pspmc_0_psv_ipi_2";
  blp_cips_pspmc_0_psv_ipi_2_0: child@0 {
   xlnx,ipi-bitmask = <4>;
   xlnx,ipi-rsp-msg-buf = <0xff3f08a0>;
   xlnx,ipi-id = <2>;
   xlnx,ipi-buf-index = <0x2>;
   xlnx,ipi-req-msg-buf = <0xff3f0880>;
  };
  blp_cips_pspmc_0_psv_ipi_2_1: child@1 {
   xlnx,ipi-bitmask = <8>;
   xlnx,ipi-rsp-msg-buf = <0xff3f08e0>;
   xlnx,ipi-id = <3>;
   xlnx,ipi-buf-index = <0x3>;
   xlnx,ipi-req-msg-buf = <0xff3f08c0>;
  };
  blp_cips_pspmc_0_psv_ipi_2_2: child@2 {
   xlnx,ipi-bitmask = <16>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0920>;
   xlnx,ipi-id = <4>;
   xlnx,ipi-buf-index = <0x4>;
   xlnx,ipi-req-msg-buf = <0xff3f0900>;
  };
  blp_cips_pspmc_0_psv_ipi_2_3: child@3 {
   xlnx,ipi-bitmask = <32>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0960>;
   xlnx,ipi-id = <5>;
   xlnx,ipi-buf-index = <0x5>;
   xlnx,ipi-req-msg-buf = <0xff3f0940>;
  };
  blp_cips_pspmc_0_psv_ipi_2_4: child@4 {
   xlnx,ipi-bitmask = <64>;
   xlnx,ipi-rsp-msg-buf = <0xff3f09a0>;
   xlnx,ipi-id = <6>;
   xlnx,ipi-buf-index = <0x6>;
   xlnx,ipi-req-msg-buf = <0xff3f0980>;
  };
  blp_cips_pspmc_0_psv_ipi_2_5: child@5 {
   xlnx,ipi-bitmask = <128>;
   xlnx,ipi-rsp-msg-buf = <0xff3f09e0>;
   xlnx,ipi-id = <7>;
   xlnx,ipi-buf-index = <0x7>;
   xlnx,ipi-req-msg-buf = <0xff3f09c0>;
  };
  blp_cips_pspmc_0_psv_ipi_2_6: child@6 {
   xlnx,ipi-bitmask = <512>;
   xlnx,ipi-id = <9>;
   xlnx,ipi-buf-index = <0xffff>;
  };
  blp_cips_pspmc_0_psv_ipi_2_7: child@7 {
   xlnx,ipi-bitmask = <2>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0860>;
   xlnx,ipi-id = <1>;
   xlnx,ipi-buf-index = <0x1>;
   xlnx,ipi-req-msg-buf = <0xff3f0840>;
  };
  blp_cips_pspmc_0_psv_ipi_2_8: child@8 {
   xlnx,ipi-bitmask = <256>;
   xlnx,ipi-id = <8>;
   xlnx,ipi-buf-index = <0xffff>;
  };
  blp_cips_pspmc_0_psv_ipi_2_9: child@9 {
   xlnx,ipi-bitmask = <1>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0820>;
   xlnx,ipi-id = <0>;
   xlnx,ipi-buf-index = <0x0>;
   xlnx,ipi-req-msg-buf = <0xff3f0800>;
  };
 };
 &ipi3 {
  xlnx,rable = <0>;
  xlnx,cpu-name = "R5_0";
  xlnx,buffer-base = <0xff3f0a00>;
  status = "okay";
  xlnx,buffer-index = <0x5>;
  xlnx,ip-name = "psv_ipi";
  xlnx,ipi-target-count = <10>;
  xlnx,int-id = <65>;
  xlnx,bit-position = <5>;
  xlnx,name = "blp_cips_pspmc_0_psv_ipi_3";
  blp_cips_pspmc_0_psv_ipi_3_0: child@0 {
   xlnx,ipi-bitmask = <4>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0aa0>;
   xlnx,ipi-id = <2>;
   xlnx,ipi-buf-index = <0x2>;
   xlnx,ipi-req-msg-buf = <0xff3f0a80>;
  };
  blp_cips_pspmc_0_psv_ipi_3_1: child@1 {
   xlnx,ipi-bitmask = <8>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0ae0>;
   xlnx,ipi-id = <3>;
   xlnx,ipi-buf-index = <0x3>;
   xlnx,ipi-req-msg-buf = <0xff3f0ac0>;
  };
  blp_cips_pspmc_0_psv_ipi_3_2: child@2 {
   xlnx,ipi-bitmask = <16>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0b20>;
   xlnx,ipi-id = <4>;
   xlnx,ipi-buf-index = <0x4>;
   xlnx,ipi-req-msg-buf = <0xff3f0b00>;
  };
  blp_cips_pspmc_0_psv_ipi_3_3: child@3 {
   xlnx,ipi-bitmask = <32>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0b60>;
   xlnx,ipi-id = <5>;
   xlnx,ipi-buf-index = <0x5>;
   xlnx,ipi-req-msg-buf = <0xff3f0b40>;
  };
  blp_cips_pspmc_0_psv_ipi_3_4: child@4 {
   xlnx,ipi-bitmask = <64>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0ba0>;
   xlnx,ipi-id = <6>;
   xlnx,ipi-buf-index = <0x6>;
   xlnx,ipi-req-msg-buf = <0xff3f0b80>;
  };
  blp_cips_pspmc_0_psv_ipi_3_5: child@5 {
   xlnx,ipi-bitmask = <128>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0be0>;
   xlnx,ipi-id = <7>;
   xlnx,ipi-buf-index = <0x7>;
   xlnx,ipi-req-msg-buf = <0xff3f0bc0>;
  };
  blp_cips_pspmc_0_psv_ipi_3_6: child@6 {
   xlnx,ipi-bitmask = <512>;
   xlnx,ipi-id = <9>;
   xlnx,ipi-buf-index = <0xffff>;
  };
  blp_cips_pspmc_0_psv_ipi_3_7: child@7 {
   xlnx,ipi-bitmask = <2>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0a60>;
   xlnx,ipi-id = <1>;
   xlnx,ipi-buf-index = <0x1>;
   xlnx,ipi-req-msg-buf = <0xff3f0a40>;
  };
  blp_cips_pspmc_0_psv_ipi_3_8: child@8 {
   xlnx,ipi-bitmask = <256>;
   xlnx,ipi-id = <8>;
   xlnx,ipi-buf-index = <0xffff>;
  };
  blp_cips_pspmc_0_psv_ipi_3_9: child@9 {
   xlnx,ipi-bitmask = <1>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0a20>;
   xlnx,ipi-id = <0>;
   xlnx,ipi-buf-index = <0x0>;
   xlnx,ipi-req-msg-buf = <0xff3f0a00>;
  };
 };
 &ipi4 {
  xlnx,rable = <0>;
  xlnx,cpu-name = "R5_0";
  xlnx,buffer-base = <0xff3f0c00>;
  status = "okay";
  xlnx,buffer-index = <0x6>;
  xlnx,ip-name = "psv_ipi";
  xlnx,ipi-target-count = <10>;
  xlnx,int-id = <66>;
  xlnx,bit-position = <6>;
  xlnx,name = "blp_cips_pspmc_0_psv_ipi_4";
  blp_cips_pspmc_0_psv_ipi_4_0: child@0 {
   xlnx,ipi-bitmask = <4>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0ca0>;
   xlnx,ipi-id = <2>;
   xlnx,ipi-buf-index = <0x2>;
   xlnx,ipi-req-msg-buf = <0xff3f0c80>;
  };
  blp_cips_pspmc_0_psv_ipi_4_1: child@1 {
   xlnx,ipi-bitmask = <8>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0ce0>;
   xlnx,ipi-id = <3>;
   xlnx,ipi-buf-index = <0x3>;
   xlnx,ipi-req-msg-buf = <0xff3f0cc0>;
  };
  blp_cips_pspmc_0_psv_ipi_4_2: child@2 {
   xlnx,ipi-bitmask = <16>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0d20>;
   xlnx,ipi-id = <4>;
   xlnx,ipi-buf-index = <0x4>;
   xlnx,ipi-req-msg-buf = <0xff3f0d00>;
  };
  blp_cips_pspmc_0_psv_ipi_4_3: child@3 {
   xlnx,ipi-bitmask = <32>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0d60>;
   xlnx,ipi-id = <5>;
   xlnx,ipi-buf-index = <0x5>;
   xlnx,ipi-req-msg-buf = <0xff3f0d40>;
  };
  blp_cips_pspmc_0_psv_ipi_4_4: child@4 {
   xlnx,ipi-bitmask = <64>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0da0>;
   xlnx,ipi-id = <6>;
   xlnx,ipi-buf-index = <0x6>;
   xlnx,ipi-req-msg-buf = <0xff3f0d80>;
  };
  blp_cips_pspmc_0_psv_ipi_4_5: child@5 {
   xlnx,ipi-bitmask = <128>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0de0>;
   xlnx,ipi-id = <7>;
   xlnx,ipi-buf-index = <0x7>;
   xlnx,ipi-req-msg-buf = <0xff3f0dc0>;
  };
  blp_cips_pspmc_0_psv_ipi_4_6: child@6 {
   xlnx,ipi-bitmask = <512>;
   xlnx,ipi-id = <9>;
   xlnx,ipi-buf-index = <0xffff>;
  };
  blp_cips_pspmc_0_psv_ipi_4_7: child@7 {
   xlnx,ipi-bitmask = <2>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0c60>;
   xlnx,ipi-id = <1>;
   xlnx,ipi-buf-index = <0x1>;
   xlnx,ipi-req-msg-buf = <0xff3f0c40>;
  };
  blp_cips_pspmc_0_psv_ipi_4_8: child@8 {
   xlnx,ipi-bitmask = <256>;
   xlnx,ipi-id = <8>;
   xlnx,ipi-buf-index = <0xffff>;
  };
  blp_cips_pspmc_0_psv_ipi_4_9: child@9 {
   xlnx,ipi-bitmask = <1>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0c20>;
   xlnx,ipi-id = <0>;
   xlnx,ipi-buf-index = <0x0>;
   xlnx,ipi-req-msg-buf = <0xff3f0c00>;
  };
 };
 &ipi5 {
  xlnx,rable = <0>;
  xlnx,cpu-name = "R5_1";
  xlnx,buffer-base = <0xff3f0e00>;
  status = "okay";
  xlnx,buffer-index = <0x7>;
  xlnx,ip-name = "psv_ipi";
  xlnx,ipi-target-count = <10>;
  xlnx,int-id = <67>;
  xlnx,bit-position = <7>;
  xlnx,name = "blp_cips_pspmc_0_psv_ipi_5";
  blp_cips_pspmc_0_psv_ipi_5_0: child@0 {
   xlnx,ipi-bitmask = <4>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0ea0>;
   xlnx,ipi-id = <2>;
   xlnx,ipi-buf-index = <0x2>;
   xlnx,ipi-req-msg-buf = <0xff3f0e80>;
  };
  blp_cips_pspmc_0_psv_ipi_5_1: child@1 {
   xlnx,ipi-bitmask = <8>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0ee0>;
   xlnx,ipi-id = <3>;
   xlnx,ipi-buf-index = <0x3>;
   xlnx,ipi-req-msg-buf = <0xff3f0ec0>;
  };
  blp_cips_pspmc_0_psv_ipi_5_2: child@2 {
   xlnx,ipi-bitmask = <16>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0f20>;
   xlnx,ipi-id = <4>;
   xlnx,ipi-buf-index = <0x4>;
   xlnx,ipi-req-msg-buf = <0xff3f0f00>;
  };
  blp_cips_pspmc_0_psv_ipi_5_3: child@3 {
   xlnx,ipi-bitmask = <32>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0f60>;
   xlnx,ipi-id = <5>;
   xlnx,ipi-buf-index = <0x5>;
   xlnx,ipi-req-msg-buf = <0xff3f0f40>;
  };
  blp_cips_pspmc_0_psv_ipi_5_4: child@4 {
   xlnx,ipi-bitmask = <64>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0fa0>;
   xlnx,ipi-id = <6>;
   xlnx,ipi-buf-index = <0x6>;
   xlnx,ipi-req-msg-buf = <0xff3f0f80>;
  };
  blp_cips_pspmc_0_psv_ipi_5_5: child@5 {
   xlnx,ipi-bitmask = <128>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0fe0>;
   xlnx,ipi-id = <7>;
   xlnx,ipi-buf-index = <0x7>;
   xlnx,ipi-req-msg-buf = <0xff3f0fc0>;
  };
  blp_cips_pspmc_0_psv_ipi_5_6: child@6 {
   xlnx,ipi-bitmask = <512>;
   xlnx,ipi-id = <9>;
   xlnx,ipi-buf-index = <0xffff>;
  };
  blp_cips_pspmc_0_psv_ipi_5_7: child@7 {
   xlnx,ipi-bitmask = <2>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0e60>;
   xlnx,ipi-id = <1>;
   xlnx,ipi-buf-index = <0x1>;
   xlnx,ipi-req-msg-buf = <0xff3f0e40>;
  };
  blp_cips_pspmc_0_psv_ipi_5_8: child@8 {
   xlnx,ipi-bitmask = <256>;
   xlnx,ipi-id = <8>;
   xlnx,ipi-buf-index = <0xffff>;
  };
  blp_cips_pspmc_0_psv_ipi_5_9: child@9 {
   xlnx,ipi-bitmask = <1>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0e20>;
   xlnx,ipi-id = <0>;
   xlnx,ipi-buf-index = <0x0>;
   xlnx,ipi-req-msg-buf = <0xff3f0e00>;
  };
 };
 &ipi6 {
  xlnx,rable = <0>;
  xlnx,cpu-name = "R5_1";
  xlnx,buffer-base = "NIL";
  status = "okay";
  xlnx,buffer-index = "NIL";
  xlnx,ip-name = "psv_ipi";
  xlnx,ipi-target-count = <10>;
  xlnx,int-id = <68>;
  xlnx,bit-position = <9>;
  xlnx,name = "blp_cips_pspmc_0_psv_ipi_6";
  blp_cips_pspmc_0_psv_ipi_6_0: child@0 {
   xlnx,ipi-bitmask = <4>;
   xlnx,ipi-id = <2>;
   xlnx,ipi-buf-index = <0x2>;
  };
  blp_cips_pspmc_0_psv_ipi_6_1: child@1 {
   xlnx,ipi-bitmask = <8>;
   xlnx,ipi-id = <3>;
   xlnx,ipi-buf-index = <0x3>;
  };
  blp_cips_pspmc_0_psv_ipi_6_2: child@2 {
   xlnx,ipi-bitmask = <16>;
   xlnx,ipi-id = <4>;
   xlnx,ipi-buf-index = <0x4>;
  };
  blp_cips_pspmc_0_psv_ipi_6_3: child@3 {
   xlnx,ipi-bitmask = <32>;
   xlnx,ipi-id = <5>;
   xlnx,ipi-buf-index = <0x5>;
  };
  blp_cips_pspmc_0_psv_ipi_6_4: child@4 {
   xlnx,ipi-bitmask = <64>;
   xlnx,ipi-id = <6>;
   xlnx,ipi-buf-index = <0x6>;
  };
  blp_cips_pspmc_0_psv_ipi_6_5: child@5 {
   xlnx,ipi-bitmask = <128>;
   xlnx,ipi-id = <7>;
   xlnx,ipi-buf-index = <0x7>;
  };
  blp_cips_pspmc_0_psv_ipi_6_6: child@6 {
   xlnx,ipi-bitmask = <512>;
   xlnx,ipi-id = <9>;
   xlnx,ipi-buf-index = <0xffff>;
  };
  blp_cips_pspmc_0_psv_ipi_6_7: child@7 {
   xlnx,ipi-bitmask = <2>;
   xlnx,ipi-id = <1>;
   xlnx,ipi-buf-index = <0x1>;
  };
  blp_cips_pspmc_0_psv_ipi_6_8: child@8 {
   xlnx,ipi-bitmask = <256>;
   xlnx,ipi-id = <8>;
   xlnx,ipi-buf-index = <0xffff>;
  };
  blp_cips_pspmc_0_psv_ipi_6_9: child@9 {
   xlnx,ipi-bitmask = <1>;
   xlnx,ipi-id = <0>;
   xlnx,ipi-buf-index = <0x0>;
  };
 };
 &ipi_pmc {
  xlnx,rable = <0>;
  xlnx,cpu-name = "PMC";
  xlnx,buffer-base = <0xff3f0200>;
  status = "okay";
  xlnx,buffer-index = <0x1>;
  xlnx,ip-name = "psv_ipi";
  xlnx,ipi-target-count = <10>;
  xlnx,int-id = <59>;
  xlnx,bit-position = <1>;
  xlnx,name = "blp_cips_pspmc_0_psv_ipi_pmc";
  blp_cips_pspmc_0_psv_ipi_pmc_0: child@0 {
   xlnx,ipi-bitmask = <4>;
   xlnx,ipi-rsp-msg-buf = <0xff3f02a0>;
   xlnx,ipi-id = <2>;
   xlnx,ipi-buf-index = <0x2>;
   xlnx,ipi-req-msg-buf = <0xff3f0280>;
  };
  blp_cips_pspmc_0_psv_ipi_pmc_1: child@1 {
   xlnx,ipi-bitmask = <8>;
   xlnx,ipi-rsp-msg-buf = <0xff3f02e0>;
   xlnx,ipi-id = <3>;
   xlnx,ipi-buf-index = <0x3>;
   xlnx,ipi-req-msg-buf = <0xff3f02c0>;
  };
  blp_cips_pspmc_0_psv_ipi_pmc_2: child@2 {
   xlnx,ipi-bitmask = <16>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0320>;
   xlnx,ipi-id = <4>;
   xlnx,ipi-buf-index = <0x4>;
   xlnx,ipi-req-msg-buf = <0xff3f0300>;
  };
  blp_cips_pspmc_0_psv_ipi_pmc_3: child@3 {
   xlnx,ipi-bitmask = <32>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0360>;
   xlnx,ipi-id = <5>;
   xlnx,ipi-buf-index = <0x5>;
   xlnx,ipi-req-msg-buf = <0xff3f0340>;
  };
  blp_cips_pspmc_0_psv_ipi_pmc_4: child@4 {
   xlnx,ipi-bitmask = <64>;
   xlnx,ipi-rsp-msg-buf = <0xff3f03a0>;
   xlnx,ipi-id = <6>;
   xlnx,ipi-buf-index = <0x6>;
   xlnx,ipi-req-msg-buf = <0xff3f0380>;
  };
  blp_cips_pspmc_0_psv_ipi_pmc_5: child@5 {
   xlnx,ipi-bitmask = <128>;
   xlnx,ipi-rsp-msg-buf = <0xff3f03e0>;
   xlnx,ipi-id = <7>;
   xlnx,ipi-buf-index = <0x7>;
   xlnx,ipi-req-msg-buf = <0xff3f03c0>;
  };
  blp_cips_pspmc_0_psv_ipi_pmc_6: child@6 {
   xlnx,ipi-bitmask = <512>;
   xlnx,ipi-id = <9>;
   xlnx,ipi-buf-index = <0xffff>;
  };
  blp_cips_pspmc_0_psv_ipi_pmc_7: child@7 {
   xlnx,ipi-bitmask = <2>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0260>;
   xlnx,ipi-id = <1>;
   xlnx,ipi-buf-index = <0x1>;
   xlnx,ipi-req-msg-buf = <0xff3f0240>;
  };
  blp_cips_pspmc_0_psv_ipi_pmc_8: child@8 {
   xlnx,ipi-bitmask = <256>;
   xlnx,ipi-id = <8>;
   xlnx,ipi-buf-index = <0xffff>;
  };
  blp_cips_pspmc_0_psv_ipi_pmc_9: child@9 {
   xlnx,ipi-bitmask = <1>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0220>;
   xlnx,ipi-id = <0>;
   xlnx,ipi-buf-index = <0x0>;
   xlnx,ipi-req-msg-buf = <0xff3f0200>;
  };
 };
 &ipi_pmc_nobuf {
  xlnx,rable = <0>;
  xlnx,cpu-name = "PMC";
  xlnx,buffer-base = "NIL";
  status = "okay";
  xlnx,buffer-index = "NIL";
  xlnx,ip-name = "psv_ipi";
  xlnx,ipi-target-count = <10>;
  xlnx,int-id = <60>;
  xlnx,bit-position = <8>;
  xlnx,name = "blp_cips_pspmc_0_psv_ipi_pmc_nobuf";
  blp_cips_pspmc_0_psv_ipi_pmc_nobuf_0: child@0 {
   xlnx,ipi-bitmask = <4>;
   xlnx,ipi-id = <2>;
   xlnx,ipi-buf-index = <0x2>;
  };
  blp_cips_pspmc_0_psv_ipi_pmc_nobuf_1: child@1 {
   xlnx,ipi-bitmask = <8>;
   xlnx,ipi-id = <3>;
   xlnx,ipi-buf-index = <0x3>;
  };
  blp_cips_pspmc_0_psv_ipi_pmc_nobuf_2: child@2 {
   xlnx,ipi-bitmask = <16>;
   xlnx,ipi-id = <4>;
   xlnx,ipi-buf-index = <0x4>;
  };
  blp_cips_pspmc_0_psv_ipi_pmc_nobuf_3: child@3 {
   xlnx,ipi-bitmask = <32>;
   xlnx,ipi-id = <5>;
   xlnx,ipi-buf-index = <0x5>;
  };
  blp_cips_pspmc_0_psv_ipi_pmc_nobuf_4: child@4 {
   xlnx,ipi-bitmask = <64>;
   xlnx,ipi-id = <6>;
   xlnx,ipi-buf-index = <0x6>;
  };
  blp_cips_pspmc_0_psv_ipi_pmc_nobuf_5: child@5 {
   xlnx,ipi-bitmask = <128>;
   xlnx,ipi-id = <7>;
   xlnx,ipi-buf-index = <0x7>;
  };
  blp_cips_pspmc_0_psv_ipi_pmc_nobuf_6: child@6 {
   xlnx,ipi-bitmask = <512>;
   xlnx,ipi-id = <9>;
   xlnx,ipi-buf-index = <0xffff>;
  };
  blp_cips_pspmc_0_psv_ipi_pmc_nobuf_7: child@7 {
   xlnx,ipi-bitmask = <2>;
   xlnx,ipi-id = <1>;
   xlnx,ipi-buf-index = <0x1>;
  };
  blp_cips_pspmc_0_psv_ipi_pmc_nobuf_8: child@8 {
   xlnx,ipi-bitmask = <256>;
   xlnx,ipi-id = <8>;
   xlnx,ipi-buf-index = <0xffff>;
  };
  blp_cips_pspmc_0_psv_ipi_pmc_nobuf_9: child@9 {
   xlnx,ipi-bitmask = <1>;
   xlnx,ipi-id = <0>;
   xlnx,ipi-buf-index = <0x0>;
  };
 };
 &ipi_psm {
  xlnx,rable = <0>;
  xlnx,cpu-name = "PSM";
  xlnx,buffer-base = <0xff3f0000>;
  status = "okay";
  xlnx,buffer-index = <0x0>;
  xlnx,ip-name = "psv_ipi";
  xlnx,ipi-target-count = <10>;
  xlnx,int-id = <61>;
  xlnx,bit-position = <0>;
  xlnx,name = "blp_cips_pspmc_0_psv_ipi_psm";
  blp_cips_pspmc_0_psv_ipi_psm_0: child@0 {
   xlnx,ipi-bitmask = <4>;
   xlnx,ipi-rsp-msg-buf = <0xff3f00a0>;
   xlnx,ipi-id = <2>;
   xlnx,ipi-buf-index = <0x2>;
   xlnx,ipi-req-msg-buf = <0xff3f0080>;
  };
  blp_cips_pspmc_0_psv_ipi_psm_1: child@1 {
   xlnx,ipi-bitmask = <8>;
   xlnx,ipi-rsp-msg-buf = <0xff3f00e0>;
   xlnx,ipi-id = <3>;
   xlnx,ipi-buf-index = <0x3>;
   xlnx,ipi-req-msg-buf = <0xff3f00c0>;
  };
  blp_cips_pspmc_0_psv_ipi_psm_2: child@2 {
   xlnx,ipi-bitmask = <16>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0120>;
   xlnx,ipi-id = <4>;
   xlnx,ipi-buf-index = <0x4>;
   xlnx,ipi-req-msg-buf = <0xff3f0100>;
  };
  blp_cips_pspmc_0_psv_ipi_psm_3: child@3 {
   xlnx,ipi-bitmask = <32>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0160>;
   xlnx,ipi-id = <5>;
   xlnx,ipi-buf-index = <0x5>;
   xlnx,ipi-req-msg-buf = <0xff3f0140>;
  };
  blp_cips_pspmc_0_psv_ipi_psm_4: child@4 {
   xlnx,ipi-bitmask = <64>;
   xlnx,ipi-rsp-msg-buf = <0xff3f01a0>;
   xlnx,ipi-id = <6>;
   xlnx,ipi-buf-index = <0x6>;
   xlnx,ipi-req-msg-buf = <0xff3f0180>;
  };
  blp_cips_pspmc_0_psv_ipi_psm_5: child@5 {
   xlnx,ipi-bitmask = <128>;
   xlnx,ipi-rsp-msg-buf = <0xff3f01e0>;
   xlnx,ipi-id = <7>;
   xlnx,ipi-buf-index = <0x7>;
   xlnx,ipi-req-msg-buf = <0xff3f01c0>;
  };
  blp_cips_pspmc_0_psv_ipi_psm_6: child@6 {
   xlnx,ipi-bitmask = <512>;
   xlnx,ipi-id = <9>;
   xlnx,ipi-buf-index = <0xffff>;
  };
  blp_cips_pspmc_0_psv_ipi_psm_7: child@7 {
   xlnx,ipi-bitmask = <2>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0060>;
   xlnx,ipi-id = <1>;
   xlnx,ipi-buf-index = <0x1>;
   xlnx,ipi-req-msg-buf = <0xff3f0040>;
  };
  blp_cips_pspmc_0_psv_ipi_psm_8: child@8 {
   xlnx,ipi-bitmask = <256>;
   xlnx,ipi-id = <8>;
   xlnx,ipi-buf-index = <0xffff>;
  };
  blp_cips_pspmc_0_psv_ipi_psm_9: child@9 {
   xlnx,ipi-bitmask = <1>;
   xlnx,ipi-rsp-msg-buf = <0xff3f0020>;
   xlnx,ipi-id = <0>;
   xlnx,ipi-buf-index = <0x0>;
   xlnx,ipi-req-msg-buf = <0xff3f0000>;
  };
 };
 &lpd_xppu {
  xlnx,rable = <0>;
  status = "okay";
  xlnx,ip-name = "psv_lpd_xppu";
  xlnx,name = "blp_cips_pspmc_0_psv_lpd_xppu_0";
 };
 &ocm_xmpu {
  xlnx,rable = <0>;
  status = "okay";
  xlnx,ip-name = "psv_ocm_xmpu";
  xlnx,name = "blp_cips_pspmc_0_psv_ocm_xmpu_0";
 };
 &dma0 {
  xlnx,rable = <0>;
  status = "okay";
  xlnx,ip-name = "psv_pmc_dma";
  xlnx,name = "blp_cips_pspmc_0_psv_pmc_dma_0";
 };
 &dma1 {
  xlnx,rable = <0>;
  status = "okay";
  xlnx,ip-name = "psv_pmc_dma";
  xlnx,name = "blp_cips_pspmc_0_psv_pmc_dma_1";
 };
 &gpio1 {
  xlnx,rable = <0>;
  status = "okay";
  xlnx,ip-name = "psv_pmc_gpio";
  xlnx,name = "blp_cips_pspmc_0_psv_pmc_gpio_0";
 };
 &i2c2 {
  xlnx,rable = <0>;
  status = "okay";
  xlnx,clock-freq = <99999908>;
  xlnx,i2c-clk-freq-hz = <99999908>;
  xlnx,ip-name = "psv_pmc_i2c";
  xlnx,name = "blp_cips_pspmc_0_psv_pmc_i2c_0";
 };
 &iomodule0 {
  xlnx,gpo4-size = <32>;
  xlnx,tmr = <0>;
  xlnx,pit1-readable = <1>;
  xlnx,mask = <0xfffff000>;
  xlnx,pit-size = < 32 32 32 32 >;
  xlnx,pit2-prescaler = <0>;
  xlnx,gpi3-interrupt = <0>;
  xlnx,intc-level-edge = <0x7fff>;
  xlnx,rable = <0>;
  xlnx,intc-positive = <0xffff>;
  xlnx,ip-name = "iomodule";
  xlnx,gpo1-size = <3>;
  xlnx,max-intr-size = <32>;
  xlnx,pit3-size = <32>;
  xlnx,fit3-interrupt = <0>;
  xlnx,fit1-no-clocks = <6216>;
  xlnx,gpi2-size = <32>;
  xlnx,pit2-readable = <1>;
  xlnx,intc-irq-connection = <0>;
  xlnx,uart-tx-interrupt = <1>;
  xlnx,use-config-reset = <0>;
  xlnx,pit2-interrupt = <1>;
  xlnx,intc-base-vectors = <0xf0240000>;
  xlnx,gpo4-init = <0x0>;
  xlnx,pit3-readable = <1>;
  xlnx,pit3-prescaler = <9>;
  xlnx,gpi4-interrupt = <0>;
  xlnx,gpo1-init = <0x0>;
  xlnx,use-io-bus = <0>;
  xlnx,use-gpo1 = <1>;
  xlnx,uart-baudrate = <115200>;
  xlnx,fit4-interrupt = <0>;
  xlnx,gpo3-size = <32>;
  xlnx,use-gpo2 = <0>;
  xlnx,uart-data-bits = <8>;
  xlnx,pit-prescaler = < 9 0 9 0 >;
  xlnx,gpio1-board-interface = "Custom";
  xlnx,use-gpo3 = <0>;
  xlnx,fit2-no-clocks = <6216>;
  xlnx,options = <1>;
  xlnx,gpio2-board-interface = "Custom";
  xlnx,use-gpo4 = <0>;
  xlnx,gpi4-size = <32>;
  xlnx,gpio3-board-interface = "Custom";
  xlnx,uart-rx-interrupt = <1>;
  xlnx,uart-error-interrupt = <1>;
  xlnx,gpio4-board-interface = "Custom";
  xlnx,pit4-readable = <1>;
  status = "okay";
  xlnx,intc-use-irq-out = <0>;
  xlnx,clock-freq = <100000000>;
  xlnx,gpo-init = < 0 0 0 0 >;
  xlnx,use-board-flow;
  xlnx,pit2-size = <32>;
  xlnx,intc-intr-size = <16>;
  xlnx,intc-use-ext-intr = <1>;
  xlnx,name = "blp_cips_pspmc_0_psv_pmc_iomodule_0";
  xlnx,gpi1-size = <32>;
  xlnx,edk-special = "INTR_CTRL";
  xlnx,pit3-interrupt = <1>;
  xlnx,intc-has-fast = <0>;
  xlnx,pit-used = < 1 1 1 1 >;
  xlnx,use-gpi1 = <0>;
  xlnx,gpi1-interrupt = <0>;
  xlnx,use-gpi2 = <0>;
  xlnx,use-gpi3 = <0>;
  xlnx,use-gpi4 = <0>;
  xlnx,fit1-interrupt = <0>;
  xlnx,pit4-prescaler = <0>;
  xlnx,gpo3-init = <0x0>;
  xlnx,intc-addr-width = <32>;
  xlnx,edk-iptype = "PERIPHERAL";
  xlnx,fit3-no-clocks = <6216>;
  xlnx,use-uart-rx = <1>;
  xlnx,instance = "iomodule_0";
  xlnx,pit-mask = <0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF 0xFFFFFFFF>;
  xlnx,uart-prog-baudrate = <1>;
  xlnx,use-pit1 = <1>;
  xlnx,gpo2-size = <32>;
  xlnx,use-pit2 = <1>;
  xlnx,pit4-size = <32>;
  xlnx,pit-readable = < 1 1 1 1 >;
  xlnx,use-pit3 = <1>;
  xlnx,use-pit4 = <1>;
  xlnx,pit4-interrupt = <1>;
  xlnx,gpi3-size = <32>;
  xlnx,intc-async-intr = <0xffff>;
  xlnx,avoid-primitives = <0>;
  xlnx,gpi2-interrupt = <0>;
  xlnx,pit1-prescaler = <9>;
  xlnx,use-tmr-disable = <0>;
  xlnx,use-fit1 = <0>;
  xlnx,pit1-size = <32>;
  xlnx,intc-num-sync-ff = <2>;
  xlnx,uart-board-interface = "rs232_uart";
  xlnx,use-fit2 = <0>;
  xlnx,fit2-interrupt = <0>;
  xlnx,use-fit3 = <0>;
  xlnx,use-fit4 = <0>;
  xlnx,uart-use-parity = <0>;
  xlnx,lmb-dwidth = <32>;
  xlnx,fit4-no-clocks = <6216>;
  xlnx,uart-odd-parity = <0>;
  xlnx,freq = <100000000>;
  xlnx,use-uart-tx = <1>;
  xlnx,pit1-interrupt = <1>;
  xlnx,gpo2-init = <0x0>;
  xlnx,io-mask = <0xfffe0000>;
  xlnx,lmb-awidth = <32>;
 };
 &ospi {
  is-stacked = <0>;
  xlnx,rable = <0>;
  xlnx,is-cache-coherent = <0>;
  status = "okay";
  xlnx,clock-freq = <199999817>;
  xlnx,ip-name = "psv_pmc_ospi";
  xlnx,ospi-clk-freq-hz = <199999817>;
  is-dual = <0>;
  xlnx,ospi-mode = <0>;
  xlnx,name = "blp_cips_pspmc_0_psv_pmc_ospi_0";
 };
 &rtc {
  xlnx,rable = <0>;
  status = "okay";
  xlnx,ip-name = "psv_pmc_rtc";
  xlnx,name = "blp_cips_pspmc_0_psv_pmc_rtc_0";
 };
 &sysmon0 {
  xlnx,sat-63-desc = "PS , FPD , satellite";
  xlnx,sat-1-desc = "PMC , system , ADC";
  xlnx,sat-9-x = <2786>;
  xlnx,sat-9-y = <10501>;
  xlnx,meas-0-root-id = <1>;
  xlnx,meas-7-slr-number = <0>;
  xlnx,rable = <0>;
  xlnx,meas-10-root-id = <0>;
  xlnx,ip-name = "psv_pmc_sysmon";
  xlnx,meas-1-root-id = <5>;
  #size-cells = <2>;
  xlnx,meas-2-root-id = <8>;
  xlnx,meas-2-slr-number = <0>;
  xlnx,meas-3-root-id = <10>;
  xlnx,sat-9-desc = "ME , satellite";
  xlnx,meas-4-root-id = <7>;
  #address-cells = <2>;
  xlnx,meas-5-root-id = <2>;
  xlnx,sat-10-x = <793>;
  xlnx,sat-64-x = <35>;
  xlnx,sat-2-x = <35>;
  xlnx,meas-6-root-id = <3>;
  xlnx,sat-10-y = <10501>;
  xlnx,sat-64-y = <2868>;
  xlnx,sat-2-y = <2868>;
  xlnx,sat-13-desc = "Clocking , column , satellite";
  xlnx,meas-7-root-id = <4>;
  xlnx,meas-8-root-id = <6>;
  xlnx,sat-6-desc = "VNOC , satellite";
  xlnx,meas-9-root-id = <9>;
  xlnx,sat-6-x = <6711>;
  xlnx,sat-6-y = <6649>;
  xlnx,sat-10-desc = "ME , satellite";
  xlnx,sat-3-desc = "XPIO , satellite";
  xlnx,meas-5-slr-number = <0>;
  xlnx,meas-10-aux-io-n = "LPD_MIO25_502";
  xlnx,meas-0-slr-number = <0>;
  xlnx,meas-10-aux-io-p = "LPD_MIO24_502";
  xlnx,sat-11-x = <2574>;
  xlnx,sat-3-x = <4458>;
  xlnx,sat-11-y = <9212>;
  xlnx,sat-3-y = <1535>;
  status = "okay";
  xlnx,meas-8-slr-number = <0>;
  xlnx,sat-8-desc = "ME , satellite";
  xlnx,sat-7-x = <6772>;
  xlnx,name = "blp_cips_pspmc_0_psv_pmc_sysmon_0";
  xlnx,sat-7-y = <10501>;
  xlnx,meas-3-slr-number = <0>;
  xlnx,sat-12-desc = "Clocking , column , satellite";
  xlnx,sat-5-desc = "VNOC , satellite";
  xlnx,sat-64-desc = "PS , LPD , satellite";
  xlnx,sat-2-desc = "PMC , user , ADC";
  xlnx,meas-6-slr-number = <0>;
  xlnx,sat-12-x = <2574>;
  xlnx,sat-4-x = <7500>;
  xlnx,sat-12-y = <7620>;
  xlnx,sat-4-y = <1535>;
  xlnx,meas-10-slr-number = <0>;
  xlnx,meas-1-slr-number = <0>;
  xlnx,sat-8-x = <4779>;
  xlnx,sat-8-y = <10501>;
  xlnx,meas-0 = "VCCAUX";
  xlnx,meas-10 = "VAUX_CH0";
  xlnx,meas-1 = "VCC_SOC";
  xlnx,meas-2 = "VCCO_302";
  xlnx,meas-3 = "VCCAUX_PMC";
  xlnx,meas-4 = "VCCO_500";
  xlnx,sat-7-desc = "ME , satellite";
  xlnx,meas-5 = "VCC_PMC";
  xlnx,meas-9-slr-number = <0>;
  xlnx,meas-6 = "VCC_PSFP";
  xlnx,meas-7 = "VCC_PSLP";
  xlnx,sat-63-x = <35>;
  xlnx,sat-1-x = <35>;
  xlnx,meas-4-slr-number = <0>;
  xlnx,meas-8 = "VP_VN";
  xlnx,sat-11-desc = "Clocking , column , satellite";
  xlnx,numchannels = /bits/8 <11>;
  xlnx,sat-63-y = <2868>;
  xlnx,sat-1-y = <2868>;
  xlnx,meas-9 = "VCCO_703";
  xlnx,sat-4-desc = "XPIO , satellite";
  xlnx,sat-13-x = <2574>;
  xlnx,sat-5-x = <6711>;
  xlnx,sat-13-y = <6037>;
  xlnx,sat-5-y = <3590>;
  supply@1 {
   reg = <1>;
   xlnx,name = "vccaux";
  };
  supply@5 {
   reg = <5>;
   xlnx,name = "vcc_soc";
  };
  supply@8 {
   reg = <8>;
   xlnx,name = "vcco_302";
  };
  supply@10 {
   reg = <10>;
   xlnx,name = "vccaux_pmc";
  };
  supply@7 {
   reg = <7>;
   xlnx,name = "vcco_500";
  };
  supply@2 {
   reg = <2>;
   xlnx,name = "vcc_pmc";
  };
  supply@3 {
   reg = <3>;
   xlnx,name = "vcc_psfp";
  };
  supply@4 {
   reg = <4>;
   xlnx,name = "vcc_pslp";
  };
  supply@6 {
   reg = <6>;
   xlnx,name = "vp_vn";
  };
  supply@9 {
   reg = <9>;
   xlnx,name = "vcco_703";
  };
  supply@0 {
   reg = <0>;
   xlnx,name = "vaux_ch0";
  };
 };
 &pmc_xmpu {
  xlnx,rable = <0>;
  status = "okay";
  xlnx,ip-name = "psv_pmc_xmpu";
  xlnx,name = "blp_cips_pspmc_0_psv_pmc_xmpu_0";
 };
 &pmc_xppu {
  xlnx,rable = <0>;
  status = "okay";
  xlnx,ip-name = "psv_pmc_xppu";
  xlnx,name = "blp_cips_pspmc_0_psv_pmc_xppu_0";
 };
 &pmc_xppu_npi {
  xlnx,rable = <0>;
  status = "okay";
  xlnx,ip-name = "psv_pmc_xppu_npi";
  xlnx,name = "blp_cips_pspmc_0_psv_pmc_xppu_npi_0";
 };
 &psv_r5_0_btcm_global {
  xlnx,rable = <0>;
  status = "okay";
  power-domains = <&versal_firmware 0x1831800c>;
  xlnx,ip-name = "psv_tcm_global";
  xlnx,is-hierarchy;
  xlnx,name = "blp_cips_pspmc_0_psv_r5_0_btcm_global";
 };
 &psv_r5_1_atcm_global {
  xlnx,rable = <0>;
  status = "okay";
  power-domains = <&versal_firmware 0x1831800d>;
  xlnx,ip-name = "psv_tcm_global";
  xlnx,name = "blp_cips_pspmc_0_psv_r5_1_atcm_global";
 };
 &psv_r5_1_btcm_global {
  xlnx,rable = <0>;
  status = "okay";
  power-domains = <&versal_firmware 0x1831800e>;
  xlnx,ip-name = "psv_tcm_global";
  xlnx,name = "blp_cips_pspmc_0_psv_r5_1_btcm_global";
 };
 &psv_r5_0_atcm_global {
  xlnx,rable = <0>;
  status = "okay";
  power-domains = <&versal_firmware 0x1831800b>;
  xlnx,ip-name = "psv_tcm_global";
  xlnx,is-hierarchy;
  xlnx,name = "blp_cips_pspmc_0_psv_r5_0_atcm_global";
 };
 &gic_a72 {
  xlnx,rable = <0>;
  status = "okay";
  xlnx,apu-gic-its-ctl = <0xf9020000>;
  xlnx,ip-name = "psv_acpu_gic";
  xlnx,name = "blp_cips_pspmc_0_psv_acpu_gic";
 };
 &gic_r5 {
  xlnx,rable = <0>;
  status = "okay";
  xlnx,ip-name = "psv_rcpu_gic";
  xlnx,name = "blp_cips_pspmc_0_psv_rcpu_gic";
 };
 &serial0 {
  xlnx,has-modem = <0>;
  xlnx,uart-clk-freq-hz = <99999908>;
  port-number = <0>;
  xlnx,rable = <0>;
  xlnx,ip-name = "psv_sbsauart";
  xlnx,uart-board-interface = "custom";
  xlnx,baudrate = <115200>;
  cts-override;
  u-boot,dm-pre-reloc;
  status = "okay";
  xlnx,clock-freq = <99999908>;
  xlnx,name = "blp_cips_pspmc_0_psv_sbsauart_0";
 };
 &serial1 {
  xlnx,has-modem = <0>;
  xlnx,uart-clk-freq-hz = <99999908>;
  port-number = <0>;
  xlnx,rable = <0>;
  xlnx,ip-name = "psv_sbsauart";
  xlnx,uart-board-interface = "custom";
  xlnx,baudrate = <115200>;
  cts-override;
  u-boot,dm-pre-reloc;
  status = "okay";
  xlnx,clock-freq = <99999908>;
  xlnx,name = "blp_cips_pspmc_0_psv_sbsauart_1";
 };
 &spi0 {
  xlnx,rable = <0>;
  status = "okay";
  xlnx,spi-board-interface = "custom";
  xlnx,has-ss0 = <1>;
  xlnx,ip-name = "psv_spi";
  xlnx,has-ss1 = <0>;
  num-cs = <1>;
  xlnx,spi-clk-freq-hz = <199999817>;
  xlnx,has-ss2 = <0>;
  xlnx,name = "blp_cips_pspmc_0_psv_spi_0";
 };
 &ttc0 {
  xlnx,ttc-clk2-clksrc = <0>;
  xlnx,rable = <0>;
  xlnx,ip-name = "psv_ttc";
  xlnx,ttc-clk1-clksrc = <0>;
  xlnx,ttc-clk0-freq-hz = <149999863>;
  xlnx,ttc-clk1-freq-hz = <149999863>;
  status = "okay";
  xlnx,ttc-clk2-freq-hz = <149999863>;
  xlnx,ttc-board-interface = "custom";
  xlnx,clock-freq = <149999863>;
  xlnx,name = "blp_cips_pspmc_0_psv_ttc_0";
  xlnx,ttc-clk0-clksrc = <0>;
 };
 &ttc1 {
  xlnx,ttc-clk2-clksrc = <0>;
  xlnx,rable = <0>;
  xlnx,ip-name = "psv_ttc";
  xlnx,ttc-clk1-clksrc = <0>;
  xlnx,ttc-clk0-freq-hz = <149999863>;
  xlnx,ttc-clk1-freq-hz = <149999863>;
  status = "okay";
  xlnx,ttc-clk2-freq-hz = <149999863>;
  xlnx,ttc-board-interface = "custom";
  xlnx,clock-freq = <149999863>;
  xlnx,name = "blp_cips_pspmc_0_psv_ttc_1";
  xlnx,ttc-clk0-clksrc = <0>;
 };
 &ttc2 {
  xlnx,ttc-clk2-clksrc = <0>;
  xlnx,rable = <0>;
  xlnx,ip-name = "psv_ttc";
  xlnx,ttc-clk1-clksrc = <0>;
  xlnx,ttc-clk0-freq-hz = <149999863>;
  xlnx,ttc-clk1-freq-hz = <149999863>;
  status = "okay";
  xlnx,ttc-clk2-freq-hz = <149999863>;
  xlnx,ttc-board-interface = "custom";
  xlnx,clock-freq = <149999863>;
  xlnx,name = "blp_cips_pspmc_0_psv_ttc_2";
  xlnx,ttc-clk0-clksrc = <0>;
 };
 &ttc3 {
  xlnx,ttc-clk2-clksrc = <0>;
  xlnx,rable = <0>;
  xlnx,ip-name = "psv_ttc";
  xlnx,ttc-clk1-clksrc = <0>;
  xlnx,ttc-clk0-freq-hz = <149999863>;
  xlnx,ttc-clk1-freq-hz = <149999863>;
  status = "okay";
  xlnx,ttc-clk2-freq-hz = <149999863>;
  xlnx,ttc-board-interface = "custom";
  xlnx,clock-freq = <149999863>;
  xlnx,name = "blp_cips_pspmc_0_psv_ttc_3";
  xlnx,ttc-clk0-clksrc = <0>;
 };
 &mc0 {
  ranges = <0x0 0x00000000 0x0 0x80000000>, <0x0 0x40000 0x0 0x7ffc0000>, <0x00000500 0x00000000 0x00000001 0x80000000>;
  status = "okay";
 };
 &ddrmc_xmpu_0 {
  status = "okay";
 };
 &gic_its {
  status = "okay";
 };
 &ref_clk {
  clock-frequency = <33333300>;
 };
 &cpu_opp_table {
  /delete-node/ opp01;
  /delete-node/ opp02;
  /delete-node/ opp03;
  /delete-node/ opp00;
  opp-1400000000 {
   opp-hz = /bits/ 64 <1400000000>;
   clock-latency-ns = <500000>;
   opp-microvolt = <1000000>;
  };
  opp-700000000 {
   opp-hz = /bits/ 64 <700000000>;
   clock-latency-ns = <500000>;
   opp-microvolt = <1000000>;
  };
  opp-466666666 {
   opp-hz = /bits/ 64 <466666666>;
   clock-latency-ns = <500000>;
   opp-microvolt = <1000000>;
  };
  opp-350000000 {
   opp-hz = /bits/ 64 <350000000>;
   clock-latency-ns = <500000>;
   opp-microvolt = <1000000>;
  };
 };
 &psv_cortexr5_0 {
  xlnx,rable = <0>;
  xlnx,is-cache-coherent = <0>;
  xlnx,pss-ref-clk-freq = <33333300>;
  xlnx,ip-name = "psv_cortexr5";
  access-val = <0xff>;
  bus-handle = <&amba>;
  xlnx,cpu-clk-freq-hz = <599999451>;
  cpu-frequency = <599999451>;
 };
 &psv_cortexr5_1 {
  xlnx,rable = <0>;
  xlnx,is-cache-coherent = <0>;
  xlnx,pss-ref-clk-freq = <33333300>;
  xlnx,ip-name = "psv_cortexr5";
  access-val = <0xff>;
  bus-handle = <&amba>;
  xlnx,cpu-clk-freq-hz = <599999451>;
  cpu-frequency = <599999451>;
 };
# 6 "/scratch/jenkins-sdt_artifactory_upload_2024.2-52/build_cfg/hw-description/emb-plus-ve2302-sdt_2024.2_1111_2/system-top.dts" 2
/ {
 board = "emb-plus-vpr-4616";
 device_id = "xcve2302";
 slrcount = <1>;
 family = "Versal";
 blp_axi_noc_mc_1x_ddr_memory: memory@00000000 {
  compatible = "xlnx,axi-noc-1.1";
  xlnx,ip-name = "axi_noc";
  device_type = "memory";
  reg = <0x0 0x00000000 0x0 0x80000000>, <0x00000500 0x00000000 0x00000001 0x80000000>;
  memory_type = "memory";
 };
 blp_cips_pspmc_0_psv_ocm_ram_0_memory: memory@FFFC0000 {
  compatible = "xlnx,psv-ocm-ram-0-1.0" , "mmio-sram";
  xlnx,ip-name = "psv_ocm_ram_0";
  device_type = "memory";
  memory_type = "memory";
  reg = <0x0 0xFFFC0000 0x0 0x40000>;
 };
 chosen {
  stdout-path = "serial0:230400n8";
 };
 aliases {
  serial4 = &blp_blp_logic_axi_uart_mgmt_rpu;
  serial0 = &serial0;
  serial5 = &blp_blp_logic_axi_uart_rpu;
  serial1 = &serial1;
  serial6 = &coresight;
  serial2 = &blp_blp_logic_axi_uart_apu0;
  serial3 = &blp_blp_logic_axi_uart_mgmt_apu0;
 };
 cpus_a72: cpus-a72@0 {
  compatible = "cpus,cluster";
  address-map = <0x0 0xf0000000 &amba 0x0 0xf0000000 0x0 0x10000000>,
         <0x0 0xf9000000 &amba_apu 0x0 0xf9000000 0x0 0x80000>,
         <0x0 0x00000000 &blp_axi_noc_mc_1x_ddr_memory 0x0 0x00000000 0x0 0x80000000>,
         <0x00000500 0x00000000 &blp_axi_noc_mc_1x_ddr_memory 0x00000500 0x00000000 0x00000001 0x80000000>,
         <0x0 0xf9020000 &gic_its 0x0 0xf9020000 0x0 0x20000>,
         <0x0 0xff330000 &ipi0 0x0 0xff330000 0x0 0x10000>,
         <0x0 0xff340000 &ipi1 0x0 0xff340000 0x0 0x10000>,
         <0x0 0xff350000 &ipi2 0x0 0xff350000 0x0 0x10000>,
         <0x0 0xFFFC0000 &blp_cips_pspmc_0_psv_ocm_ram_0_memory 0x0 0xFFFC0000 0x0 0x40000>,
         <0x0 0x80001000 &blp_blp_logic_axi_firewall_user 0x0 0x80001000 0x0 0x1000>,
         <0x0 0x80010000 &blp_blp_logic_gcq_m2r 0x0 0x80010000 0x0 0x1000>,
         <0x0 0x80011000 &blp_blp_logic_gcq_r2a 0x0 0x80011000 0x0 0x1000>,
         <0x0 0x80020000 &blp_blp_logic_base_clocking_pr_reset_gpio 0x0 0x80020000 0x0 0x1000>,
         <0x0 0x80021000 &blp_blp_logic_axi_uart_rpu 0x0 0x80021000 0x0 0x1000>,
         <0x0 0x80030000 &blp_blp_logic_ulp_clocking_shell_utils_ucc 0x0 0x80030000 0x0 0x10000>,
         <0x0 0x80042000 &blp_blp_logic_ulp_clocking_clkwiz_aclk_kernel_00 0x0 0x80042000 0x0 0x1000>,
         <0x0 0x80043000 &blp_blp_logic_ulp_clocking_clkwiz_aclk_kernel_01 0x0 0x80043000 0x0 0x1000>,
         <0x0 0x80044000 &blp_blp_logic_pfm_irq_ctlr 0x0 0x80044000 0x0 0x1000>,
         <0x0 0x80045000 &blp_blp_logic_uuid_register 0x0 0x80045000 0x0 0x1000>,
         <0x0 0xf0310000 &blp_cips_pspmc_0_psv_pmc_ppu1_mdm_0 0x0 0xf0310000 0x0 0x8000>,
         <0x0 0xf0800000 &coresight 0x0 0xf0800000 0x0 0x10000>,
         <0x0 0xf0980000 &blp_cips_pspmc_0_psv_coresight_lpd_atm 0x0 0xf0980000 0x0 0x10000>,
         <0x0 0xf0b70000 &blp_cips_pspmc_0_psv_coresight_fpd_stm 0x0 0xf0b70000 0x0 0x10000>,
         <0x0 0xf0b80000 &blp_cips_pspmc_0_psv_coresight_fpd_atm 0x0 0xf0b80000 0x0 0x10000>,
         <0x0 0xf0c20000 &blp_cips_pspmc_0_psv_coresight_apu_fun 0x0 0xf0c20000 0x0 0x10000>,
         <0x0 0xf0c30000 &blp_cips_pspmc_0_psv_coresight_apu_etf 0x0 0xf0c30000 0x0 0x10000>,
         <0x0 0xf0c60000 &blp_cips_pspmc_0_psv_coresight_apu_ela 0x0 0xf0c60000 0x0 0x10000>,
         <0x0 0xf0ca0000 &blp_cips_pspmc_0_psv_coresight_apu_cti 0x0 0xf0ca0000 0x0 0x10000>,
         <0x0 0xf0d00000 &blp_cips_pspmc_0_psv_coresight_a720_dbg 0x0 0xf0d00000 0x0 0x10000>,
         <0x0 0xf0d10000 &blp_cips_pspmc_0_psv_coresight_a720_cti 0x0 0xf0d10000 0x0 0x10000>,
         <0x0 0xf0d20000 &blp_cips_pspmc_0_psv_coresight_a720_pmu 0x0 0xf0d20000 0x0 0x10000>,
         <0x0 0xf0d30000 &blp_cips_pspmc_0_psv_coresight_a720_etm 0x0 0xf0d30000 0x0 0x10000>,
         <0x0 0xf0d40000 &blp_cips_pspmc_0_psv_coresight_a721_dbg 0x0 0xf0d40000 0x0 0x10000>,
         <0x0 0xf0d50000 &blp_cips_pspmc_0_psv_coresight_a721_cti 0x0 0xf0d50000 0x0 0x10000>,
         <0x0 0xf0d60000 &blp_cips_pspmc_0_psv_coresight_a721_pmu 0x0 0xf0d60000 0x0 0x10000>,
         <0x0 0xf0d70000 &blp_cips_pspmc_0_psv_coresight_a721_etm 0x0 0xf0d70000 0x0 0x10000>,
         <0x0 0xf0f00000 &blp_cips_pspmc_0_psv_coresight_cpm_rom 0x0 0xf0f00000 0x0 0x10000>,
         <0x0 0xf0f20000 &blp_cips_pspmc_0_psv_coresight_cpm_fun 0x0 0xf0f20000 0x0 0x10000>,
         <0x0 0xf0f40000 &blp_cips_pspmc_0_psv_coresight_cpm_ela2a 0x0 0xf0f40000 0x0 0x10000>,
         <0x0 0xf0f50000 &blp_cips_pspmc_0_psv_coresight_cpm_ela2b 0x0 0xf0f50000 0x0 0x10000>,
         <0x0 0xf0f60000 &blp_cips_pspmc_0_psv_coresight_cpm_ela2c 0x0 0xf0f60000 0x0 0x10000>,
         <0x0 0xf0f70000 &blp_cips_pspmc_0_psv_coresight_cpm_ela2d 0x0 0xf0f70000 0x0 0x10000>,
         <0x0 0xf0f80000 &blp_cips_pspmc_0_psv_coresight_cpm_atm 0x0 0xf0f80000 0x0 0x10000>,
         <0x0 0xf0fa0000 &blp_cips_pspmc_0_psv_coresight_cpm_cti2a 0x0 0xf0fa0000 0x0 0x10000>,
         <0x0 0xf0fd0000 &blp_cips_pspmc_0_psv_coresight_cpm_cti2d 0x0 0xf0fd0000 0x0 0x10000>,
         <0x0 0xf1000000 &i2c2 0x0 0xf1000000 0x0 0x10000>,
         <0x0 0xf1010000 &ospi 0x0 0xf1010000 0x0 0x10000>,
         <0x0 0xf1020000 &gpio1 0x0 0xf1020000 0x0 0x10000>,
         <0x0 0xf1110000 &blp_cips_pspmc_0_psv_pmc_global_0 0x0 0xf1110000 0x0 0x50000>,
         <0x0 0xf11c0000 &dma0 0x0 0xf11c0000 0x0 0x10000>,
         <0x0 0xf11d0000 &dma1 0x0 0xf11d0000 0x0 0x10000>,
         <0x0 0xf11e0000 &blp_cips_pspmc_0_psv_pmc_aes 0x0 0xf11e0000 0x0 0x10000>,
         <0x0 0xf11f0000 &blp_cips_pspmc_0_psv_pmc_bbram_ctrl 0x0 0xf11f0000 0x0 0x10000>,
         <0x0 0xf1200000 &blp_cips_pspmc_0_psv_pmc_rsa 0x0 0xf1200000 0x0 0x10000>,
         <0x0 0xf1210000 &blp_cips_pspmc_0_psv_pmc_sha 0x0 0xf1210000 0x0 0x10000>,
         <0x0 0xf1220000 &blp_cips_pspmc_0_psv_pmc_slave_boot 0x0 0xf1220000 0x0 0x10000>,
         <0x0 0xf1230000 &blp_cips_pspmc_0_psv_pmc_trng 0x0 0xf1230000 0x0 0x10000>,
         <0x0 0xf1240000 &blp_cips_pspmc_0_psv_pmc_efuse_ctrl 0x0 0xf1240000 0x0 0x10000>,
         <0x0 0xf1250000 &blp_cips_pspmc_0_psv_pmc_efuse_cache 0x0 0xf1250000 0x0 0x10000>,
         <0x0 0xf1260000 &blp_cips_pspmc_0_psv_crp_0 0x0 0xf1260000 0x0 0x10000>,
         <0x0 0xf1270000 &sysmon0 0x0 0xf1270000 0x0 0x30000>,
         <0x0 0xf12a0000 &rtc 0x0 0xf12a0000 0x0 0x10000>,
         <0x0 0xf12b0000 &blp_cips_pspmc_0_psv_pmc_cfu_apb_0 0x0 0xf12b0000 0x0 0x10000>,
         <0x0 0xf12d0000 &blp_cips_pspmc_0_psv_pmc_cfi_cframe_0 0x0 0xf12d0000 0x0 0x1000>,
         <0x0 0xf12f0000 &pmc_xmpu 0x0 0xf12f0000 0x0 0x10000>,
         <0x0 0xf1300000 &pmc_xppu_npi 0x0 0xf1300000 0x0 0x10000>,
         <0x0 0xf1310000 &pmc_xppu 0x0 0xf1310000 0x0 0x10000>,
         <0x0 0xf2100000 &blp_cips_pspmc_0_psv_pmc_slave_boot_stream 0x0 0xf2100000 0x0 0x10000>,
         <0x0 0xf6000000 &blp_cips_pspmc_0_psv_pmc_ram_npi 0x0 0xf6000000 0x0 0x2000000>,
         <0x0 0xf9000000 &gic_a72 0x0 0xf9000000 0x0 0x70000>,
         <0x0 0 &blp_cips_pspmc_0_psv_cpm 0x0 0 0x0 0xfd000000>,
         <0x0 0xfd000000 &cci 0x0 0xfd000000 0x0 0x100000>,
         <0x0 0xfd1a0000 &blp_cips_pspmc_0_psv_crf_0 0x0 0xfd1a0000 0x0 0x140000>,
         <0x0 0xfd360000 &blp_cips_pspmc_0_psv_fpd_afi_0 0x0 0xfd360000 0x0 0x10000>,
         <0x0 0xfd380000 &blp_cips_pspmc_0_psv_fpd_afi_2 0x0 0xfd380000 0x0 0x10000>,
         <0x0 0xfd390000 &fpd_xmpu 0x0 0xfd390000 0x0 0x10000>,
         <0x0 0xfd5c0000 &blp_cips_pspmc_0_psv_apu_0 0x0 0xfd5c0000 0x0 0x10000>,
         <0x0 0xfd5e0000 &blp_cips_pspmc_0_psv_fpd_cci_0 0x0 0xfd5e0000 0x0 0x10000>,
         <0x0 0xfd5f0000 &blp_cips_pspmc_0_psv_fpd_smmu_0 0x0 0xfd5f0000 0x0 0x10000>,
         <0x0 0xfd610000 &blp_cips_pspmc_0_psv_fpd_slcr_0 0x0 0xfd610000 0x0 0x10000>,
         <0x0 0xfd690000 &blp_cips_pspmc_0_psv_fpd_slcr_secure_0 0x0 0xfd690000 0x0 0x10000>,
         <0x0 0xfd700000 &blp_cips_pspmc_0_psv_fpd_gpv_0 0x0 0xfd700000 0x0 0x100000>,
         <0x0 0xfd800000 &smmu 0x0 0xfd800000 0x0 0x800000>,
         <0x0 0xff000000 &serial0 0x0 0xff000000 0x0 0x10000>,
         <0x0 0xff010000 &serial1 0x0 0xff010000 0x0 0x10000>,
         <0x0 0xff040000 &spi0 0x0 0xff040000 0x0 0x10000>,
         <0x0 0xff080000 &blp_cips_pspmc_0_psv_lpd_iou_slcr_0 0x0 0xff080000 0x0 0x20000>,
         <0x0 0xff0a0000 &blp_cips_pspmc_0_psv_lpd_iou_secure_slcr_0 0x0 0xff0a0000 0x0 0x10000>,
         <0x0 0xff0b0000 &gpio0 0x0 0xff0b0000 0x0 0x10000>,
         <0x0 0xff0e0000 &ttc0 0x0 0xff0e0000 0x0 0x10000>,
         <0x0 0xff0f0000 &ttc1 0x0 0xff0f0000 0x0 0x10000>,
         <0x0 0xff100000 &ttc2 0x0 0xff100000 0x0 0x10000>,
         <0x0 0xff110000 &ttc3 0x0 0xff110000 0x0 0x10000>,
         <0x0 0xff130000 &blp_cips_pspmc_0_psv_scntr_0 0x0 0xff130000 0x0 0x10000>,
         <0x0 0xff140000 &blp_cips_pspmc_0_psv_scntrs_0 0x0 0xff140000 0x0 0x10000>,
         <0x0 0xff410000 &blp_cips_pspmc_0_psv_lpd_slcr_0 0x0 0xff410000 0x0 0x100000>,
         <0x0 0xff510000 &blp_cips_pspmc_0_psv_lpd_slcr_secure_0 0x0 0xff510000 0x0 0x40000>,
         <0x0 0xff5e0000 &blp_cips_pspmc_0_psv_crl_0 0x0 0xff5e0000 0x0 0x300000>,
         <0x0 0xff8e0000 &blp_cips_pspmc_0_psv_xram_ctrl_1 0x0 0xff8e0000 0x0 0x10000>,
         <0x0 0xff8f0000 &blp_cips_pspmc_0_psv_xram_ctrl_2 0x0 0xff8f0000 0x0 0x10000>,
         <0x0 0xff900000 &blp_cips_pspmc_0_psv_xram_ctrl_3 0x0 0xff900000 0x0 0x10000>,
         <0x0 0xff910000 &blp_cips_pspmc_0_psv_xram_ctrl_4 0x0 0xff910000 0x0 0x10000>,
         <0x0 0xff930000 &blp_cips_pspmc_0_psv_xram_xmpu_bank_1 0x0 0xff930000 0x0 0x4000>,
         <0x0 0xff934000 &blp_cips_pspmc_0_psv_xram_xmpu_bank_2 0x0 0xff934000 0x0 0x4000>,
         <0x0 0xff938000 &blp_cips_pspmc_0_psv_xram_xmpu_bank_3 0x0 0xff938000 0x0 0x4000>,
         <0x0 0xff93c000 &blp_cips_pspmc_0_psv_xram_xmpu_bank_4 0x0 0xff93c000 0x0 0x4000>,
         <0x0 0xff940000 &blp_cips_pspmc_0_psv_xram_gpv 0x0 0xff940000 0x0 0x10000>,
         <0x0 0xff950000 &blp_cips_pspmc_0_psv_xram_global_ctrl 0x0 0xff950000 0x0 0x10000>,
         <0x0 0xff960000 &blp_cips_pspmc_0_psv_ocm_ctrl 0x0 0xff960000 0x0 0x10000>,
         <0x0 0xff970000 &blp_cips_pspmc_0_psv_xram_atm 0x0 0xff970000 0x0 0x10000>,
         <0x0 0xff980000 &ocm_xmpu 0x0 0xff980000 0x0 0x10000>,
         <0x0 0xff990000 &lpd_xppu 0x0 0xff990000 0x0 0x10000>,
         <0x0 0xff9a0000 &blp_cips_pspmc_0_psv_rpu_0 0x0 0xff9a0000 0x0 0x10000>,
         <0x0 0xff9b0000 &blp_cips_pspmc_0_psv_lpd_afi_0 0x0 0xff9b0000 0x0 0x10000>,
         <0x0 0xffa80000 &lpd_dma_chan0 0x0 0xffa80000 0x0 0x10000>,
         <0x0 0xffa90000 &lpd_dma_chan1 0x0 0xffa90000 0x0 0x10000>,
         <0x0 0xffaa0000 &lpd_dma_chan2 0x0 0xffaa0000 0x0 0x10000>,
         <0x0 0xffab0000 &lpd_dma_chan3 0x0 0xffab0000 0x0 0x10000>,
         <0x0 0xffac0000 &lpd_dma_chan4 0x0 0xffac0000 0x0 0x10000>,
         <0x0 0xffad0000 &lpd_dma_chan5 0x0 0xffad0000 0x0 0x10000>,
         <0x0 0xffae0000 &lpd_dma_chan6 0x0 0xffae0000 0x0 0x10000>,
         <0x0 0xffaf0000 &lpd_dma_chan7 0x0 0xffaf0000 0x0 0x10000>,
         <0x0 0xffc90000 &blp_cips_pspmc_0_psv_psm_global_reg 0x0 0xffc90000 0x0 0xf000>,
         <0x0 0xffe00000 &psv_r5_0_atcm_global 0x0 0xffe00000 0x0 0x40000>,
         <0x0 0xffe90000 &psv_r5_1_atcm_global 0x0 0xffe90000 0x0 0x10000>,
         <0x0 0xffeb0000 &psv_r5_1_btcm_global 0x0 0xffeb0000 0x0 0x10000>,
         <0x00000004 0x02010000 &blp_blp_logic_gcq_u2a_0 0x00000004 0x02010000 0x0 0x1000>,
         <0x00000004 0x02020000 &blp_blp_logic_axi_uart_apu0 0x00000004 0x02020000 0x0 0x1000>,
         <0x00000004 0x02030000 &blp_blp_logic_axi_intc_uart_apu 0x00000004 0x02030000 0x0 0x1000>,
         <0x00000004 0x02031000 &blp_blp_logic_axi_intc_gcq_apu 0x00000004 0x02031000 0x0 0x1000>,
         <0x00000202 0x02020000 &blp_blp_logic_ert_support_axi_intc_0_31 0x00000202 0x02020000 0x0 0x1000>;
  #ranges-address-cells = <0x2>;
  #ranges-size-cells = <0x2>;
 };
 cpus_r5_0: cpus-r5@0 {
  compatible = "cpus,cluster";
  address-map = <0xf0000000 &amba 0xf0000000 0x10000000>,
         <0xf9000000 &amba_rpu 0xf9000000 0x3000>,
         <0x40000 &blp_axi_noc_mc_1x_ddr_memory 0x40000 0x7ffc0000>,
         <0xff360000 &ipi3 0xff360000 0x10000>,
         <0xff370000 &ipi4 0xff370000 0x10000>,
         <0xFFFC0000 &blp_cips_pspmc_0_psv_ocm_ram_0_memory 0xFFFC0000 0x40000>,
         <0x80001000 &blp_blp_logic_axi_firewall_user 0x80001000 0x1000>,
         <0x80010000 &blp_blp_logic_gcq_m2r 0x80010000 0x1000>,
         <0x80011000 &blp_blp_logic_gcq_r2a 0x80011000 0x1000>,
         <0x80020000 &blp_blp_logic_base_clocking_pr_reset_gpio 0x80020000 0x1000>,
         <0x80021000 &blp_blp_logic_axi_uart_rpu 0x80021000 0x1000>,
         <0x80030000 &blp_blp_logic_ulp_clocking_shell_utils_ucc 0x80030000 0x10000>,
         <0x80042000 &blp_blp_logic_ulp_clocking_clkwiz_aclk_kernel_00 0x80042000 0x1000>,
         <0x80043000 &blp_blp_logic_ulp_clocking_clkwiz_aclk_kernel_01 0x80043000 0x1000>,
         <0x80044000 &blp_blp_logic_pfm_irq_ctlr 0x80044000 0x1000>,
         <0x80045000 &blp_blp_logic_uuid_register 0x80045000 0x1000>,
         <0xf0310000 &blp_cips_pspmc_0_psv_pmc_ppu1_mdm_0 0xf0310000 0x8000>,
         <0xf0800000 &coresight 0xf0800000 0x10000>,
         <0xf0980000 &blp_cips_pspmc_0_psv_coresight_lpd_atm 0xf0980000 0x10000>,
         <0xf0b70000 &blp_cips_pspmc_0_psv_coresight_fpd_stm 0xf0b70000 0x10000>,
         <0xf0b80000 &blp_cips_pspmc_0_psv_coresight_fpd_atm 0xf0b80000 0x10000>,
         <0xf0c20000 &blp_cips_pspmc_0_psv_coresight_apu_fun 0xf0c20000 0x10000>,
         <0xf0c30000 &blp_cips_pspmc_0_psv_coresight_apu_etf 0xf0c30000 0x10000>,
         <0xf0c60000 &blp_cips_pspmc_0_psv_coresight_apu_ela 0xf0c60000 0x10000>,
         <0xf0ca0000 &blp_cips_pspmc_0_psv_coresight_apu_cti 0xf0ca0000 0x10000>,
         <0xf0d00000 &blp_cips_pspmc_0_psv_coresight_a720_dbg 0xf0d00000 0x10000>,
         <0xf0d10000 &blp_cips_pspmc_0_psv_coresight_a720_cti 0xf0d10000 0x10000>,
         <0xf0d20000 &blp_cips_pspmc_0_psv_coresight_a720_pmu 0xf0d20000 0x10000>,
         <0xf0d30000 &blp_cips_pspmc_0_psv_coresight_a720_etm 0xf0d30000 0x10000>,
         <0xf0d40000 &blp_cips_pspmc_0_psv_coresight_a721_dbg 0xf0d40000 0x10000>,
         <0xf0d50000 &blp_cips_pspmc_0_psv_coresight_a721_cti 0xf0d50000 0x10000>,
         <0xf0d60000 &blp_cips_pspmc_0_psv_coresight_a721_pmu 0xf0d60000 0x10000>,
         <0xf0d70000 &blp_cips_pspmc_0_psv_coresight_a721_etm 0xf0d70000 0x10000>,
         <0xf0f00000 &blp_cips_pspmc_0_psv_coresight_cpm_rom 0xf0f00000 0x10000>,
         <0xf0f20000 &blp_cips_pspmc_0_psv_coresight_cpm_fun 0xf0f20000 0x10000>,
         <0xf0f40000 &blp_cips_pspmc_0_psv_coresight_cpm_ela2a 0xf0f40000 0x10000>,
         <0xf0f50000 &blp_cips_pspmc_0_psv_coresight_cpm_ela2b 0xf0f50000 0x10000>,
         <0xf0f60000 &blp_cips_pspmc_0_psv_coresight_cpm_ela2c 0xf0f60000 0x10000>,
         <0xf0f70000 &blp_cips_pspmc_0_psv_coresight_cpm_ela2d 0xf0f70000 0x10000>,
         <0xf0f80000 &blp_cips_pspmc_0_psv_coresight_cpm_atm 0xf0f80000 0x10000>,
         <0xf0fa0000 &blp_cips_pspmc_0_psv_coresight_cpm_cti2a 0xf0fa0000 0x10000>,
         <0xf0fd0000 &blp_cips_pspmc_0_psv_coresight_cpm_cti2d 0xf0fd0000 0x10000>,
         <0xf1000000 &i2c2 0xf1000000 0x10000>,
         <0xf1010000 &ospi 0xf1010000 0x10000>,
         <0xf1020000 &gpio1 0xf1020000 0x10000>,
         <0xf1110000 &blp_cips_pspmc_0_psv_pmc_global_0 0xf1110000 0x50000>,
         <0xf11c0000 &dma0 0xf11c0000 0x10000>,
         <0xf11d0000 &dma1 0xf11d0000 0x10000>,
         <0xf11e0000 &blp_cips_pspmc_0_psv_pmc_aes 0xf11e0000 0x10000>,
         <0xf11f0000 &blp_cips_pspmc_0_psv_pmc_bbram_ctrl 0xf11f0000 0x10000>,
         <0xf1200000 &blp_cips_pspmc_0_psv_pmc_rsa 0xf1200000 0x10000>,
         <0xf1210000 &blp_cips_pspmc_0_psv_pmc_sha 0xf1210000 0x10000>,
         <0xf1220000 &blp_cips_pspmc_0_psv_pmc_slave_boot 0xf1220000 0x10000>,
         <0xf1230000 &blp_cips_pspmc_0_psv_pmc_trng 0xf1230000 0x10000>,
         <0xf1240000 &blp_cips_pspmc_0_psv_pmc_efuse_ctrl 0xf1240000 0x10000>,
         <0xf1250000 &blp_cips_pspmc_0_psv_pmc_efuse_cache 0xf1250000 0x10000>,
         <0xf1260000 &blp_cips_pspmc_0_psv_crp_0 0xf1260000 0x10000>,
         <0xf1270000 &sysmon0 0xf1270000 0x30000>,
         <0xf12a0000 &rtc 0xf12a0000 0x10000>,
         <0xf12b0000 &blp_cips_pspmc_0_psv_pmc_cfu_apb_0 0xf12b0000 0x10000>,
         <0xf12d0000 &blp_cips_pspmc_0_psv_pmc_cfi_cframe_0 0xf12d0000 0x1000>,
         <0xf12f0000 &pmc_xmpu 0xf12f0000 0x10000>,
         <0xf1300000 &pmc_xppu_npi 0xf1300000 0x10000>,
         <0xf1310000 &pmc_xppu 0xf1310000 0x10000>,
         <0xf2100000 &blp_cips_pspmc_0_psv_pmc_slave_boot_stream 0xf2100000 0x10000>,
         <0xf6000000 &blp_cips_pspmc_0_psv_pmc_ram_npi 0xf6000000 0x2000000>,
         <0xfd000000 &cci 0xfd000000 0x100000>,
         <0xfd1a0000 &blp_cips_pspmc_0_psv_crf_0 0xfd1a0000 0x140000>,
         <0xfd360000 &blp_cips_pspmc_0_psv_fpd_afi_0 0xfd360000 0x10000>,
         <0xfd380000 &blp_cips_pspmc_0_psv_fpd_afi_2 0xfd380000 0x10000>,
         <0xfd390000 &fpd_xmpu 0xfd390000 0x10000>,
         <0xfd5c0000 &blp_cips_pspmc_0_psv_apu_0 0xfd5c0000 0x10000>,
         <0xfd5e0000 &blp_cips_pspmc_0_psv_fpd_cci_0 0xfd5e0000 0x10000>,
         <0xfd5f0000 &blp_cips_pspmc_0_psv_fpd_smmu_0 0xfd5f0000 0x10000>,
         <0xfd610000 &blp_cips_pspmc_0_psv_fpd_slcr_0 0xfd610000 0x10000>,
         <0xfd690000 &blp_cips_pspmc_0_psv_fpd_slcr_secure_0 0xfd690000 0x10000>,
         <0xfd700000 &blp_cips_pspmc_0_psv_fpd_gpv_0 0xfd700000 0x100000>,
         <0xfd800000 &smmu 0xfd800000 0x800000>,
         <0xff000000 &serial0 0xff000000 0x10000>,
         <0xff010000 &serial1 0xff010000 0x10000>,
         <0xff040000 &spi0 0xff040000 0x10000>,
         <0xff080000 &blp_cips_pspmc_0_psv_lpd_iou_slcr_0 0xff080000 0x20000>,
         <0xff0a0000 &blp_cips_pspmc_0_psv_lpd_iou_secure_slcr_0 0xff0a0000 0x10000>,
         <0xff0b0000 &gpio0 0xff0b0000 0x10000>,
         <0xff0e0000 &ttc0 0xff0e0000 0x10000>,
         <0xff0f0000 &ttc1 0xff0f0000 0x10000>,
         <0xff100000 &ttc2 0xff100000 0x10000>,
         <0xff110000 &ttc3 0xff110000 0x10000>,
         <0xff130000 &blp_cips_pspmc_0_psv_scntr_0 0xff130000 0x10000>,
         <0xff140000 &blp_cips_pspmc_0_psv_scntrs_0 0xff140000 0x10000>,
         <0xff410000 &blp_cips_pspmc_0_psv_lpd_slcr_0 0xff410000 0x100000>,
         <0xff510000 &blp_cips_pspmc_0_psv_lpd_slcr_secure_0 0xff510000 0x40000>,
         <0xff5e0000 &blp_cips_pspmc_0_psv_crl_0 0xff5e0000 0x300000>,
         <0xff8e0000 &blp_cips_pspmc_0_psv_xram_ctrl_1 0xff8e0000 0x10000>,
         <0xff8f0000 &blp_cips_pspmc_0_psv_xram_ctrl_2 0xff8f0000 0x10000>,
         <0xff900000 &blp_cips_pspmc_0_psv_xram_ctrl_3 0xff900000 0x10000>,
         <0xff910000 &blp_cips_pspmc_0_psv_xram_ctrl_4 0xff910000 0x10000>,
         <0xff930000 &blp_cips_pspmc_0_psv_xram_xmpu_bank_1 0xff930000 0x4000>,
         <0xff934000 &blp_cips_pspmc_0_psv_xram_xmpu_bank_2 0xff934000 0x4000>,
         <0xff938000 &blp_cips_pspmc_0_psv_xram_xmpu_bank_3 0xff938000 0x4000>,
         <0xff93c000 &blp_cips_pspmc_0_psv_xram_xmpu_bank_4 0xff93c000 0x4000>,
         <0xff940000 &blp_cips_pspmc_0_psv_xram_gpv 0xff940000 0x10000>,
         <0xff950000 &blp_cips_pspmc_0_psv_xram_global_ctrl 0xff950000 0x10000>,
         <0xff960000 &blp_cips_pspmc_0_psv_ocm_ctrl 0xff960000 0x10000>,
         <0xff970000 &blp_cips_pspmc_0_psv_xram_atm 0xff970000 0x10000>,
         <0xff980000 &ocm_xmpu 0xff980000 0x10000>,
         <0xff990000 &lpd_xppu 0xff990000 0x10000>,
         <0xff9a0000 &blp_cips_pspmc_0_psv_rpu_0 0xff9a0000 0x10000>,
         <0xff9b0000 &blp_cips_pspmc_0_psv_lpd_afi_0 0xff9b0000 0x10000>,
         <0xffa80000 &lpd_dma_chan0 0xffa80000 0x10000>,
         <0xffa90000 &lpd_dma_chan1 0xffa90000 0x10000>,
         <0xffaa0000 &lpd_dma_chan2 0xffaa0000 0x10000>,
         <0xffab0000 &lpd_dma_chan3 0xffab0000 0x10000>,
         <0xffac0000 &lpd_dma_chan4 0xffac0000 0x10000>,
         <0xffad0000 &lpd_dma_chan5 0xffad0000 0x10000>,
         <0xffae0000 &lpd_dma_chan6 0xffae0000 0x10000>,
         <0xffaf0000 &lpd_dma_chan7 0xffaf0000 0x10000>,
         <0xffc90000 &blp_cips_pspmc_0_psv_psm_global_reg 0xffc90000 0xf000>,
         <0x0000 &blp_cips_pspmc_0_psv_r5_0_atcm 0x0000 0x10000>,
         <0x00000 &blp_cips_pspmc_0_psv_r5_tcm_ram_0 0x00000 0x40000>,
         <0x20000 &blp_cips_pspmc_0_psv_r5_0_btcm 0x20000 0x10000>,
         <0xf9000000 &gic_r5 0xf9000000 0x3000>,
         <0xffe40000 &blp_cips_pspmc_0_psv_r5_0_instruction_cache 0xffe40000 0x10000>,
         <0xffe50000 &blp_cips_pspmc_0_psv_r5_0_data_cache 0xffe50000 0x10000>,
         <0xffec0000 &blp_cips_pspmc_0_psv_r5_1_instruction_cache 0xffec0000 0x10000>,
         <0xffed0000 &blp_cips_pspmc_0_psv_r5_1_data_cache 0xffed0000 0x10000>;
  #ranges-address-cells = <0x1>;
  #ranges-size-cells = <0x1>;
 };
 cpus_r5_1: cpus-r5@1 {
  compatible = "cpus,cluster";
  address-map = <0xf0000000 &amba 0xf0000000 0x10000000>,
         <0xf9000000 &amba_rpu 0xf9000000 0x3000>,
         <0x40000 &blp_axi_noc_mc_1x_ddr_memory 0x40000 0x7ffc0000>,
         <0xff380000 &ipi5 0xff380000 0x10000>,
         <0xff3a0000 &ipi6 0xff3a0000 0x10000>,
         <0xFFFC0000 &blp_cips_pspmc_0_psv_ocm_ram_0_memory 0xFFFC0000 0x40000>,
         <0x80001000 &blp_blp_logic_axi_firewall_user 0x80001000 0x1000>,
         <0x80010000 &blp_blp_logic_gcq_m2r 0x80010000 0x1000>,
         <0x80011000 &blp_blp_logic_gcq_r2a 0x80011000 0x1000>,
         <0x80020000 &blp_blp_logic_base_clocking_pr_reset_gpio 0x80020000 0x1000>,
         <0x80021000 &blp_blp_logic_axi_uart_rpu 0x80021000 0x1000>,
         <0x80030000 &blp_blp_logic_ulp_clocking_shell_utils_ucc 0x80030000 0x10000>,
         <0x80042000 &blp_blp_logic_ulp_clocking_clkwiz_aclk_kernel_00 0x80042000 0x1000>,
         <0x80043000 &blp_blp_logic_ulp_clocking_clkwiz_aclk_kernel_01 0x80043000 0x1000>,
         <0x80044000 &blp_blp_logic_pfm_irq_ctlr 0x80044000 0x1000>,
         <0x80045000 &blp_blp_logic_uuid_register 0x80045000 0x1000>,
         <0xf0310000 &blp_cips_pspmc_0_psv_pmc_ppu1_mdm_0 0xf0310000 0x8000>,
         <0xf0800000 &coresight 0xf0800000 0x10000>,
         <0xf0980000 &blp_cips_pspmc_0_psv_coresight_lpd_atm 0xf0980000 0x10000>,
         <0xf0b70000 &blp_cips_pspmc_0_psv_coresight_fpd_stm 0xf0b70000 0x10000>,
         <0xf0b80000 &blp_cips_pspmc_0_psv_coresight_fpd_atm 0xf0b80000 0x10000>,
         <0xf0c20000 &blp_cips_pspmc_0_psv_coresight_apu_fun 0xf0c20000 0x10000>,
         <0xf0c30000 &blp_cips_pspmc_0_psv_coresight_apu_etf 0xf0c30000 0x10000>,
         <0xf0c60000 &blp_cips_pspmc_0_psv_coresight_apu_ela 0xf0c60000 0x10000>,
         <0xf0ca0000 &blp_cips_pspmc_0_psv_coresight_apu_cti 0xf0ca0000 0x10000>,
         <0xf0d00000 &blp_cips_pspmc_0_psv_coresight_a720_dbg 0xf0d00000 0x10000>,
         <0xf0d10000 &blp_cips_pspmc_0_psv_coresight_a720_cti 0xf0d10000 0x10000>,
         <0xf0d20000 &blp_cips_pspmc_0_psv_coresight_a720_pmu 0xf0d20000 0x10000>,
         <0xf0d30000 &blp_cips_pspmc_0_psv_coresight_a720_etm 0xf0d30000 0x10000>,
         <0xf0d40000 &blp_cips_pspmc_0_psv_coresight_a721_dbg 0xf0d40000 0x10000>,
         <0xf0d50000 &blp_cips_pspmc_0_psv_coresight_a721_cti 0xf0d50000 0x10000>,
         <0xf0d60000 &blp_cips_pspmc_0_psv_coresight_a721_pmu 0xf0d60000 0x10000>,
         <0xf0d70000 &blp_cips_pspmc_0_psv_coresight_a721_etm 0xf0d70000 0x10000>,
         <0xf0f00000 &blp_cips_pspmc_0_psv_coresight_cpm_rom 0xf0f00000 0x10000>,
         <0xf0f20000 &blp_cips_pspmc_0_psv_coresight_cpm_fun 0xf0f20000 0x10000>,
         <0xf0f40000 &blp_cips_pspmc_0_psv_coresight_cpm_ela2a 0xf0f40000 0x10000>,
         <0xf0f50000 &blp_cips_pspmc_0_psv_coresight_cpm_ela2b 0xf0f50000 0x10000>,
         <0xf0f60000 &blp_cips_pspmc_0_psv_coresight_cpm_ela2c 0xf0f60000 0x10000>,
         <0xf0f70000 &blp_cips_pspmc_0_psv_coresight_cpm_ela2d 0xf0f70000 0x10000>,
         <0xf0f80000 &blp_cips_pspmc_0_psv_coresight_cpm_atm 0xf0f80000 0x10000>,
         <0xf0fa0000 &blp_cips_pspmc_0_psv_coresight_cpm_cti2a 0xf0fa0000 0x10000>,
         <0xf0fd0000 &blp_cips_pspmc_0_psv_coresight_cpm_cti2d 0xf0fd0000 0x10000>,
         <0xf1000000 &i2c2 0xf1000000 0x10000>,
         <0xf1010000 &ospi 0xf1010000 0x10000>,
         <0xf1020000 &gpio1 0xf1020000 0x10000>,
         <0xf1110000 &blp_cips_pspmc_0_psv_pmc_global_0 0xf1110000 0x50000>,
         <0xf11c0000 &dma0 0xf11c0000 0x10000>,
         <0xf11d0000 &dma1 0xf11d0000 0x10000>,
         <0xf11e0000 &blp_cips_pspmc_0_psv_pmc_aes 0xf11e0000 0x10000>,
         <0xf11f0000 &blp_cips_pspmc_0_psv_pmc_bbram_ctrl 0xf11f0000 0x10000>,
         <0xf1200000 &blp_cips_pspmc_0_psv_pmc_rsa 0xf1200000 0x10000>,
         <0xf1210000 &blp_cips_pspmc_0_psv_pmc_sha 0xf1210000 0x10000>,
         <0xf1220000 &blp_cips_pspmc_0_psv_pmc_slave_boot 0xf1220000 0x10000>,
         <0xf1230000 &blp_cips_pspmc_0_psv_pmc_trng 0xf1230000 0x10000>,
         <0xf1240000 &blp_cips_pspmc_0_psv_pmc_efuse_ctrl 0xf1240000 0x10000>,
         <0xf1250000 &blp_cips_pspmc_0_psv_pmc_efuse_cache 0xf1250000 0x10000>,
         <0xf1260000 &blp_cips_pspmc_0_psv_crp_0 0xf1260000 0x10000>,
         <0xf1270000 &sysmon0 0xf1270000 0x30000>,
         <0xf12a0000 &rtc 0xf12a0000 0x10000>,
         <0xf12b0000 &blp_cips_pspmc_0_psv_pmc_cfu_apb_0 0xf12b0000 0x10000>,
         <0xf12d0000 &blp_cips_pspmc_0_psv_pmc_cfi_cframe_0 0xf12d0000 0x1000>,
         <0xf12f0000 &pmc_xmpu 0xf12f0000 0x10000>,
         <0xf1300000 &pmc_xppu_npi 0xf1300000 0x10000>,
         <0xf1310000 &pmc_xppu 0xf1310000 0x10000>,
         <0xf2100000 &blp_cips_pspmc_0_psv_pmc_slave_boot_stream 0xf2100000 0x10000>,
         <0xf6000000 &blp_cips_pspmc_0_psv_pmc_ram_npi 0xf6000000 0x2000000>,
         <0xfd000000 &cci 0xfd000000 0x100000>,
         <0xfd1a0000 &blp_cips_pspmc_0_psv_crf_0 0xfd1a0000 0x140000>,
         <0xfd360000 &blp_cips_pspmc_0_psv_fpd_afi_0 0xfd360000 0x10000>,
         <0xfd380000 &blp_cips_pspmc_0_psv_fpd_afi_2 0xfd380000 0x10000>,
         <0xfd390000 &fpd_xmpu 0xfd390000 0x10000>,
         <0xfd5c0000 &blp_cips_pspmc_0_psv_apu_0 0xfd5c0000 0x10000>,
         <0xfd5e0000 &blp_cips_pspmc_0_psv_fpd_cci_0 0xfd5e0000 0x10000>,
         <0xfd5f0000 &blp_cips_pspmc_0_psv_fpd_smmu_0 0xfd5f0000 0x10000>,
         <0xfd610000 &blp_cips_pspmc_0_psv_fpd_slcr_0 0xfd610000 0x10000>,
         <0xfd690000 &blp_cips_pspmc_0_psv_fpd_slcr_secure_0 0xfd690000 0x10000>,
         <0xfd700000 &blp_cips_pspmc_0_psv_fpd_gpv_0 0xfd700000 0x100000>,
         <0xfd800000 &smmu 0xfd800000 0x800000>,
         <0xff000000 &serial0 0xff000000 0x10000>,
         <0xff010000 &serial1 0xff010000 0x10000>,
         <0xff040000 &spi0 0xff040000 0x10000>,
         <0xff080000 &blp_cips_pspmc_0_psv_lpd_iou_slcr_0 0xff080000 0x20000>,
         <0xff0a0000 &blp_cips_pspmc_0_psv_lpd_iou_secure_slcr_0 0xff0a0000 0x10000>,
         <0xff0b0000 &gpio0 0xff0b0000 0x10000>,
         <0xff0e0000 &ttc0 0xff0e0000 0x10000>,
         <0xff0f0000 &ttc1 0xff0f0000 0x10000>,
         <0xff100000 &ttc2 0xff100000 0x10000>,
         <0xff110000 &ttc3 0xff110000 0x10000>,
         <0xff130000 &blp_cips_pspmc_0_psv_scntr_0 0xff130000 0x10000>,
         <0xff140000 &blp_cips_pspmc_0_psv_scntrs_0 0xff140000 0x10000>,
         <0xff410000 &blp_cips_pspmc_0_psv_lpd_slcr_0 0xff410000 0x100000>,
         <0xff510000 &blp_cips_pspmc_0_psv_lpd_slcr_secure_0 0xff510000 0x40000>,
         <0xff5e0000 &blp_cips_pspmc_0_psv_crl_0 0xff5e0000 0x300000>,
         <0xff8e0000 &blp_cips_pspmc_0_psv_xram_ctrl_1 0xff8e0000 0x10000>,
         <0xff8f0000 &blp_cips_pspmc_0_psv_xram_ctrl_2 0xff8f0000 0x10000>,
         <0xff900000 &blp_cips_pspmc_0_psv_xram_ctrl_3 0xff900000 0x10000>,
         <0xff910000 &blp_cips_pspmc_0_psv_xram_ctrl_4 0xff910000 0x10000>,
         <0xff930000 &blp_cips_pspmc_0_psv_xram_xmpu_bank_1 0xff930000 0x4000>,
         <0xff934000 &blp_cips_pspmc_0_psv_xram_xmpu_bank_2 0xff934000 0x4000>,
         <0xff938000 &blp_cips_pspmc_0_psv_xram_xmpu_bank_3 0xff938000 0x4000>,
         <0xff93c000 &blp_cips_pspmc_0_psv_xram_xmpu_bank_4 0xff93c000 0x4000>,
         <0xff940000 &blp_cips_pspmc_0_psv_xram_gpv 0xff940000 0x10000>,
         <0xff950000 &blp_cips_pspmc_0_psv_xram_global_ctrl 0xff950000 0x10000>,
         <0xff960000 &blp_cips_pspmc_0_psv_ocm_ctrl 0xff960000 0x10000>,
         <0xff970000 &blp_cips_pspmc_0_psv_xram_atm 0xff970000 0x10000>,
         <0xff980000 &ocm_xmpu 0xff980000 0x10000>,
         <0xff990000 &lpd_xppu 0xff990000 0x10000>,
         <0xff9a0000 &blp_cips_pspmc_0_psv_rpu_0 0xff9a0000 0x10000>,
         <0xff9b0000 &blp_cips_pspmc_0_psv_lpd_afi_0 0xff9b0000 0x10000>,
         <0xffa80000 &lpd_dma_chan0 0xffa80000 0x10000>,
         <0xffa90000 &lpd_dma_chan1 0xffa90000 0x10000>,
         <0xffaa0000 &lpd_dma_chan2 0xffaa0000 0x10000>,
         <0xffab0000 &lpd_dma_chan3 0xffab0000 0x10000>,
         <0xffac0000 &lpd_dma_chan4 0xffac0000 0x10000>,
         <0xffad0000 &lpd_dma_chan5 0xffad0000 0x10000>,
         <0xffae0000 &lpd_dma_chan6 0xffae0000 0x10000>,
         <0xffaf0000 &lpd_dma_chan7 0xffaf0000 0x10000>,
         <0xffc90000 &blp_cips_pspmc_0_psv_psm_global_reg 0xffc90000 0xf000>,
         <0x00000 &blp_cips_pspmc_0_psv_r5_tcm_ram_0 0x00000 0x40000>,
         <0xf9000000 &gic_r5 0xf9000000 0x3000>,
         <0xffe40000 &blp_cips_pspmc_0_psv_r5_0_instruction_cache 0xffe40000 0x10000>,
         <0xffe50000 &blp_cips_pspmc_0_psv_r5_0_data_cache 0xffe50000 0x10000>,
         <0xffec0000 &blp_cips_pspmc_0_psv_r5_1_instruction_cache 0xffec0000 0x10000>,
         <0xffed0000 &blp_cips_pspmc_0_psv_r5_1_data_cache 0xffed0000 0x10000>,
         <0x0000 &blp_cips_pspmc_0_psv_r5_1_atcm 0x0000 0x10000>,
         <0x20000 &blp_cips_pspmc_0_psv_r5_1_btcm 0x20000 0x10000>;
  #ranges-address-cells = <0x1>;
  #ranges-size-cells = <0x1>;
 };
 cpus_microblaze_0: cpus_microblaze@0 {
  compatible = "cpus,cluster";
  address-map = <0xf0000000 &amba 0xf0000000 0x10000000>,
         <0x00000000 &blp_axi_noc_mc_1x_ddr_memory 0x00000000 0x80000000>,
         <0xff320000 &ipi_pmc 0xff320000 0x10000>,
         <0xff390000 &ipi_pmc_nobuf 0xff390000 0x10000>,
         <0xFFFC0000 &blp_cips_pspmc_0_psv_ocm_ram_0_memory 0xFFFC0000 0x40000>,
         <0x80001000 &blp_blp_logic_axi_firewall_user 0x80001000 0x1000>,
         <0x80010000 &blp_blp_logic_gcq_m2r 0x80010000 0x1000>,
         <0x80011000 &blp_blp_logic_gcq_r2a 0x80011000 0x1000>,
         <0x80020000 &blp_blp_logic_base_clocking_pr_reset_gpio 0x80020000 0x1000>,
         <0x80021000 &blp_blp_logic_axi_uart_rpu 0x80021000 0x1000>,
         <0x80030000 &blp_blp_logic_ulp_clocking_shell_utils_ucc 0x80030000 0x10000>,
         <0x80042000 &blp_blp_logic_ulp_clocking_clkwiz_aclk_kernel_00 0x80042000 0x1000>,
         <0x80043000 &blp_blp_logic_ulp_clocking_clkwiz_aclk_kernel_01 0x80043000 0x1000>,
         <0x80044000 &blp_blp_logic_pfm_irq_ctlr 0x80044000 0x1000>,
         <0x80045000 &blp_blp_logic_uuid_register 0x80045000 0x1000>,
         <0xf0310000 &blp_cips_pspmc_0_psv_pmc_ppu1_mdm_0 0xf0310000 0x8000>,
         <0xf0980000 &blp_cips_pspmc_0_psv_coresight_lpd_atm 0xf0980000 0x10000>,
         <0xf0b70000 &blp_cips_pspmc_0_psv_coresight_fpd_stm 0xf0b70000 0x10000>,
         <0xf0b80000 &blp_cips_pspmc_0_psv_coresight_fpd_atm 0xf0b80000 0x10000>,
         <0xf0c20000 &blp_cips_pspmc_0_psv_coresight_apu_fun 0xf0c20000 0x10000>,
         <0xf0c30000 &blp_cips_pspmc_0_psv_coresight_apu_etf 0xf0c30000 0x10000>,
         <0xf0c60000 &blp_cips_pspmc_0_psv_coresight_apu_ela 0xf0c60000 0x10000>,
         <0xf0ca0000 &blp_cips_pspmc_0_psv_coresight_apu_cti 0xf0ca0000 0x10000>,
         <0xf0d00000 &blp_cips_pspmc_0_psv_coresight_a720_dbg 0xf0d00000 0x10000>,
         <0xf0d10000 &blp_cips_pspmc_0_psv_coresight_a720_cti 0xf0d10000 0x10000>,
         <0xf0d20000 &blp_cips_pspmc_0_psv_coresight_a720_pmu 0xf0d20000 0x10000>,
         <0xf0d30000 &blp_cips_pspmc_0_psv_coresight_a720_etm 0xf0d30000 0x10000>,
         <0xf0d40000 &blp_cips_pspmc_0_psv_coresight_a721_dbg 0xf0d40000 0x10000>,
         <0xf0d50000 &blp_cips_pspmc_0_psv_coresight_a721_cti 0xf0d50000 0x10000>,
         <0xf0d60000 &blp_cips_pspmc_0_psv_coresight_a721_pmu 0xf0d60000 0x10000>,
         <0xf0d70000 &blp_cips_pspmc_0_psv_coresight_a721_etm 0xf0d70000 0x10000>,
         <0xf0f00000 &blp_cips_pspmc_0_psv_coresight_cpm_rom 0xf0f00000 0x10000>,
         <0xf0f20000 &blp_cips_pspmc_0_psv_coresight_cpm_fun 0xf0f20000 0x10000>,
         <0xf0f40000 &blp_cips_pspmc_0_psv_coresight_cpm_ela2a 0xf0f40000 0x10000>,
         <0xf0f50000 &blp_cips_pspmc_0_psv_coresight_cpm_ela2b 0xf0f50000 0x10000>,
         <0xf0f60000 &blp_cips_pspmc_0_psv_coresight_cpm_ela2c 0xf0f60000 0x10000>,
         <0xf0f70000 &blp_cips_pspmc_0_psv_coresight_cpm_ela2d 0xf0f70000 0x10000>,
         <0xf0f80000 &blp_cips_pspmc_0_psv_coresight_cpm_atm 0xf0f80000 0x10000>,
         <0xf0fa0000 &blp_cips_pspmc_0_psv_coresight_cpm_cti2a 0xf0fa0000 0x10000>,
         <0xf0fd0000 &blp_cips_pspmc_0_psv_coresight_cpm_cti2d 0xf0fd0000 0x10000>,
         <0xf1000000 &i2c2 0xf1000000 0x10000>,
         <0xf1010000 &ospi 0xf1010000 0x10000>,
         <0xf1020000 &gpio1 0xf1020000 0x10000>,
         <0xf1110000 &blp_cips_pspmc_0_psv_pmc_global_0 0xf1110000 0x50000>,
         <0xf11c0000 &dma0 0xf11c0000 0x10000>,
         <0xf11d0000 &dma1 0xf11d0000 0x10000>,
         <0xf11e0000 &blp_cips_pspmc_0_psv_pmc_aes 0xf11e0000 0x10000>,
         <0xf11f0000 &blp_cips_pspmc_0_psv_pmc_bbram_ctrl 0xf11f0000 0x10000>,
         <0xf1200000 &blp_cips_pspmc_0_psv_pmc_rsa 0xf1200000 0x10000>,
         <0xf1210000 &blp_cips_pspmc_0_psv_pmc_sha 0xf1210000 0x10000>,
         <0xf1220000 &blp_cips_pspmc_0_psv_pmc_slave_boot 0xf1220000 0x10000>,
         <0xf1230000 &blp_cips_pspmc_0_psv_pmc_trng 0xf1230000 0x10000>,
         <0xf1240000 &blp_cips_pspmc_0_psv_pmc_efuse_ctrl 0xf1240000 0x10000>,
         <0xf1250000 &blp_cips_pspmc_0_psv_pmc_efuse_cache 0xf1250000 0x10000>,
         <0xf1260000 &blp_cips_pspmc_0_psv_crp_0 0xf1260000 0x10000>,
         <0xf1270000 &sysmon0 0xf1270000 0x30000>,
         <0xf12a0000 &rtc 0xf12a0000 0x10000>,
         <0xf12b0000 &blp_cips_pspmc_0_psv_pmc_cfu_apb_0 0xf12b0000 0x10000>,
         <0xf12d0000 &blp_cips_pspmc_0_psv_pmc_cfi_cframe_0 0xf12d0000 0x1000>,
         <0xf12f0000 &pmc_xmpu 0xf12f0000 0x10000>,
         <0xf1300000 &pmc_xppu_npi 0xf1300000 0x10000>,
         <0xf1310000 &pmc_xppu 0xf1310000 0x10000>,
         <0xf2100000 &blp_cips_pspmc_0_psv_pmc_slave_boot_stream 0xf2100000 0x10000>,
         <0xf6000000 &blp_cips_pspmc_0_psv_pmc_ram_npi 0xf6000000 0x2000000>,
         <0 &blp_cips_pspmc_0_psv_cpm 0 0xfd000000>,
         <0xfd000000 &cci 0xfd000000 0x100000>,
         <0xfd1a0000 &blp_cips_pspmc_0_psv_crf_0 0xfd1a0000 0x140000>,
         <0xfd360000 &blp_cips_pspmc_0_psv_fpd_afi_0 0xfd360000 0x10000>,
         <0xfd380000 &blp_cips_pspmc_0_psv_fpd_afi_2 0xfd380000 0x10000>,
         <0xfd390000 &fpd_xmpu 0xfd390000 0x10000>,
         <0xfd5e0000 &blp_cips_pspmc_0_psv_fpd_cci_0 0xfd5e0000 0x10000>,
         <0xfd5f0000 &blp_cips_pspmc_0_psv_fpd_smmu_0 0xfd5f0000 0x10000>,
         <0xfd610000 &blp_cips_pspmc_0_psv_fpd_slcr_0 0xfd610000 0x10000>,
         <0xfd690000 &blp_cips_pspmc_0_psv_fpd_slcr_secure_0 0xfd690000 0x10000>,
         <0xfd700000 &blp_cips_pspmc_0_psv_fpd_gpv_0 0xfd700000 0x100000>,
         <0xfd800000 &smmu 0xfd800000 0x800000>,
         <0xff000000 &serial0 0xff000000 0x10000>,
         <0xff010000 &serial1 0xff010000 0x10000>,
         <0xff040000 &spi0 0xff040000 0x10000>,
         <0xff080000 &blp_cips_pspmc_0_psv_lpd_iou_slcr_0 0xff080000 0x20000>,
         <0xff0a0000 &blp_cips_pspmc_0_psv_lpd_iou_secure_slcr_0 0xff0a0000 0x10000>,
         <0xff0b0000 &gpio0 0xff0b0000 0x10000>,
         <0xff0e0000 &ttc0 0xff0e0000 0x10000>,
         <0xff0f0000 &ttc1 0xff0f0000 0x10000>,
         <0xff100000 &ttc2 0xff100000 0x10000>,
         <0xff110000 &ttc3 0xff110000 0x10000>,
         <0xff130000 &blp_cips_pspmc_0_psv_scntr_0 0xff130000 0x10000>,
         <0xff140000 &blp_cips_pspmc_0_psv_scntrs_0 0xff140000 0x10000>,
         <0xff410000 &blp_cips_pspmc_0_psv_lpd_slcr_0 0xff410000 0x100000>,
         <0xff510000 &blp_cips_pspmc_0_psv_lpd_slcr_secure_0 0xff510000 0x40000>,
         <0xff5e0000 &blp_cips_pspmc_0_psv_crl_0 0xff5e0000 0x300000>,
         <0xff8e0000 &blp_cips_pspmc_0_psv_xram_ctrl_1 0xff8e0000 0x10000>,
         <0xff8f0000 &blp_cips_pspmc_0_psv_xram_ctrl_2 0xff8f0000 0x10000>,
         <0xff900000 &blp_cips_pspmc_0_psv_xram_ctrl_3 0xff900000 0x10000>,
         <0xff910000 &blp_cips_pspmc_0_psv_xram_ctrl_4 0xff910000 0x10000>,
         <0xff930000 &blp_cips_pspmc_0_psv_xram_xmpu_bank_1 0xff930000 0x4000>,
         <0xff934000 &blp_cips_pspmc_0_psv_xram_xmpu_bank_2 0xff934000 0x4000>,
         <0xff938000 &blp_cips_pspmc_0_psv_xram_xmpu_bank_3 0xff938000 0x4000>,
         <0xff93c000 &blp_cips_pspmc_0_psv_xram_xmpu_bank_4 0xff93c000 0x4000>,
         <0xff940000 &blp_cips_pspmc_0_psv_xram_gpv 0xff940000 0x10000>,
         <0xff950000 &blp_cips_pspmc_0_psv_xram_global_ctrl 0xff950000 0x10000>,
         <0xff960000 &blp_cips_pspmc_0_psv_ocm_ctrl 0xff960000 0x10000>,
         <0xff970000 &blp_cips_pspmc_0_psv_xram_atm 0xff970000 0x10000>,
         <0xff980000 &ocm_xmpu 0xff980000 0x10000>,
         <0xff990000 &lpd_xppu 0xff990000 0x10000>,
         <0xff9b0000 &blp_cips_pspmc_0_psv_lpd_afi_0 0xff9b0000 0x10000>,
         <0xffa80000 &lpd_dma_chan0 0xffa80000 0x10000>,
         <0xffa90000 &lpd_dma_chan1 0xffa90000 0x10000>,
         <0xffaa0000 &lpd_dma_chan2 0xffaa0000 0x10000>,
         <0xffab0000 &lpd_dma_chan3 0xffab0000 0x10000>,
         <0xffac0000 &lpd_dma_chan4 0xffac0000 0x10000>,
         <0xffad0000 &lpd_dma_chan5 0xffad0000 0x10000>,
         <0xffae0000 &lpd_dma_chan6 0xffae0000 0x10000>,
         <0xffaf0000 &lpd_dma_chan7 0xffaf0000 0x10000>,
         <0xffc90000 &blp_cips_pspmc_0_psv_psm_global_reg 0xffc90000 0xf000>,
         <0xffe00000 &psv_r5_0_atcm_global 0xffe00000 0x40000>,
         <0xffe90000 &psv_r5_1_atcm_global 0xffe90000 0x10000>,
         <0xffeb0000 &psv_r5_1_btcm_global 0xffeb0000 0x10000>,
         <0xf0083000 &blp_cips_pspmc_0_psv_pmc_tmr_inject_0 0xf0083000 0x1000>,
         <0xf0200000 &blp_cips_pspmc_0_psv_pmc_ram_instr_cntlr 0xf0200000 0x40000>,
         <0xf0240000 &blp_cips_pspmc_0_psv_pmc_ram_data_cntlr 0xf0240000 0x20000>,
         <0xf0280000 &iomodule0 0xf0280000 0x1000>,
         <0xf0283000 &blp_cips_pspmc_0_psv_pmc_tmr_manager_0 0xf0283000 0x1000>;
  #ranges-address-cells = <0x1>;
  #ranges-size-cells = <0x1>;
 };
 cpus_microblaze_1: cpus_microblaze@1 {
  compatible = "cpus,cluster";
  address-map = <0xf0000000 &amba 0xf0000000 0x10000000>,
         <0x00000000 &blp_axi_noc_mc_1x_ddr_memory 0x00000000 0x80000000>,
         <0xff310000 &ipi_psm 0xff310000 0x10000>,
         <0xFFFC0000 &blp_cips_pspmc_0_psv_ocm_ram_0_memory 0xFFFC0000 0x40000>,
         <0x80001000 &blp_blp_logic_axi_firewall_user 0x80001000 0x1000>,
         <0x80010000 &blp_blp_logic_gcq_m2r 0x80010000 0x1000>,
         <0x80011000 &blp_blp_logic_gcq_r2a 0x80011000 0x1000>,
         <0x80020000 &blp_blp_logic_base_clocking_pr_reset_gpio 0x80020000 0x1000>,
         <0x80021000 &blp_blp_logic_axi_uart_rpu 0x80021000 0x1000>,
         <0x80030000 &blp_blp_logic_ulp_clocking_shell_utils_ucc 0x80030000 0x10000>,
         <0x80042000 &blp_blp_logic_ulp_clocking_clkwiz_aclk_kernel_00 0x80042000 0x1000>,
         <0x80043000 &blp_blp_logic_ulp_clocking_clkwiz_aclk_kernel_01 0x80043000 0x1000>,
         <0x80044000 &blp_blp_logic_pfm_irq_ctlr 0x80044000 0x1000>,
         <0x80045000 &blp_blp_logic_uuid_register 0x80045000 0x1000>,
         <0xf0310000 &blp_cips_pspmc_0_psv_pmc_ppu1_mdm_0 0xf0310000 0x8000>,
         <0xf0980000 &blp_cips_pspmc_0_psv_coresight_lpd_atm 0xf0980000 0x10000>,
         <0xf0b70000 &blp_cips_pspmc_0_psv_coresight_fpd_stm 0xf0b70000 0x10000>,
         <0xf0b80000 &blp_cips_pspmc_0_psv_coresight_fpd_atm 0xf0b80000 0x10000>,
         <0xf0c20000 &blp_cips_pspmc_0_psv_coresight_apu_fun 0xf0c20000 0x10000>,
         <0xf0c30000 &blp_cips_pspmc_0_psv_coresight_apu_etf 0xf0c30000 0x10000>,
         <0xf0c60000 &blp_cips_pspmc_0_psv_coresight_apu_ela 0xf0c60000 0x10000>,
         <0xf0ca0000 &blp_cips_pspmc_0_psv_coresight_apu_cti 0xf0ca0000 0x10000>,
         <0xf0d00000 &blp_cips_pspmc_0_psv_coresight_a720_dbg 0xf0d00000 0x10000>,
         <0xf0d10000 &blp_cips_pspmc_0_psv_coresight_a720_cti 0xf0d10000 0x10000>,
         <0xf0d20000 &blp_cips_pspmc_0_psv_coresight_a720_pmu 0xf0d20000 0x10000>,
         <0xf0d30000 &blp_cips_pspmc_0_psv_coresight_a720_etm 0xf0d30000 0x10000>,
         <0xf0d40000 &blp_cips_pspmc_0_psv_coresight_a721_dbg 0xf0d40000 0x10000>,
         <0xf0d50000 &blp_cips_pspmc_0_psv_coresight_a721_cti 0xf0d50000 0x10000>,
         <0xf0d60000 &blp_cips_pspmc_0_psv_coresight_a721_pmu 0xf0d60000 0x10000>,
         <0xf0d70000 &blp_cips_pspmc_0_psv_coresight_a721_etm 0xf0d70000 0x10000>,
         <0xf0f00000 &blp_cips_pspmc_0_psv_coresight_cpm_rom 0xf0f00000 0x10000>,
         <0xf0f20000 &blp_cips_pspmc_0_psv_coresight_cpm_fun 0xf0f20000 0x10000>,
         <0xf0f40000 &blp_cips_pspmc_0_psv_coresight_cpm_ela2a 0xf0f40000 0x10000>,
         <0xf0f50000 &blp_cips_pspmc_0_psv_coresight_cpm_ela2b 0xf0f50000 0x10000>,
         <0xf0f60000 &blp_cips_pspmc_0_psv_coresight_cpm_ela2c 0xf0f60000 0x10000>,
         <0xf0f70000 &blp_cips_pspmc_0_psv_coresight_cpm_ela2d 0xf0f70000 0x10000>,
         <0xf0f80000 &blp_cips_pspmc_0_psv_coresight_cpm_atm 0xf0f80000 0x10000>,
         <0xf0fa0000 &blp_cips_pspmc_0_psv_coresight_cpm_cti2a 0xf0fa0000 0x10000>,
         <0xf0fd0000 &blp_cips_pspmc_0_psv_coresight_cpm_cti2d 0xf0fd0000 0x10000>,
         <0xf1000000 &i2c2 0xf1000000 0x10000>,
         <0xf1010000 &ospi 0xf1010000 0x10000>,
         <0xf1020000 &gpio1 0xf1020000 0x10000>,
         <0xf1110000 &blp_cips_pspmc_0_psv_pmc_global_0 0xf1110000 0x50000>,
         <0xf11c0000 &dma0 0xf11c0000 0x10000>,
         <0xf11d0000 &dma1 0xf11d0000 0x10000>,
         <0xf11e0000 &blp_cips_pspmc_0_psv_pmc_aes 0xf11e0000 0x10000>,
         <0xf11f0000 &blp_cips_pspmc_0_psv_pmc_bbram_ctrl 0xf11f0000 0x10000>,
         <0xf1200000 &blp_cips_pspmc_0_psv_pmc_rsa 0xf1200000 0x10000>,
         <0xf1210000 &blp_cips_pspmc_0_psv_pmc_sha 0xf1210000 0x10000>,
         <0xf1220000 &blp_cips_pspmc_0_psv_pmc_slave_boot 0xf1220000 0x10000>,
         <0xf1230000 &blp_cips_pspmc_0_psv_pmc_trng 0xf1230000 0x10000>,
         <0xf1240000 &blp_cips_pspmc_0_psv_pmc_efuse_ctrl 0xf1240000 0x10000>,
         <0xf1250000 &blp_cips_pspmc_0_psv_pmc_efuse_cache 0xf1250000 0x10000>,
         <0xf1260000 &blp_cips_pspmc_0_psv_crp_0 0xf1260000 0x10000>,
         <0xf1270000 &sysmon0 0xf1270000 0x30000>,
         <0xf12a0000 &rtc 0xf12a0000 0x10000>,
         <0xf12b0000 &blp_cips_pspmc_0_psv_pmc_cfu_apb_0 0xf12b0000 0x10000>,
         <0xf12d0000 &blp_cips_pspmc_0_psv_pmc_cfi_cframe_0 0xf12d0000 0x1000>,
         <0xf12f0000 &pmc_xmpu 0xf12f0000 0x10000>,
         <0xf1300000 &pmc_xppu_npi 0xf1300000 0x10000>,
         <0xf1310000 &pmc_xppu 0xf1310000 0x10000>,
         <0xf2100000 &blp_cips_pspmc_0_psv_pmc_slave_boot_stream 0xf2100000 0x10000>,
         <0xf6000000 &blp_cips_pspmc_0_psv_pmc_ram_npi 0xf6000000 0x2000000>,
         <0xfd000000 &cci 0xfd000000 0x100000>,
         <0xfd1a0000 &blp_cips_pspmc_0_psv_crf_0 0xfd1a0000 0x140000>,
         <0xfd360000 &blp_cips_pspmc_0_psv_fpd_afi_0 0xfd360000 0x10000>,
         <0xfd380000 &blp_cips_pspmc_0_psv_fpd_afi_2 0xfd380000 0x10000>,
         <0xfd390000 &fpd_xmpu 0xfd390000 0x10000>,
         <0xfd5e0000 &blp_cips_pspmc_0_psv_fpd_cci_0 0xfd5e0000 0x10000>,
         <0xfd5f0000 &blp_cips_pspmc_0_psv_fpd_smmu_0 0xfd5f0000 0x10000>,
         <0xfd610000 &blp_cips_pspmc_0_psv_fpd_slcr_0 0xfd610000 0x10000>,
         <0xfd690000 &blp_cips_pspmc_0_psv_fpd_slcr_secure_0 0xfd690000 0x10000>,
         <0xfd700000 &blp_cips_pspmc_0_psv_fpd_gpv_0 0xfd700000 0x100000>,
         <0xfd800000 &smmu 0xfd800000 0x800000>,
         <0xff000000 &serial0 0xff000000 0x10000>,
         <0xff010000 &serial1 0xff010000 0x10000>,
         <0xff040000 &spi0 0xff040000 0x10000>,
         <0xff080000 &blp_cips_pspmc_0_psv_lpd_iou_slcr_0 0xff080000 0x20000>,
         <0xff0a0000 &blp_cips_pspmc_0_psv_lpd_iou_secure_slcr_0 0xff0a0000 0x10000>,
         <0xff0b0000 &gpio0 0xff0b0000 0x10000>,
         <0xff0e0000 &ttc0 0xff0e0000 0x10000>,
         <0xff0f0000 &ttc1 0xff0f0000 0x10000>,
         <0xff100000 &ttc2 0xff100000 0x10000>,
         <0xff110000 &ttc3 0xff110000 0x10000>,
         <0xff130000 &blp_cips_pspmc_0_psv_scntr_0 0xff130000 0x10000>,
         <0xff140000 &blp_cips_pspmc_0_psv_scntrs_0 0xff140000 0x10000>,
         <0xff410000 &blp_cips_pspmc_0_psv_lpd_slcr_0 0xff410000 0x100000>,
         <0xff510000 &blp_cips_pspmc_0_psv_lpd_slcr_secure_0 0xff510000 0x40000>,
         <0xff5e0000 &blp_cips_pspmc_0_psv_crl_0 0xff5e0000 0x300000>,
         <0xff8e0000 &blp_cips_pspmc_0_psv_xram_ctrl_1 0xff8e0000 0x10000>,
         <0xff8f0000 &blp_cips_pspmc_0_psv_xram_ctrl_2 0xff8f0000 0x10000>,
         <0xff900000 &blp_cips_pspmc_0_psv_xram_ctrl_3 0xff900000 0x10000>,
         <0xff910000 &blp_cips_pspmc_0_psv_xram_ctrl_4 0xff910000 0x10000>,
         <0xff930000 &blp_cips_pspmc_0_psv_xram_xmpu_bank_1 0xff930000 0x4000>,
         <0xff934000 &blp_cips_pspmc_0_psv_xram_xmpu_bank_2 0xff934000 0x4000>,
         <0xff938000 &blp_cips_pspmc_0_psv_xram_xmpu_bank_3 0xff938000 0x4000>,
         <0xff93c000 &blp_cips_pspmc_0_psv_xram_xmpu_bank_4 0xff93c000 0x4000>,
         <0xff940000 &blp_cips_pspmc_0_psv_xram_gpv 0xff940000 0x10000>,
         <0xff950000 &blp_cips_pspmc_0_psv_xram_global_ctrl 0xff950000 0x10000>,
         <0xff960000 &blp_cips_pspmc_0_psv_ocm_ctrl 0xff960000 0x10000>,
         <0xff970000 &blp_cips_pspmc_0_psv_xram_atm 0xff970000 0x10000>,
         <0xff980000 &ocm_xmpu 0xff980000 0x10000>,
         <0xff990000 &lpd_xppu 0xff990000 0x10000>,
         <0xff9b0000 &blp_cips_pspmc_0_psv_lpd_afi_0 0xff9b0000 0x10000>,
         <0xffa80000 &lpd_dma_chan0 0xffa80000 0x10000>,
         <0xffa90000 &lpd_dma_chan1 0xffa90000 0x10000>,
         <0xffaa0000 &lpd_dma_chan2 0xffaa0000 0x10000>,
         <0xffab0000 &lpd_dma_chan3 0xffab0000 0x10000>,
         <0xffac0000 &lpd_dma_chan4 0xffac0000 0x10000>,
         <0xffad0000 &lpd_dma_chan5 0xffad0000 0x10000>,
         <0xffae0000 &lpd_dma_chan6 0xffae0000 0x10000>,
         <0xffaf0000 &lpd_dma_chan7 0xffaf0000 0x10000>,
         <0xffc90000 &blp_cips_pspmc_0_psv_psm_global_reg 0xffc90000 0xf000>,
         <0xffe00000 &psv_r5_0_atcm_global 0xffe00000 0x40000>,
         <0xffe90000 &psv_r5_1_atcm_global 0xffe90000 0x10000>,
         <0xffeb0000 &psv_r5_1_btcm_global 0xffeb0000 0x10000>,
         <0xffc00000 &blp_cips_pspmc_0_psv_psm_ram_instr_cntlr 0xffc00000 0x20000>,
         <0xffc20000 &blp_cips_pspmc_0_psv_psm_ram_data_cntlr 0xffc20000 0x20000>,
         <0xffc80000 &blp_cips_pspmc_0_psv_psm_iomodule_0 0xffc80000 0x8000>,
         <0xffcc0000 &blp_cips_pspmc_0_psv_psm_tmr_manager_0 0xffcc0000 0x10000>,
         <0xffcd0000 &blp_cips_pspmc_0_psv_psm_tmr_inject_0 0xffcd0000 0x10000>;
  #ranges-address-cells = <0x1>;
  #ranges-size-cells = <0x1>;
 };
};
# 1 "/scratch/jenkins-sdt_artifactory_upload_2024.2-52/build_cfg/hw-description/emb-plus-ve2302-sdt_2024.2_1111_2/versal-emb-plus-ve2302-reva.dtsi" 1
# 10 "/scratch/jenkins-sdt_artifactory_upload_2024.2-52/build_cfg/hw-description/emb-plus-ve2302-sdt_2024.2_1111_2/versal-emb-plus-ve2302-reva.dtsi"
# 1 "/scratch/jenkins-sdt_artifactory_upload_2024.2-52/build_cfg/hw-description/emb-plus-ve2302-sdt_2024.2_1111_2/include/dt-bindings/gpio/gpio.h" 1
# 11 "/scratch/jenkins-sdt_artifactory_upload_2024.2-52/build_cfg/hw-description/emb-plus-ve2302-sdt_2024.2_1111_2/versal-emb-plus-ve2302-reva.dtsi" 2

/ {
 compatible = "xlnx,versal-emb-plus-ve2302-revA",
       "xlnx,versal-emb-plus-ve2302",
       "xlnx,versal";
 model = "Xilinx Versal Embedded+ VE2302 revA";


 chosen {
  bootargs = "earlycon clk_ignore_unused";
  stdout-path = "serial0:115200";
 };

 aliases {
  serial0 = &serial0;
  serial1 = &serial1;
  i2c0 = &i2c0;
 };


 onewire {
  compatible = "w1-gpio";
  gpios = <&gpio0 4 0>;
 };
};


&gpio0 {
 gpio-line-names = "GPIO_LED2", "GPIO_LED3", "GPIO_LED4", "", "1WIRE",
   "", "FUSA", "", "EGPIO", "AGPIO",
   "I2C0_SCL", "I2C0_SDA", "", "", "",
   "", "", "", "", "",
   "", "", "", "", "3V3_MON_N",
   "3V3_MON_P",
   "", "", "",
   "", "", "", "", "",
   "", "", "", "", "",
   "", "", "", "", "",
   "", "", "", "", "",
   "", "", "", "", "",
   "", "", "";
};
# 691 "/scratch/jenkins-sdt_artifactory_upload_2024.2-52/build_cfg/hw-description/emb-plus-ve2302-sdt_2024.2_1111_2/system-top.dts" 2
