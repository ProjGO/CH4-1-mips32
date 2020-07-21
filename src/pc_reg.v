`include "defines.v"


module pc_reg(
         input wire clk, wire rst,
         input wire stall, // From CTRL mudule

         // 已经成功收到 pc，可以更新 pc 了
         input wire pc_read_ready,

         // 来自译码阶段的 ID 模块的信息,
         input wire branch_flag_i,
         input wire[`RegBus] branch_target_address_i,

         // 异常处理
         // 流水线清除信号
         input wire flush,
         // 异常处理例程入口地址
         input wire[`RegBus] new_pc,

         output reg[`InstAddrBus] pc,
         output reg ce
       );
// reg valid_pc;

always @ (posedge clk)
  begin
    // about ce
    if (rst == `RstEnable)
      begin
        // 复位的时候指令存储器禁用
        ce <= `ChipDisable; // 非阻塞赋值会在整个语句结束时才会完成赋值操作，不是立刻改变
        // valid_pc <= `Valid;
      end
    else
      begin
        // 复位结束后，指令存储器使能
        ce <= `ChipEnable;
      end
  end

reg branch_flag;
reg[`RegBus] branch_target_address;

// 存储每次收到的 branch
always @(posedge clk )
  begin
    if (rst == `RstEnable || flush)
      begin
        branch_flag <= 1'b0;
        branch_target_address <= `ZeroWord;
      end
    else if (pc_read_ready == `Ready)
      begin
        branch_flag <= 1'b0;
        branch_target_address <= `ZeroWord;
      end
    else if (branch_flag_i == 1'b1)
      begin
        branch_flag <= 1'b1;
        branch_target_address <= branch_target_address_i;
      end
    else
      begin

      end
  end

// always @(posedge clk)
//   begin
//     if (valid_pc == `Valid && ce== `ChipEnable && pc_read_ready == `Ready )
//       begin
//         valid_pc <= `InValid;
//       end
//   end

// reg flushed;


// // flush 以后，丢弃了最新收到的 pc_read_ready(也就是这一次不会直接增加)
// always @(posedge clk)
//   begin
//     if (rst == `RstEnable)
//       flushed <= 1'b0;
//     else if (flush  == 1'b1)
//       flushed <= 1'b1;
//     else if (pc_read_ready == `Ready)
//       flushed <= 1'b0;
//     else
//       begin

//       end
//   end

always @(posedge clk)
  begin
    // about pc
    // FIXED: 如果使用 (rst == `Disable)，
    // 会导致 pc 与 ir 总是表示同一个地址
    // 而在这里使用 ce 和 非阻塞复制，就是为了产生一个周期的延迟效果。
    // 因为这一个 always 的判断条件，依赖于上一个时钟周期结束时的赋值结果
    if (ce == `ChipDisable)
      begin
        // 如同手册里所写
        pc <= 32'hbfc00000;
      end
    else if(flush == 1'b1)
      begin
        // 输入信号 flush 为 1 表示发生异常，将从 CTRL 模块给出的异常处理
        // 例程入口地址 new_pc 处取指执行
        pc <= new_pc;
        // valid_pc <= `Valid;
      end
    else if(pc_read_ready == `Ready)
      begin
        if(branch_flag == `Branch)
          begin
            pc <= branch_target_address;
          end
        else
          begin
            //  按照字节寻址
            pc <= pc + `InstAddrIncrement;
          end
        // valid_pc <= `Valid;
      end
    // if stall, then pc remain the same
  end

endmodule // pc_reg
