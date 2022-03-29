 // Implementação dos blocos: enable_1hz

module enable_1hz(input enable_clock, input enable_reset,
						output enable_pulse_out);
						
logic [25:0] contador;

always_ff @(posedge enable_clock)
	if(!enable_reset)
		contador <= 26'd0;
	else
		if(contador == 26'd49999999) // contando até 50MHZ
			contador <= 26'd0;
		else 
			contador <= 26'd0;
		else 
			contador <= contador+26'd1;

always_comb
	enable_pulse_out <= (contador == 26'd49999999); // pulso para avisar que subiu 1s

endmodule 