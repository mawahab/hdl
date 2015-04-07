// ***************************************************************************
// ***************************************************************************
// Copyright 2015(c) Analog Devices, Inc.
//
// All rights reserved.
//
// Redistribution and use in source and binary forms, with or without modification,
// are permitted provided that the following conditions are met:
//     - Redistributions of source code must retain the above copyright
//       notice, this list of conditions and the following disclaimer.
//     - Redistributions in binary form must reproduce the above copyright
//       notice, this list of conditions and the following disclaimer in
//       the documentation and/or other materials provided with the
//       distribution.
//     - Neither the name of Analog Devices, Inc. nor the names of its
//       contributors may be used to endorse or promote products derived
//       from this software without specific prior written permission.
//     - The use of this software may or may not infringe the patent rights
//       of one or more patent holders.  This license does not release you
//       from the requirement that you obtain separate licenses from these
//       patent holders to use this software.
//     - Use of the software either in source or binary form, must be run
//       on or directly connected to an Analog Devices Inc. component.
//
// THIS SOFTWARE IS PROVIDED BY ANALOG DEVICES "AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES,
// INCLUDING, BUT NOT LIMITED TO, NON-INFRINGEMENT, MERCHANTABILITY AND FITNESS FOR A
// PARTICULAR PURPOSE ARE DISCLAIMED.
//
// IN NO EVENT SHALL ANALOG DEVICES BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL,
// EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, INTELLECTUAL PROPERTY
// RIGHTS, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR
// BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT,
// STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF
// THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
// ***************************************************************************
// ***************************************************************************
// ***************************************************************************
// ***************************************************************************

`timescale 1ns/100ps

module axi_fifo2dac (

  // clock signals

  dac_clk,
  dac_rst,

  // transfer request from DMAC

  xfer_req,

  // fifo IN interface/channel

  data_in_0,
  dvalid_in_0,
  data_in_1,
  dvalid_in_1,
  data_in_2,
  dvalid_in_2,
  data_in_3,
  dvalid_in_3,
  data_in_4,
  dvalid_in_4,
  data_in_5,
  dvalid_in_5,
  data_in_6,
  dvalid_in_6,
  data_in_7,
  dvalid_in_7,

  // fifo OUT interface/channel

  dvalid_out_0,
  data_out_0,
  dvalid_out_1,
  data_out_1,
  dvalid_out_2,
  data_out_2,
  dvalid_out_3,
  data_out_3,
  dvalid_out_4,
  data_out_4,
  dvalid_out_5,
  data_out_5,
  dvalid_out_6,
  data_out_6,
  dvalid_out_7,
  data_out_7
);

  // parameters

  parameter               CH_DW = 16;
  parameter               FIFO_AW = 10;

  localparam              FIFO_DW = 8 * CH_DW;

  // port definitions

  input                   dac_clk;
  input                   dac_rst;

  input                   xfer_req;

  input   [(CH_DW-1):0]   data_in_0;
  input                   dvalid_in_0;
  input   [(CH_DW-1):0]   data_in_1;
  input                   dvalid_in_1;
  input   [(CH_DW-1):0]   data_in_2;
  input                   dvalid_in_2;
  input   [(CH_DW-1):0]   data_in_3;
  input                   dvalid_in_3;
  input   [(CH_DW-1):0]   data_in_4;
  input                   dvalid_in_4;
  input   [(CH_DW-1):0]   data_in_5;
  input                   dvalid_in_5;
  input   [(CH_DW-1):0]   data_in_6;
  input                   dvalid_in_6;
  input   [(CH_DW-1):0]   data_in_7;
  input                   dvalid_in_7;

  input                   dvalid_out_0;
  output  [(CH_DW-1):0]   data_out_0;
  input                   dvalid_out_1;
  output  [(CH_DW-1):0]   data_out_1;
  input                   dvalid_out_2;
  output  [(CH_DW-1):0]   data_out_2;
  input                   dvalid_out_3;
  output  [(CH_DW-1):0]   data_out_3;
  input                   dvalid_out_4;
  output  [(CH_DW-1):0]   data_out_4;
  input                   dvalid_out_5;
  output  [(CH_DW-1):0]   data_out_5;
  input                   dvalid_out_6;
  output  [(CH_DW-1):0]   data_out_6;
  input                   dvalid_out_7;
  output  [(CH_DW-1):0]   data_out_7;

  // internal signals

  wire    [(FIFO_DW-1):0] data_in_s;
  wire    [(FIFO_DW-1):0] data_out_s;
  wire                    dvalid_in_s;
  wire                    dvalid_out_s;

  wire                    fifo_wren_s;

  // internal registers

  reg     [ 2:0]          dac_xfer_req_m = 'b0;
  reg                     dac_xfer_init = 'b0;
  reg                     dac_xfer_enable = 'b0;
  reg                     dac_xfer_enable_d = 'b0;
  reg                     dac_read_init = 'b0;
  reg                     dac_read_enable = 'b0;

  reg     [(FIFO_AW-1):0] dac_waddr = 'b0;
  reg     [(FIFO_AW-1):0] dac_waddr_d = 'b0;
  reg     [(FIFO_AW-1):0] dac_raddr = 'b0;
  reg     [(FIFO_AW-1):0] dac_maxaddr = 'b0;

  reg     [(FIFO_DW-1):0] data_in = 'b0;
  reg     [(FIFO_DW-1):0] data_in_d = 'b0;
  reg                     dvalid_in = 1'b0;
  reg                     dvalid_in_d = 1'b0;

  // internal logic

  assign data_in_s = {data_in_7, data_in_6, data_in_5, data_in_4,
                      data_in_3, data_in_2, data_in_1, data_in_0};

  assign dvalid_in_s =  dvalid_in_0 | dvalid_in_1 | dvalid_in_2 | dvalid_in_3 |
                        dvalid_in_4 | dvalid_in_5 | dvalid_in_6 | dvalid_in_7;

  assign dac_waddr_limit_s = &dac_waddr_d;

  // write interface

  always @(posedge dac_clk) begin
    if(dac_rst == 1'b1) begin
      dac_xfer_req_m <= 3'b0;
      dac_xfer_init <= 1'b0;
      dac_xfer_enable <= 1'b0;
    end else begin
      dac_xfer_req_m <= {dac_xfer_req_m[1:0], xfer_req};
      dac_xfer_init <= ~dac_xfer_req_m[2] & dac_xfer_req_m[1];
      if(dac_xfer_init  ==  1'b1) begin
        dac_xfer_enable <= 1'b1;
      end else if ((dac_waddr_limit_s == 1'b1) || (dac_xfer_req_m[2] == 1'b0)) begin
        dac_xfer_enable <= 1'b0;
      end
    end
  end

  always @(posedge dac_clk) begin
    if(dac_rst == 1'b1) begin
      dac_waddr <= 'h0;
      dac_waddr_d <= 'h0;
      dac_maxaddr <= {FIFO_AW{1'b1}};
    end if(dvalid_in_d == 1'b1) begin
      dac_waddr <= (dac_xfer_enable == 1'b1) ? (dac_waddr + 1) : 'h0;
      dac_waddr_d <= dac_waddr;
    end
    if((dac_xfer_enable == 1'b0) && (dac_xfer_enable_d == 1'b1)) begin
      dac_maxaddr <= dac_waddr_d;
    end
  end

  // pipelines

  always @(posedge dac_clk) begin
    if(dac_rst == 1'b1) begin
      data_in <= 'b0;
      data_in_d <= 'b0;
      dvalid_in <= 1'b0;
      dvalid_in_d <= 1'b0;
      dac_xfer_enable_d <= 1'b0;
    end else begin
      data_in <= data_in_s;
      data_in_d <= data_in;
      dvalid_in <= dvalid_in_s;
      dvalid_in_d <= dvalid_in;
      dac_xfer_enable_d <= dac_xfer_enable;
    end
  end

  assign fifo_wren_s = dvalid_in_d & dac_xfer_enable;

  // read interface

  assign dvalid_out_s = dvalid_out_0 | dvalid_out_1 | dvalid_out_2 | dvalid_out_3 |
                        dvalid_out_4 | dvalid_out_5 | dvalid_out_6 | dvalid_out_7;

  always @(posedge dac_clk) begin
    if(dac_rst == 1'b1) begin
      dac_raddr <= 'b0;
    end else begin
      if(dvalid_out_s == 1'b1) begin
        dac_raddr <= (dac_raddr < dac_maxaddr) ? (dac_raddr + 'b1) : 'b0;
      end
    end
  end

  // output logic

  assign data_out_0 = data_out_s[(1*CH_DW-1):        0];
  assign data_out_1 = data_out_s[(2*CH_DW-1):(1*CH_DW)];
  assign data_out_2 = data_out_s[(3*CH_DW-1):(2*CH_DW)];
  assign data_out_3 = data_out_s[(4*CH_DW-1):(3*CH_DW)];
  assign data_out_4 = data_out_s[(5*CH_DW-1):(4*CH_DW)];
  assign data_out_5 = data_out_s[(6*CH_DW-1):(5*CH_DW)];
  assign data_out_6 = data_out_s[(7*CH_DW-1):(6*CH_DW)];
  assign data_out_7 = data_out_s[(8*CH_DW-1):(7*CH_DW)];

  // memory instantiation

  ad_mem #(
    .ADDR_WIDTH (FIFO_AW),
    .DATA_WIDTH (FIFO_DW))
  i_mem_fifo (
    .clka (dac_clk),
    .wea (fifo_wren_s),
    .addra (dac_waddr),
    .dina (data_in_d),
    .clkb (dac_clk),
    .addrb (dac_raddr),
    .doutb (data_out_s));

endmodule