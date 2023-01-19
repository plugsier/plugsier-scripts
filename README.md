# Plugsier Scripts.

Add phpunit, eslint, and stylelint using WordPress Coding Standards to any WordPress plugin by setting up your package.json file like this:

## Your package.json file in your plugin.
```
{
	"name": "your-plugin-name",
	"version": "1.0.0",
	"license": "GPL-2.0",
	"repository": {
		"type": "git",
		"url": "your-repo-url-here"
	},
	"plugsier_options": "-n YourPluginNamespace -t your-plugin-textdomain",
	"scripts": {
		"preinstall": "cd ../../; if [ ! -d plugsier-scripts ]; then git clone https://github.com/plugsier/plugsier-scripts plugsier-scripts; fi; cd plugsier-scripts; git checkout main; git pull origin main;",
		"dev": "cd ../../plugsier-scripts; sh dev.sh $npm_package_plugsier_options",
		"build": "cd ../../plugsier-scripts; sh build.sh $npm_package_plugsier_options",
		"test:phpunit": "cd ../../plugsier-scripts; sh phpunit.sh $npm_package_plugsier_options;",
		"lint:php": "cd ../../plugsier-scripts; sh run.sh -p $OLDPWD -i 0 -c "sh phpcs.sh $npm_package_plugsier_options;",
		"lint:php:fix": "cd ../../plugsier-scripts; sh phpcs.sh $npm_package_plugsier_options -f 1;",
		"lint:js": "cd ../../plugsier-scripts; sh lint-js.sh $npm_package_plugsier_options",
		"lint:js:fix": "cd ../../plugsier-scripts; sh lint-js.sh $npm_package_plugsier_options -f 1;",
		"lint:css": "cd ../../plugsier-scripts; sh lint-css.sh $npm_package_plugsier_options;",
		"lint:css:fix": "cd ../../plugsier-scripts; sh lint-css.sh $npm_package_plugsier_options -f 1;",
		"test:js": "cd ../../plugsier-scripts; sh test-js.sh $npm_package_plugsier_options;",
		"zip": "cd ../../plugsier-scripts; sh zip.sh $npm_package_plugsier_options"
	}
}

```

In the example package.json file above, simply replace these strings:

- `your-plugin-name` - A slug for your plugin
- `your-plugin-directory-name` - The name of your plugins directory (Used to tell plugsier-scripts which plugin to lint/test)
- `YourPluginNamespace` - The unique namespace used for your plugin (Will be enforced as function/class prefix in WordPress Coding Standards)
- `your-plugin-textdomain` - The text domain to use for your plugin (Will be enforced by WordPress Coding Standards)

Then inside your plugin, run `npm run install`. This will clone this repo inside your local wp-content directory, and make the commands like `npm run lint:php` work on the command line when inside the plugin's directory.