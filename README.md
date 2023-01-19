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
		"preinstall": "if [ ! -d ../../plugsier-scripts ]; then git clone https://github.com/plugsier/plugsier-scripts ../../plugsier-scripts; else cd ../../plugsier-scripts && git reset --hard && git checkout main && git pull origin main;fi;",
		"dev": "cd ../../plugsier-scripts/docker; sh run.sh -p $OLDPWD -n '0' -c 'sh dev.sh -n YourPluginNamespace -t your-plugin-textdomain';",
		"build": "cd ../../plugsier-scripts/docker; sh run.sh -p $OLDPWD -n '0' -c 'sh build.sh -n YourPluginNamespace -t your-plugin-textdomain';",
		"test:phpunit": "cd ../../plugsier-scripts/docker; sh run.sh -p $OLDPWD -n '0' -c 'sh phpunit.sh -n YourPluginNamespace -t your-plugin-textdomain';",
		"lint:php": "cd ../../plugsier-scripts/docker; sh run.sh -p $OLDPWD -n '0' -c 'sh phpcs.sh -n YourPluginNamespace -t your-plugin-textdomain';",
		"lint:php:fix": "cd ../../plugsier-scripts/docker; sh run.sh -p $OLDPWD -n '0' -c 'sh phpcs.sh -n YourPluginNamespace -t your-plugin-textdomain -f 1';",
		"lint:js": "cd ../../plugsier-scripts/docker; sh run.sh -p $OLDPWD -n '1' -c 'sh lint-js.sh -n YourPluginNamespace -t your-plugin-textdomain';",
		"lint:js:fix": "cd ../../plugsier-scripts/docker; sh run.sh -p $OLDPWD -n '1' -c 'sh lint-js.sh -f 1 -n YourPluginNamespace -t your-plugin-textdomain';",
		"lint:css": "cd ../../plugsier-scripts/docker; sh run.sh -p $OLDPWD -n '0' -c 'sh lint-css.sh -n YourPluginNamespace -t your-plugin-textdomain';",
		"lint:css:fix": "cd ../../plugsier-scripts/docker; sh run.sh -p $OLDPWD -n '0' -c 'sh lint-css.sh -f 1 -n YourPluginNamespace -t your-plugin-textdomain';",
		"test:js": "cd ../../plugsier-scripts/docker; sh run.sh -p $OLDPWD -n '1' -c 'sh test-js.sh -n YourPluginNamespace -t your-plugin-textdomain';",
		"zip": "cd ../../plugsier-scripts/docker; sh run.sh -p $OLDPWD -n '0' -c 'sh zip.sh -n YourPluginNamespace -t your-plugin-textdomain';"
	}
}
```

In the example package.json file above, simply replace these strings:

- `your-plugin-name` - A slug for your plugin
- `your-plugin-directory-name` - The name of your plugins directory (Used to tell plugsier-scripts which plugin to lint/test)
- `YourPluginNamespace` - The unique namespace used for your plugin (Will be enforced as function/class prefix in WordPress Coding Standards)
- `your-plugin-textdomain` - The text domain to use for your plugin (Will be enforced by WordPress Coding Standards)

Then inside your plugin, run `npm run install`. This will clone this repo inside your local wp-content directory, and make the commands like `npm run lint:php` work on the command line when inside the plugin's directory.