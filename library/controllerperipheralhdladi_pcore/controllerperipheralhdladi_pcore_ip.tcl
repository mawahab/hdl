# ip

source ../scripts/adi_env.tcl
source $ad_hdl_dir/library/scripts/adi_ip.tcl

adi_ip_create controllerperipheralhdladi_pcore
adi_ip_files controllerperipheralhdladi_pcore [list \
"velocityControlHdl_Clamp.v" \
"velocityControlHdl_Convert_Data_Type1.v" \
"velocityControlHdl_Maintain_Range.v" \
"velocityControlHdl_Dynamic_Saturation.v" \
"velocityControlHdl_PI_Sat.v" \
"velocityControlHdl_Reset_Delay.v" \
"velocityControlHdl_Control_Current.v" \
"velocityControlHdl_Clamp_block.v" \
"velocityControlHdl_Convert_Data_Type1_block.v" \
"velocityControlHdl_Maintain_Range_block.v" \
"velocityControlHdl_Dynamic_Saturation_block.v" \
"velocityControlHdl_PI_Sat_block.v" \
"velocityControlHdl_Reset_Delay_block.v" \
"velocityControlHdl_Control_Current1.v" \
"velocityControlHdl_Control_DQ_Currents.v" \
"velocityControlHdl_Clamp_block1.v" \
"velocityControlHdl_Convert_Data_Type.v" \
"velocityControlHdl_Maintain_Range_block1.v" \
"velocityControlHdl_Dynamic_Saturation_block1.v" \
"velocityControlHdl_PI_Sat_block1.v" \
"velocityControlHdl_Reset_Delay_block1.v" \
"velocityControlHdl_Rotor_Velocity_Control.v" \
"velocityControlHdl_Control_Velocity.v" \
"velocityControlHdl_Complex_Multiply.v" \
"velocityControlHdl_Convert_Data_Type_block.v" \
"velocityControlHdl_MATLAB_Function.v" \
"velocityControlHdl_Mark_Extract_Bits.v" \
"velocityControlHdl_MATLAB_Function_block.v" \
"velocityControlHdl_Mark_Extract_Bits1.v" \
"velocityControlHdl_Sin_Cos1.v" \
"velocityControlHdl_Double_Range.v" \
"velocityControlHdl_MinMax.v" \
"velocityControlHdl_MinMax1.v" \
"velocityControlHdl_Space_Vector_Modulation.v" \
"velocityControlHdl_Clarke_Transform.v" \
"velocityControlHdl_Park_Transform.v" \
"velocityControlHdl_Transform_ABC_to_dq.v" \
"velocityControlHdl_Inverse_Clarke_Transform.v" \
"velocityControlHdl_Convert_Data_Type_block1.v" \
"velocityControlHdl_Convert_Data_Type1_block1.v" \
"velocityControlHdl_Inverse_Park_Transform.v" \
"velocityControlHdl_Transform_dq_to_ABC.v" \
"velocityControlHdl_velocityControlHdl.v" \
"controllerHdl_ADC_Peripheral_To_Phase_Current.v" \
"controllerHdl_Wrap_NegPi_To_Pi.v" \
"controllerHdl_Calculate_Rotor_Velocity.v" \
"controllerHdl_Wrap_2pi.v" \
"controllerHdl_Encoder_To_Rotor_Position.v" \
"controllerHdl_MATLAB_Function.v" \
"controllerHdl_Mark_Extract_Bits.v" \
"controllerHdl_Mod_2pi_Scale_And_Bit_Slice.v" \
"controllerHdl_Rotor_To_Electrical_Position.v" \
"controllerHdl_Encoder_To_Position_And_Velocity.v" \
"controllerHdl_Reset_Delay.v" \
"controllerHdl_Wrap_2pi_Once.v" \
"controllerHdl_Electrical_Velocity_To_Position.v" \
"controllerHdl_Convert_Data_Type.v" \
"controllerHdl_Double_Range.v" \
"controllerHdl_Frequency_To_Volts.v" \
"controllerHdl_Reset_Delay_block.v" \
"controllerHdl_Detect_Change.v" \
"controllerHdl_Set_Acceleration.v" \
"controllerHdl_Rotor_Acceleration_To_Velocity.v" \
"controllerHdl_Convert_Data_Type_block.v" \
"controllerHdl_Rotor_To_Electical_Velocity.v" \
"controllerHdl_Generate_Position_And_Voltage_Ramp.v" \
"controllerHdl_Complex_Multiply.v" \
"controllerHdl_Convert_Data_Type_block1.v" \
"controllerHdl_MATLAB_Function_block.v" \
"controllerHdl_Mark_Extract_Bits_block.v" \
"controllerHdl_MATLAB_Function_block1.v" \
"controllerHdl_Mark_Extract_Bits1.v" \
"controllerHdl_Sin_Cos.v" \
"controllerHdl_Inverse_Clarke_Transform.v" \
"controllerHdl_Convert_Data_Type_block2.v" \
"controllerHdl_Convert_Data_Type1.v" \
"controllerHdl_Inverse_Park_Transform.v" \
"controllerHdl_Transform_dq_to_ABC.v" \
"controllerHdl_Open_Loop_Control.v" \
"controllerHdl_StandBy.v" \
"controllerHdl_MATLAB_Function_block2.v" \
"controllerHdl_Field_Oriented_Control.v" \
"controllerHdl_Phase_Voltages_To_Compare_Values.v" \
"controllerHdl_MATLAB_Function_block3.v" \
"controllerHdl_controllerHdl.v" \
"Count_Up_Down.v" \
"Debounce_A.v" \
"Debounce_B.v" \
"Debounce_Index.v" \
"Detect_Change_To_One.v" \
"Latch_Index_Pulse.v" \
"Select_AB.v" \
"Update_Count_From_AB.v" \
"Encoder_Peripheral_Hardware_Specification.v" \
"Chart.v" \
"PWM.v" \
"controllerPeripheralHdlAdi_tc.v" \
"controllerPeripheralHdlAdi.v" \
"controllerperipheralhdladi_pcore_dut.v" \
"controllerperipheralhdladi_pcore_axi_lite_module.v" \
"controllerperipheralhdladi_pcore_addr_decoder.v" \
"controllerperipheralhdladi_pcore_axi_lite.v" \
"controllerperipheralhdladi_pcore.v" ]

adi_ip_properties controllerperipheralhdladi_pcore

set_property physical_name {s_axi_aclk} [ipx::get_port_map CLK \
  [ipx::get_bus_interface s_axi_signal_clock [ipx::current_core]]]

ipx::remove_bus_interface {signal_clock} [ipx::current_core]

ipx::save_core [ipx::current_core]

