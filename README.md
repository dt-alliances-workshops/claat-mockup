# claat-mockup

## Commands

* Run locally `npm run serve`
* Build distribution `npm run build`
* Build distribution and run locally `npm run serve:dist`

## Reference

* Google codelabs - https://github.com/googlecodelabs/tools
* Other codelab projects
  * https://github.com/dynatrace-perfclinics/codelabs   https://dynatrace-perfclinics.github.io/
  * https://github.com/keptn/tutorials
* structure of MD files and header - https://github.com/Dynatrace-APAC/dynatrace-apac.github.io/tree/master/workshops

## installation (mac)

```
brew update
brew install node@14
echo 'export PATH="/usr/local/opt/node@14/bin:$PATH"' >> ~/.bash_profile

brew update
brew install golang
go get github.com/googlecodelabs/tools/claat

git clone git@github.com:dynatrace-perfclinics/codelabs.git
cd codelabs
npm install
npm install postcss
npm install -g gulp-cli
```

What I have as versions

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

## Development notes

There are files use to customize the setup
* `gulpfile.js`
* `app/site.webmanifest`
* `app/views/default/index.html` 
* `app/views/default/view.json` 
* `app/styles`