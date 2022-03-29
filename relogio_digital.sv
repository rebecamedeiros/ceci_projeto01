// Projeto 01 -  Relógio digital
// Nome: Rebeca A. Medeiros
// Matrícula: 11500782	

// As entradas da interface global serão o clock e o reset
// As saídas serão 6 displays de 7 segmentos
module relogio_digital (input clock, input reset,
								output logic [6:0] s_lsd, output logic [6:0] s_msd,
								output logic [6:0] m_lsd, output logic [6:0] m_msd,
								output logic [6:0] h_lsd, output logic [6:0] h_msd);
								

// Instância do divisor de clock
enable_1hz habilitador (
	.enable_clock(clock),
	.enable_reset(reset),
	.enable_pulse_out(enable1hz));

logic [3:0] bcd_s_lsd;
logic [2:0] bcd_s_msd;
logic incrementa_minuto;

// Instância da máquina de estados dos segundos
maq_s maqs_display_s(
	.maqs_clock(clock),
	.maqs_reset(reset),
	.maqs_enable(enable1hz),
	.maqs_lsd(bcd_s_lsd),
	.maqs_msd(bcd_s_msd),
	.maqs_incrementa_minuto(incrementa_minuto));
	
bcd_7seg display_s_lsd(
	.bcd_bcd_in(bcd_s_lsd),
	.bcd_display_out(s_lsd));
	
bcd_7seg display_s_msd(
	.bcd_bcd_in({1'b0, bcd_s_msd}),
	.bcd_display_out(s_msd));


logic [3:0] bcd_m_lsd;
logic [2:0] bcd_m_msd;
logic incrementa_hora;

// Instância da máquina de estados dos minutos
maq_m maqm_display_m(
	.maqm_clock(clock),
	.maqm_reset(reset),
	.maqm_enable(enable1hz),
	.maqm_incrementa_minuto(incrementa_minuto),
	.maqm_lsd(bcd_m__lsd),
	.maqm_msd(bcd_m_msd),
	.maqm_incrementa_hora(incrementa_hora));
	
bcd_7seg display_m_lsd(
	.bcd_bcd_in(bcd_m_lsd),
	.bcd_display_out(m_lsd));
	
bcd_7seg display_m_msd(
	.bcd_bcd_in({1'b0, bcd_m_msd}),
	.bcd_display_out(m_msd));

logic [3:0] bcd_h_lsd;
logic [2:0] bcd_h_msd;

// Instância da máquina de estados da hora
maq_h maqm_display_h(
	.maqh_clock(clock),
	.maqh_reset(reset),
	.maqh_enable(enable1hz),
	.maqh_incrementa(incrementa_hora),
	.maqh_lsd(bcd_h__lsd),
	.maqh_msd(bcd_h_msd));
	
bcd_7seg display_m_lsd(
	.bcd_bcd_in(bcd_h_lsd),
	.bcd_display_out(h_lsd));
	
bcd_7seg display_m_msd(
	.bcd_bcd_in({2'd0, bcd_h_msd}),
	.bcd_display_out(h_msd));
	
endmodule
	
	