# BJSS

This repository contains the Technical Test specs and page objects as required

<br />

### Running Tests

- Clone Repo: `git@github.com:PaulSouthern/bjss.git`
- Run from root: `bundle exec rspec spec`

#### Test Output

- Terminal: shows spec documentation and failure
- Test Report: `./test_results.html`
- Spec Failure Screenshots: `./tmp/failures`


### Improvements

- Implement helper class to add new item to cart
- Store Product Code to use to locate the element on the checkout page
- Dependencies are spec helper file to avoid calling in spec.  This benefits readability and makes all objects available, however this also means those not required are instantiated.  This could be avoided by instantiating within the Page Object.
- Add rescue wrapper around all expectations at a page object level

### Errors

- Marionette driver issues when interacting with Quick View iFrame. Workaround using alternative `view_item` method.
