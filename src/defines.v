// 全局的宏定义
`define RstEnable       1'b1    // 复位信号有效
`define RstDisable      1'b0
`define ChipEnable      1'b1    // 芯片使能
`define ChipDisable     1'b0
`define WriteEnable     1'b1    // 写使能
`define WriteDisable    1'b0
`define ReadEnable      1'b1    // 读使能
`define ReadDisable     1'b0    
`define AluOpBus        7:0     // 译码阶段的输出 aluop_o 的宽度
`define AluSelBus       2:0     // 译码阶段的输出 alusel_o 的宽度
`define InstValid       1'b0    // 指令有效
`define InstInvalid     1'b1    // 指令无效
`define ZeroWord        32'h0   // 32位的数值0

// 与具体指令有关的宏定义
`define EXE_ORI         6'b001101   // 指令 ori 的指令码
`define EXE_ANDI        6'b001100
`define EXE_XORI        6'b001110
`define EXE_LUI         6'b001111
`define EXE_SPECIAL     6'b000000
`define EXE_PREF        6'b110011

// function code
`define EXE_OR          6'b100101
`define EXE_AND         6'b100100
`define EXE_XOR         6'b100110
`define EXE_NOP         6'b000000   // same as SLL
`define EXE_NOR         6'b100111
`define EXE_SLL         6'b000000
`define EXE_SLLV        6'b000100
`define EXE_SRA         6'b000011
`define EXE_SRAV        6'b000111
`define EXE_SRL         6'b000010
`define EXE_SRLV        6'b000110
`define EXE_SYNC        6'b001111
`define EXE_MOVZ        6'b001010
`define EXE_MOVN        6'b001011
`define EXE_MFHI        6'b010000
`define EXE_MTHI        6'b010001
`define EXE_MFLO        6'b010010
`define EXE_MTLO        6'b010011

// AluOp
`define EXE_OR_OP       8'b00100101
`define EXE_NOP_OP      8'b0
`define EXE_AND_OP      8'b00100100
`define EXE_XOR_OP      8'b00100110
`define EXE_NOR_OP      8'b00100111
`define EXE_SLL_OP      8'b00000100
`define EXE_SRL_OP      8'b00000110
`define EXE_SRA_OP      8'b00000111
`define EXE_MFHI_OP     8'b00010000
`define EXE_MFLO_OP     8'b00010010
`define EXE_MTHI_OP     8'b00010001
`define EXE_MTLO_OP     8'b00010011
`define EXE_MOVZ_OP     8'b00001010
`define EXE_MOVN_OP     8'b00001011
`define EXE_SUB_OP      8'b00001111 // TODO
`define EXE_SUBU_OP     8'b10101010 // TODO
`define EXE_SLT_OP      8'b10101011 // TODO

// AluSel
`define EXE_RES_LOGIC   3'b001
`define EXE_RES_NOP     3'b000
`define EXE_RES_SHIFT   3'b010
`define EXE_RES_MOVE    4'b011

// 与指令存储器 ROM 有关的宏定义
`define InstAddrBus     31:0    // ROM 的地址总线宽度
`define InstBus         31:0    // ROM 的数据总线宽度
`define InstAddrIncrement    4'h4    // PC 自动增加时的大小，这里采用字节寻址
`define InstMemNum      131071      // ROM 的实际大小为 128KB
`define InstMemNumLog2  17          // ROM 实际使用的地址线宽度

// 与通用寄存器 Regfile 有关的宏定义
`define RegAddrBus      4:0     // Regfile 模块的地址线宽度
`define RegBus          31:0    // Regfile 模块的数据先宽度
`define DoubleRegBus    63:0    // 2 * RegBus
`define RegNum          32      // 通用寄存器的数量
`define RegNumLog2      5       // 寻址通用寄存器使用的地址位数，上面的数log2
`define NOPRegAddr      5'b0    // 