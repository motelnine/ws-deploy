# Download and add the Kali repository key directly to the trusted.gpg.d directory
wget -q -O - https://archive.kali.org/archive-key.asc | gpg --dearmor | sudo tee /etc/apt/trusted.gpg.d/kali-archive-keyring.gpg > /dev/null

# Update and install the keyring package
sudo apt update && sudo apt install -y kali-archive-keyring
