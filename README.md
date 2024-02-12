# GitLab Issue Daily Action Report (DAR) Shell Script

This shell script automates the process of creating a Daily Action Report (DAR) in GitLab issues. At our workplace, we utilize GitLab issues to document our daily actions. To streamline this process and save time, I developed a shell script that quickly generates and submits DARs directly from the command line.

## Features

- **Automation:** Save time by automating the process of creating daily action reports in GitLab issues.
- **Customization:** Customize your daily action reports by providing an introductory statement and adding descriptions of your daily actions.
- **Efficiency:** Quickly create and send daily action reports without the need for manual input in the GitLab web application.

## Prerequisites

- Bash shell environment
- GitLab account with access to the project's API
- Curl command-line tool

## How to Use

1. Clone the repository or download the shell script file (`daily_action_report.sh`).
2. Make sure the script file has executable permissions. If not, run `chmod +x daily_action_report.sh`.
3. Open the shell script file (`daily_action_report.sh`) in a text editor and configure the variables according to your GitLab project settings.
4. Run the script by executing `./daily_action_report.sh` in the terminal.
5. Follow the prompts to input necessary details such as project token, project ID, GitLab URL, email addresses, and descriptions of your daily actions.
6. Review and confirm the generated daily action report in GitLab issues.

## Configuration

Before running the script, you need to configure the following variables in the shell script file:

- `project_token`: Your GitLab project's access token.
- `project_id`: ID of your GitLab project.
- `gitlab_url`: URL of your GitLab instance.
- `to`: Email address of the recipient.
- `cc`: Email address of carbon copy recipients.
- `introductory_statement`: Introduction text for your daily action report.

## Notes

- Ensure that you have proper permissions to create issues in the specified GitLab project.
- The script may need adjustments based on your specific GitLab project settings and requirements.


Feel free to adjust or expand upon this README.md file as needed for your project!
