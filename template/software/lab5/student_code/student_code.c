/*
 * student_code.c
 *
 *  Created on: Mar 7, 2017
 *      Author: user
 */

#include <system.h>
#include <io.h>
#include "sys/alt_irq.h"
#include "student_code.h"
#include "altera_avalon_pio_regs.h"
#include <stdio.h>

#define LFSR_VAL_BASE 0x80010d0
#define LFSR_CLK_INTERRUPT_GEN_BASE 0x80010e0
#define DDS_INCREMENT_BASE 0x80010c0


#ifdef ALT_ENHANCED_INTERRUPT_API_PRESENT
void handle_lfsr_interrupts(void* context)
#else
void handle_lfsr_interrupts(void* context, alt_u32 id)
#endif
{
	#ifdef LFSR_VAL_BASE
	#ifdef LFSR_CLK_INTERRUPT_GEN_BASE
	#ifdef DDS_INCREMENT_BASE

	// Read the LFSR value
    int lfsr_value = IORD_ALTERA_AVALON_PIO_DATA(LFSR_VAL_BASE);
	// printf("LFSR Value: %u\n", lfsr_value);

    // Check bit 0 of the LFSR value
    if (lfsr_value & 0x1) {
        // If LFSR bit 0 is 1, set DDS to 5 Hz
        IOWR_ALTERA_AVALON_PIO_DATA(DDS_INCREMENT_BASE, 0x1AD);
		// printf("DDS Increment set to 5 Hz (429)\n");
    } else {
        // If LFSR bit 0 is 0, set DDS to 1 Hz
        IOWR_ALTERA_AVALON_PIO_DATA(DDS_INCREMENT_BASE, 0x56);
		// printf("DDS Increment set to 1 Hz (86)\n");
    }

    // Reset the edge capture register
    IOWR_ALTERA_AVALON_PIO_EDGE_CAP(LFSR_CLK_INTERRUPT_GEN_BASE, 0x0);

	// Read the PIO to delay ISR exit
	IORD_ALTERA_AVALON_PIO_EDGE_CAP(LFSR_CLK_INTERRUPT_GEN_BASE);
	
	#endif
	#endif
	#endif
}

/* Initialize the button_pio. */

void init_lfsr_interrupt()
{
	#ifdef LFSR_VAL_BASE
	#ifdef LFSR_CLK_INTERRUPT_GEN_BASE
	#ifdef DDS_INCREMENT_BASE
	
	/* Enable interrupts */
	IOWR_ALTERA_AVALON_PIO_IRQ_MASK(LFSR_CLK_INTERRUPT_GEN_BASE, 0x1);
	/* Reset the edge capture register. */
	IOWR_ALTERA_AVALON_PIO_EDGE_CAP(LFSR_CLK_INTERRUPT_GEN_BASE, 0x0);
	/* Register the interrupt handler. */
#ifdef ALT_ENHANCED_INTERRUPT_API_PRESENT
	alt_ic_isr_register(LFSR_CLK_INTERRUPT_GEN_IRQ_INTERRUPT_CONTROLLER_ID, LFSR_CLK_INTERRUPT_GEN_IRQ, handle_lfsr_interrupts, 0x0, 0x0);
#else
	alt_irq_register( LFSR_CLK_INTERRUPT_GEN_IRQ, NULL,	handle_button_interrupts);
#endif

	// printf("Hello\n");
	
	#endif
	#endif
	#endif
}

