`timescale 1ns/1ps

module tb_top_module();
    reg clk;
    reg reset;
    reg data;
    reg ack;
    wire [3:0] count;
    wire counting;
    wire done;

    // Instantiate the Unit Under Test (UUT)
    top_module uut (
        .clk(clk),
        .reset(reset),
        .data(data),
        .count(count),
        .counting(counting),
        .done(done),
        .ack(ack)
    );

    // Clock generation (100MHz)
    always #5 clk = ~clk;

    initial begin
        // Initialize Inputs
        clk = 0;
        reset = 1;
        data = 0;
        ack = 0;

        // Reset the system
        #20 reset = 0;

        // 1. Send Sequence 1101
        send_bit(1); send_bit(1); send_bit(0); send_bit(1);

        // 2. Send Delay bits (4'b0001 -> Delay = 1)
        // Total cycles should be (1+1)*1000 = 2000 cycles
        send_bit(0); send_bit(0); send_bit(0); send_bit(1);

        // 3. Wait for Counting to start
        wait(counting);
        $display("Started counting at time %t", $time);

        // 4. Wait for Done to be asserted
        wait(done);
        $display("Finished counting at time %t", $time);

        // 5. Acknowledge the timer
        #20 ack = 1;
        #10 ack = 0;

        #100 $finish;
    end

    // Task to send a single bit synchronized to the clock
    task send_bit(input b);
        begin
            data = b;
            @(posedge clk);
            #1; // Small hold time
        end
    endtask

endmodule
