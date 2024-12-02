
# Creating a Pipeline to Execute a Shell Script

## Question: Create a pipeline to execute a shell script

- **On Git**
- **On Scripting Task**
- **Monitor Disk Utilization and Send Mail if > 80%**
- **Process Management**

### Step 1: Create the Shell Script for Disk Utilization
- Write a shell script that checks the disk utilization and triggers an alert if the usage exceeds 80%.

### Step 2: Create a Shell Script for Process Management
- Write a script to manage processes on the machine (e.g., stop/start services).

### Step 3: Push the Scripts to a Public Repo on GitHub
- Push both scripts to a GitHub repository so Jenkins can access them.

### Step 4: Create a Jenkins Pipeline

---


### Pipeline Steps:

Since we also need to send mail if disk utilization crosses a threshold, the agent where Jenkins is running should have mail settings configured. Follow the setup steps below:

#### Step 1: Set Up Mail Service
- Configure SMTP in **Manage Jenkins → Configure System → Extended Email Notification** section.
- Example email extension setup:
    - **Subject**: `"Build Success"`
    - **Body**: `"The build was successful."`
    - **To**: `"recipient@example.com"`

#### Step 2: Define the Node to Be Executed On
- Specify the Jenkins node on which the pipeline will run.

#### Step 3: Set Up the Environment Variables (URL and Branch)
- Define the repository URL and branch name in the environment section.

#### Step 4: Define 3 Stages
1. **Cloning Repository**
2. **Monitor Disk Utilization**
3. **Process Management**

#### Step 5: Add a Post Stage for Pipeline Status
- The post stage will display the success or failure status of the pipeline after execution.

---

### Manual Mail Setup on Node (For Command Line Access)

---

### Setting Up Mail Service Locally and Then with Jenkins

#### Step 1: Update Package List and Install Mail Utilities
```bash
sudo apt-get update
sudo apt-get install mailutils
```

#### Step 2: Configuration Box
- Choose **Internet Site** during configuration.

#### Step 3: Set System Mail Name
- Set the system mail name to `ubuntu`.

#### Step 4: Edit Postfix SASL Password
```bash
sudo nano /etc/postfix/sasl_passwd
```

#### Step 5: Add Credentials for SMTP
- Add this line to the `sasl_passwd` file:
  ```
  [smtp.gmail.com]:587    youremail@gmail.com:app_password
  ```

#### Step 6: Set Permissions on `sasl_passwd`
```bash
sudo chmod 600 /etc/postfix/sasl_passwd
```

#### Step 7: Postmap the Password File
```bash
sudo postmap /etc/postfix/sasl_passwd
```

#### Step 8: Modify Postfix Main Configuration
- Edit the main Postfix configuration file:
```bash
sudo nano /etc/postfix/main.cf
```
- Add the following lines:
  - `relayhost = [smtp.gmail.com]:587` (For Gmail SMTP)
  - Enable SASL Authentication:
    ```bash
    smtp_sasl_auth_enable = yes
    smtp_sasl_security_options = noanonymous
    smtp_sasl_password_maps = hash:/etc/postfix/sasl_passwd
    ```

#### Step 9: Reload Postfix
```bash
sudo systemctl reload postfix || sudo systemctl restart postfix
```

#### Step 10: Test the Mail Setup
- Test by sending a test email:
```bash
echo "This is a test email" | mail -s "Test Subject" whoghostrider@gmail.com
```

### Notes:
- After modifying `main.cf`, ensure to run `systemctl reload postfix`.
- To check if there are any stuck emails, navigate to:
```bash
cd /var/mail
mailq
```
