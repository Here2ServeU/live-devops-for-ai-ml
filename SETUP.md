# Set up your lab: DevOps for AI-ML Systems

When you finish, you will have a Linux terminal with Git, Python 3 and Docker, the lab files unpacked, and a quick test passing for each of Modules 1 to 3. Plan on about 15 to 20 minutes, once (less in Codespaces).

## What you need
- A Linux terminal. Pick one in Step 1: GitHub Codespaces (browser), WSL Ubuntu (Windows) or a Multipass Ubuntu VM (Mac). Any Ubuntu 22.04 or newer works.
- About 5 GB of free disk space (Docker plus the Python base image; more if you create a VM).
- A free GitHub account (for Codespaces, and for pushing the pipeline in Module 3).
- Git, Python 3 (standard library only, nothing to `pip install`) and Docker.
- Docker is needed from Module 2. Set it up now so you only do it once.
- No GPU needed. No API keys needed. (The `.env` token in Module 2 is a fake one the lab makes for you.)

## Step 1 · Pick where to run it

### Option A: GitHub Codespaces (easiest, any computer)
Python and Docker are already inside.
1. Sign in to GitHub and open this repo.
2. Click **Code > Codespaces > Create codespace**.
3. Wait for the editor and the terminal at the bottom to open. Skip to Step 2.

### Option B: Windows (WSL Ubuntu)
1. Open PowerShell and install Ubuntu, then restart if asked:
```powershell
wsl --install -d Ubuntu-24.04
```
2. Open **Ubuntu** from the Start menu and install the tools:
```bash
sudo apt update
sudo apt install -y git python3 docker.io unzip
sudo usermod -aG docker $USER
```
3. Close the Ubuntu window and open a new one, so the Docker group change takes effect.

### Option C: Mac (Multipass Ubuntu VM)
1. Install Multipass (see https://canonical.com/multipass/install, or with Homebrew):
```bash
brew install --cask multipass
multipass launch 24.04 --name ailab
multipass shell ailab
```
2. Inside the VM, run the same lines as Option B, step 2. Then type `exit` and `multipass shell ailab` again.

### Everyone: tell Git who you are
```bash
git config --global user.name "Your Name"
git config --global user.email "you@example.com"
```

## Step 2 · Get the lab files
Download [devops-for-ai-ml-lab.zip](downloads/devops-for-ai-ml-lab.zip) from this repo and copy it into your Linux home folder:
- **Codespaces:** it is already in `downloads/`. Run `cp downloads/devops-for-ai-ml-lab.zip ~`
- **WSL:** `cp /mnt/c/Users/<your-windows-name>/Downloads/devops-for-ai-ml-lab.zip ~`
- **Multipass (on your Mac):** `multipass transfer ~/Downloads/devops-for-ai-ml-lab.zip ailab:/home/ubuntu/`

Then unzip it and step in:
```bash
cd ~
unzip devops-for-ai-ml-lab.zip
cd ~/devops-for-ai-ml
```

## Step 3 · Install and check
There is nothing to `pip install`. Just run the doctor from the lab folder:
```bash
cd ~/devops-for-ai-ml
bash setup/doctor.sh
```
You should see:
```
  [ OK ]  Linux 6.x...
  [ OK ]  git version 2.x.x
  [ OK ]  Python 3.12.x
  [ OK ]  Docker 2x.x.x
  [ OK ]  git user: Your Name
---------------------------------
Module 1 needs git + python3. Modules 2-3 also need Docker.
```
Module 1 needs only the first three lines. The Docker line must say `[ OK ]` before Module 2.

## Step 4 · Quick test for each module
Each `start.sh` builds a practice project in `~/ticket-triage` for that module. Run them from `~/devops-for-ai-ml`.

**Module 1 · Ship the Model Like Code**
```bash
cd ~/devops-for-ai-ml && bash modules/module-1/start.sh
cd ~/ticket-triage && python3 src/train.py
```
You should see `Ready: ... (one commit, seed NOT pinned yet)`, then `WARNING seed is not pinned`, an accuracy line and a `model sha256` fingerprint. Run `train.py` again: the fingerprint changes. That is the lesson.

**Module 2 · Pack It Once** (needs Docker)
```bash
cd ~/devops-for-ai-ml && bash modules/module-2/start.sh
cd ~/ticket-triage
TAG=$(git rev-parse --short HEAD) && docker build -t ticket-triage:$TAG .
docker run -d -p 8080:8080 --name triage ticket-triage:$TAG
curl -s localhost:8080/health
```
You should see `Ready: ... (seed pinned, model trained, a .env secret present)`, then `{"status": "ok", "model": "...", ...}`. The first build downloads `python:3.12-slim` and takes a minute. Clean up with `docker rm -f triage`.

**Module 3 · No Green, No Ship**
```bash
cd ~/devops-for-ai-ml && bash modules/module-3/start.sh
cd ~/ticket-triage && bash pipeline.sh
```
You should see four steps (TEST, TRAIN, GATE, BUILD), `GATE PASS  accuracy 92.9% >= bar 85%`, and finally `PIPELINE GREEN - this model can ship.`

## If something goes wrong
- **Doctor says `Not Linux`.** You are in Mac Terminal or Windows PowerShell. Use Codespaces, WSL or the Multipass VM from Step 1.
- **Doctor says `Docker installed but not usable`.** Add yourself to the docker group, then open a new terminal:
  ```bash
  sudo usermod -aG docker $USER
  ```
- **Docker is not running on WSL.** Start the service, then run the doctor again:
  ```bash
  sudo service docker start
  ```
- **Doctor says `Set your git name`.** Run the two `git config --global` lines from Step 1.
- **`docker run` says the name `triage` or port 8080 is already in use.** Remove the old container: `docker rm -f triage`
- **The practice project got messy.** Rebuild it from scratch: `bash modules/module-2/start.sh --reset` (or the same for module-3).
- **Still stuck after 15 minutes?** Switch to Codespaces (Option A). Nothing to install.

## Official guides
- GitHub Codespaces: https://docs.github.com/codespaces
- Install WSL: https://learn.microsoft.com/windows/wsl/install
- Install Multipass: https://canonical.com/multipass/install
- Get Docker: https://docs.docker.com/get-docker/
