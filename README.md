# Introduction 
This tool allows a team to implement the **GitFlow** methodology for branch management along with code review practices enforce by the usage of *pull requests*. 

Since the *pull requests* are not a native **git** feature, we rely on **Azure DevOps** or **Team Foundation Server** to handle them. Also, please consider this tool only works on **Windows** operative system.

If you want to learn more about the **GitFlow** methodology, you can follow [this link](https://nvie.com/posts/a-successful-git-branching-model/).

# Prerequisites
The use of this toolset asumes you have completed the below steps:
1. Install the latest [VSTS CLI](https://docs.microsoft.com/en-us/cli/vsts/install?view=vsts-cli-latest)
2. Create a [personal access token](https://docs.microsoft.com/en-us/azure/devops/organizations/accounts/use-personal-access-tokens-to-authenticate?view=azure-devops)
3. Setup your [credentials](https://docs.microsoft.com/en-us/cli/vsts/authenticate?view=vsts-cli-latest) on VSTS CLI
4. Execute this command `vsts configure --use-git-aliases yes`

# Installation
1. Clone the repository
2. Move to the repo's main directory
3. Run `install.bat`


# Usage

## Repository initialization

To configure a repository to use this tool, you need to execute any of the below commands, this should be done only once per repository.
```console
git flow.init
git fi
```


## Feature Branches

You can create a new feature branch by running any of the below commands:
```console
git flow.feature.start <feature-name>
git ffs <feature-name>
```

You can publish a feature branch to `develop` by running any of the below commands on a checked out feature branch, which will create a *pull request* on the server:
```console
git flow.feature.publish
git ffp
```


## Hotfix Branches

You can create a new hotfix branch by running any of the below commands:
```console
git flow.hotfix.start <hotfix-name>
git fhs <hotfix-name>
```

You can publish a hotfix branch to `develop` and `master` by running any of the below commands on a checked out hotfix branch, which will create two *pull request* on the server:
```console
git flow.hotfix.publish
git fhp
```


## Release Branches

You can create a new release branch by running any of the below commands:
```console
git flow.release.start <release-name>
git frs <release-name>
```

You can publish a release branch to `develop` and `master` by running any of the below commands on a checked out release branch, which will create two *pull request* on the server:
```console
git flow.release.publish
git frp
```

In cases when you're certain that no modifications are needed before the release, you can perform the two above actions at the same time by running any of the below commands:
```console
git flow.release.all <release-name>
git fra <release-name>
```

## Other utilities

When you want to do a local cleanup and remove all the branches already merged to `develop` and `master`, you can run the below command:
```console
git general.clean
```