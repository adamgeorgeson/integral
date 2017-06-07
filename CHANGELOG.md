## NEXT
- Add Image versions - Thumbnail, Small, Medium, Large. The sizes are configurable.
- Add Swiper next and previous buttons to SwiperListRenderer
- Bump Foundation dependancy to ~> 6.3.0
- Enable compression and static cache control by default (added `compress_enabled` config variable to disable)
- Process Post image uploads in the background
- Upgrade carrierwave to 1.1.0 - Includes performance enhancemente. Note: carrierwave_backgrounder should be >=0.4.3
- Lists and List Items are now cachable
- Fix ListItemRenderer to render links which work with TurboLinks
- Fix 404 issue caused by lists which have references to destroyed objects
- Fix 'A copy of ApplicationController has been removed' error which was occurring in development mode.
- Fix accidentally resizing non editor images to editor size limit
- Fix Asset Precompile no longer crashes out when no database is available
- Fix integral image filenaming now defaults to original filename when presented with non parameterizable(?) string
- Lock Parsley to ~> 2.4.4 due to breaking change in 2.7.0

### Breaking Changes
- ```frontend_parent_controller``` config variable now expects a string rather than a Class
- Should `display: none` on swiper next and previous buttons if they are not required
- All existing images need there versions created.
```
Integral::Image.find_each do |image|
  image.file.recreate_versions!
end
```
- Integral.configuration.listable_objects no longer exists. To register an object as listable the model should call acts_as_listable and implement #to_list_item and .listable_options.

## 0.1.5 (March 29, 2017)
- Unsaved changes check now occurs for turbolinks visits and has been added on post and list edit pages
- Toast notifications now fixed positioned (do not scroll out of view)
- Image processing now takes place in the background (not inline)

## 0.1.4 (March 19, 2017)
- Users can now clone lists
- CKeditor no longer filters out icons
- Addition of unsaved changes check when navigating away from webpage when editing or creating a page
- Reload routes after a page is saved (Does not seem to work in production using Heroku)
- Add editor_image_size_limit to configuration
- Add basic breadcrumb to pages
- Add page templates

## 0.1.3 (January 15, 2017)
- Add URL to file inputs (This helps indicate that a file has actually been previously uploaded)
- Add Inviter name to invitation email when available
- Add hidden Integral version to the top of backend layout
- Backend now handles date and time pickers (add `datepicker` or `timepicker` class to the relevant input)
- Moved backend header and side navigation list items into seperate partials to allow for easy overridding
### Fixes
- Correct page URLs are now generated in the page listing
- Authorization fail redirection - now redirects user to backend_dashboard_path rather than root_path
- Include CKEditor Flat skin and extra plugins
### Dependancies
- Temporarily lock CKEditor to 4.2.0 until production asset digesting is fixed

## 0.1.2 (December 17, 2016)
Locked down open ended dependancies

Bugfixes:
  - Host applications now able to use Engines factories

## 0.1.1 (December 13, 2016)

Bugfixes:
  - Fixes WiceGrid filters with Turbolinks 5
Performance:
  - Reduces DB calls when rendering list items with an associated object
