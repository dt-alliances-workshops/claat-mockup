# Contributing to Workshops

We encourage Dynatrace subject matter experts to contribute to update content and add new workshop labs. 

These workshops are build on the [Google codelabs](https://github.com/googlecodelabs/tools) tooling build with node.  Below are the prerequisites and installation instructions.

The compiled workshop guides can be run and tested on a laptop and then upon request to the Dynatrace alliances team the content will be published to a public website.

## How to contribute

The easiest way to start contributing or helping with workshop content is to pick an existing issue/bug and get to work using the guides below.

For proposing a change, we seek to discuss potential changes in GitHub issues in advance before implementation. That will allow us to give design feedback up front and set expectations about the scope of the change, and, for larger changes, how best to approach the work such that the Dynatrace Tech Alliances team can review it and merge it along with other concurrent work. This allows to be respectful of the time of community contributors.

The repo follows a rather standard branching & PR workflow.

Branches naming follows the `feature/{Issue}/{description}` or `bugfix/{Issue}/{description}` pattern.

Commits are not auto-squashed when merging a PR, so please make sure your commits are fit to go into main (DIY squash when necessary).

# Adding or Updating Workshops

Reference this [format guide](https://towardsdatascience.com/cheat-sheet-for-google-colab-63853778c093) as you add content. 

## Prerequisites (mac)

Below are instructions for installing the required tools to run, author and test workshop content on your laptop.

```
# install node
brew update
brew install node@14
echo 'export PATH="/usr/local/opt/node@14/bin:$PATH"' >> ~/.bash_profile

# install go
brew update
brew install golang
go get github.com/googlecodelabs/tools/claat

# clone repo
git clone git@github.com:dt-alliances-workshops/claat-mockup.git

# install required npm packages
cd claat-mockup
npm install
npm install postcss
npm install -g gulp-cli
```

This repo was tested with these versions:

```
go version
  go1.17.5 darwin/amd64
node -v
  v14.18.2
npm -v
  6.14.15
gulp --version
  CLI version: 2.3.0
  Local version: 4.0.2
```

## Run locally

Use this command to build content and run a Webserver started at http://localhost:8000 

```
npm run serve
``` 

## Add New workshop

todo - add instructions

## Add a new lab to an existing workshop

todo - add instructions

## How to adjust global formatting

Key files used to customize the formatting

* `app/views/default/view.json` - home page title and description 
* `app/views/default/index.html` - home page layout
* `app/styles` - style sheets

Key files that control the building

* `gulpfile.js` - controls how the files are built and in what folders
* `app/site.webmanifest` - meta data read by gulpfile.js
* `package.json` defines npm commands 

## How to publish workshop

todo - add instructions

# Codelab references

* Other codelab projects
  * https://github.com/dynatrace-perfclinics/codelabs   
  * https://dynatrace-perfclinics.github.io/
  * https://github.com/keptn/tutorials
  * https://github.com/Dynatrace-APAC/dynatrace-apac.github.io/tree/master/workshops
