import socket

def get_internal_ip():
    """
    Retrieves the internal IP address of the machine.

    Returns:
        str: The internal IP address, or None if it cannot be determined.
    """
    try:
        # Create a socket object
        # AF_INET specifies the address family (IPv4)
        # SOCK_DGRAM specifies the socket type (UDP)
        s = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)

        # Connect to a public DNS server (Google's) on port 80
        # This doesn't actually send any data, but it helps determine the
        # network interface that would be used to connect to the internet.
        # We use a non-privileged port.
        s.connect(("8.8.8.8", 80))

        # Get the socket's own address (which will be the internal IP)
        internal_ip = s.getsockname()[0]

        return internal_ip
    except socket.error as e:
        # Print an error message if the IP cannot be determined
        print(f"Error: Could not determine IP address - {e}")
        return None
    finally:
        # Ensure the socket is closed
        if 's' in locals() and s:
            s.close()

if __name__ == "__main__":
    # Get the internal IP address
    ip_address = get_internal_ip()

    # Print the IP address if it was successfully retrieved
    if ip_address:
        print(f"Internal IP Address: {ip_address}")
    else:
        print("Failed to retrieve internal IP address.")

