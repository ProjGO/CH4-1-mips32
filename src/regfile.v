// 实现32个32位的通用整数寄存器，可以同时进行两个寄存器的读操作和一个寄存器的写操作
`include "defines.v"
module regfile(
           input wire clk, wire rst,
           // 写端口
           wire we, wire[`RegAddrBus] waddr, wire[`RegBus] wdata,

           // 读端口 1
           input wire                          re1,
           wire [`RegAddrBus]                  raddr1,
           output reg[`RegBus]                 rdata1,

           // 读端口 2
           input wire                          re2,
           input wire[`RegAddrBus]             raddr2,
           output reg[`RegBus]                 rdata2
       );

// defination
reg[`RegBus]    regs[0:`RegNum-1];

// write
always @(posedge clk) begin
    if (rst == `RstEnable) begin
        regs[0] <= 32'b0;
        regs[1] <= 32'b0;
        regs[2] <= 32'b0;
        regs[3] <= 32'b0;
        regs[4] <= 32'b0;
        regs[5] <= 32'b0;
        regs[6] <= 32'b0;
        regs[7] <= 32'b0;
        regs[8] <= 32'b0;
        regs[9] <= 32'b0;
        regs[10] <= 32'b0;
        regs[11] <= 32'b0;
        regs[12] <= 32'b0;
        regs[13] <= 32'b0;
        regs[14] <= 32'b0;
        regs[15] <= 32'b0;
        regs[16] <= 32'b0;
        regs[17] <= 32'b0;
        regs[18] <= 32'b0;
        regs[19] <= 32'b0;
        regs[20] <= 32'b0;
        regs[21] <= 32'b0;
        regs[22] <= 32'b0;
        regs[23] <= 32'b0;
        regs[24] <= 32'b0;
        regs[25] <= 32'b0;
        regs[26] <= 32'b0;
        regs[27] <= 32'b0;
        regs[28] <= 32'b0;
        regs[29] <= 32'b0;
        regs[30] <= 32'b0;
        regs[31] <= 32'b0;
    end else begin
        // 如果不是复位状态
        if ((we == `WriteEnable) && (waddr != `RegNumLog2'h0)) begin
            // 如果写使能，且写地址不为 0 号寄存器，写入数据
            regs[waddr] <= wdata;
        end
    end
end

// read port 1
always @(*) begin
    if (rst == `RstEnable) begin
        rdata1 <= `ZeroWord;
    end
    else if (raddr1 == `RegNumLog2'h0) begin
        // 如果复位信号无效，但是需要读 0 号寄存器，则同样返回全零
        rdata1 <= `ZeroWord;
    end
    else if((raddr1 == waddr) && (we== `WriteEnable) && (re1 == `ReadEnable)) begin
        // 如果符合条件，直接将数据送出，因为是非阻塞赋值
        rdata1 <= wdata;
    end
    else if (re1 == `ReadEnable) begin
        // 若读使能，则读取
        rdata1 <= regs[raddr1];
    end
    else begin
        // 否则输出 0
        rdata1 <= `ZeroWord;
    end
end

// read port 2

always @(*) begin
    if (rst == `RstEnable) begin
        rdata2 <= `ZeroWord;
    end
    else if (raddr2 == `RegNumLog2'h0) begin
        // 如果复位信号无效，但是需要读 0 号寄存器，则同样返回全零
        rdata2 <= `ZeroWord;
    end
    else if((raddr2 == waddr) && (we== `WriteEnable) && (re2 == `ReadEnable)) begin
        // 如果符合条件，直接将数据送出，因为是非阻塞赋值
        rdata2 <= wdata;
    end
    else if (re2 == `ReadEnable) begin
        // 若读使能，则读取
        rdata2 <= regs[raddr2];
    end
    else begin
        // 否则输出 0
        rdata2 <= `ZeroWord;
    end
end

// 读寄存器的操作是组合逻辑电路，也就是一旦 raddr1 或 raddr2 发生变化，那么会立即给出新地址对应的寄存器的值

endmodule //
