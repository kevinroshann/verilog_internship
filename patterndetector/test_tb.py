import cocotb
from cocotb.triggers import RisingEdge
from cocotb.clock import Clock


@cocotb.test()
async def pattern_detector_test(dut):
    """Simple test for detecting 1101 pattern"""

    # Start the clock
    cocotb.start_soon(Clock(dut.clk, 10, units="ns").start())

    # Reset the DUT
    dut.rst.value = 1
    dut.data_in.value = 0
    await RisingEdge(dut.clk)
    dut.rst.value = 0
    await RisingEdge(dut.clk)

    # Bit stream that includes the pattern "1101" twice
    bit_sequence = [0, 1, 1, 0, 1, 1, 0, 1]

    # Track when detection occurs
    pattern_found = False

    # Feed bits to DUT one by one
    for i, bit in enumerate(bit_sequence):
        dut.data_in.value = bit
        await RisingEdge(dut.clk)

        if dut.detected.value == 1:
            pattern_found = True
            dut._log.info(f"Detected 1101 ending at index {i}")

    # Final check
    assert pattern_found, "Pattern 1101 not detected!"
