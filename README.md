# Overview

This repo contains the content and images for the Dynatrace Alliance workshops.

Email alliances@dynatrace.com for questions, feedback of you would like to contribute.

# Development

## install prerequisites (mac)

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

Tested with these versions

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

## Global formatting

Key files used to customize the formatting

* `app/views/default/view.json` - home page title and description 
* `app/views/default/index.html` - home page layout
* `app/styles` - style sheets

Key files that control the building

* `gulpfile.js` - controls how the files are built and in what folders
* `app/site.webmanifest` - meta data read by gulpfile.js
* `package.json` defines npm commands 

## Publishing

todo - add instructions

# Reference

* Google codelabs - https://github.com/googlecodelabs/tools
* Other codelab projects
  * https://github.com/dynatrace-perfclinics/codelabs   https://dynatrace-perfclinics.github.io/
  * https://github.com/keptn/tutorials
  * https://github.com/Dynatrace-APAC/dynatrace-apac.github.io/tree/master/workshops
