hello1
Error: flare.loaders::Flare3DLoader1 class was not found. i got this error

today i started working from home... :-)

itoo started working from home today....

My suggessions:

1.Now a weapon is avaliable with auto firing. We can make it as player definable
2.It would be more interesting if player could rotate it.



//bala

yes kranthi we are planning to rotate gun along with hand while driving..
i'am thinking to stuff like Zombies can also attack hero like throwing sharp nifes rocks ...
Hero should bend to protect from the nifes..


//bala some important and usefull git commands..

git checkout .   (this will reset you uncomminted changes..)

git reset --hard origin/master    (to reset uncommited and commited changes and got back to origin master)


note..
 avoid multiple developers working on same .fla file  (no problem for any other files)..arjun

testing


//Camera for zooming may usefull..check camera class..

if (heroUdata != null)
camera.lookAt(heroUdata, cameraPoint);
private var cameraPoint:Point = new Point(200, 240);
camera = Camera.getInstance(gameContainer);
camera.easing = false;
camera.lockWay = Camera.LOCKWAY_NORMAL;

