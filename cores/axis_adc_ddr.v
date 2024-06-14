
`timescale 1 ns / 1 ps

module axis_adc_ddr #
(
  parameter integer ADC_DATA_WIDTH = 7,
  parameter integer AXIS_TDATA_WIDTH = 16
)
(
  // System signals
  input  wire                        aclk,

  // ADC signals
  input  wire [ADC_DATA_WIDTH-1:0]   adc_data,

  // Master side
  output wire [AXIS_TDATA_WIDTH-1:0] m_axis_tdata,
  output wire                        m_axis_tvalid
);
  localparam PADDING_WIDTH = AXIS_TDATA_WIDTH - ADC_DATA_WIDTH*2;

  wire [ADC_DATA_WIDTH*2-1:0] int_data_wire;

  genvar j;

  generate
    for(j = 0; j < ADC_DATA_WIDTH; j = j + 1)
    begin : ADC_DATA
      IDDR #(
        .DDR_CLK_EDGE("SAME_EDGE_PIPELINED")
      ) IDDR_inst (
        .Q1(int_data_wire[j*2+0]),
        .Q2(int_data_wire[j*2+1]),
        .D(adc_data[j]),
        .C(aclk),
        .CE(1'b1),
        .R(1'b0),
        .S(1'b0)
      );
    end
  endgenerate

  assign m_axis_tvalid = 1'b1;

  assign m_axis_tdata = {{(PADDING_WIDTH+1){int_data_wire[ADC_DATA_WIDTH*2-1]}}, int_data_wire[ADC_DATA_WIDTH*2-2:0]};

endmodule
