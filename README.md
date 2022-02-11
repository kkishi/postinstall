# Usage

Install Ubuntu 20.04 ordinarily. Boot, log-in and open the terminal. Run:

```bash
./postinstall.sh
sudo remote_su.sh
remote.sh
```

# Testing the scripts

It is convenient to test the scripts with a VM because you can rollback easily. Set up a VM instance and take a snapshot. Then, in the host machine, run:

```bash
./run_remote.sh $guest_address
```
