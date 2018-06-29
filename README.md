# spacedeck-cloudron
Cloudron packaging for spacedeck whiteboard

This project is a packaging of [spacedeck whiteboard application](https://github.com/spacedeck/spacedeck-open)
for the [Cloudron](https://cloudron.io) platform.

This not an official Cloudron package yet, because it's not mature enough. In particular, there should be
an integration with Cloudron user system, and the Spacedeck app should have some essential features that are
still not implemented:

 * Email sending.
 * Users able to change password and delete accoount.

Also file uploading and deleting objects are not working.

## How to build and install into an existing Cloudron instance

 1. Install the Cloudron CLI tool, as explained in the [packaging manual](https://cloudron.io/developer/packaging/).
 2. `cloudron login` to your instance.
 3. `cloudron build` (you will need a cloudron.io account).
 4. `cloudron install`

