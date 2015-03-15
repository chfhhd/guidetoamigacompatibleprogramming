# APPENDIX B: Subversion on Amiga

*"And given how Amiga software looks today, it appears to me that not
everyone who should have read this book really did know."*
Olaf Barthel about the book "The User Interface Style Guide", 26/11/1996 comp.sys.amiga.programmer

*"It's really high time the RKMs are taken care of."*
Olaf Barthel comp.sys.amiga.programmer 12/09/1997


## B.1 Introduction

Subversion is a set of programs that allows different
developers to work simultaneously with one or more files.
Using Subversion is also recommended in projects where
working as a single person, because the use of these programs
involves a number of advantages:

- The ability to edit any file in real time anywhere;

- The ability to maintain different versions on synchronized
   different machines automatically and without bothering to copy from 
   one machine to another, the latest version;
- The possibility of returning to earlier revisions of their work
   at any time, instead of going crazy trying to remember what changes
   were made from some period onwards;

We can therefore define Subversion as a set of programs for
clean and transparent management of its work.

The interaction between different users within the same project is
through a main server, which receives project files
with whom they are collaborating. A user downloads onto their computer
a file copy of the project in which they are interested in, making
their changes and then sends them to the main server, Subversion
will then integrate them properly with the version of
project resident on the server.


## B.2 What is a repository

Subversion is a system for sharing information that works
using a data store, in the jargon "repository". Repository
stores information hierarchically, being used as our
computer files and directories. One or more computers can
connect to the repository and read or write these files. Obviously
the repository is located on a remote server.


## B.3 What is a review

One of the concepts that underpins the functioning of Subversion is that
of revision. Suppose we have on our Amiga a
text file, pippo_r0.txt, and then go and edit, then save the
edited file with another name, for example pippo_r1.txt. We will in
this situation have two files, separate from the fact that the second
represents a modernized version of the first. File pippo_r0.txt
0 we can define the revision of our files, while pippo_r1.txt
is identifiable as the revision 1 of the same file.
A review is therefore a copy, or rather a "snapshot" (snapshots)
than one file at a given moment of its existence. Each
time we send successfully a change to the files of a project
managed on a server to Subversion, the repository will be responsible for
creating a revision of the file before our changes, so
that allow us to recover any of the work done before
accidental loss. This is one of the strengths of projects
using Subversion: the ability to recover any data
when a review of one or more files of a project without tasking
our computer to manage different copies manually.
As mentioned, those who perform the operations and maintenance control
revisions in the repository, which remembers every change
has been made in it: it will consider any change
made to every file and directory.
When a computer reads the data from the repository, normally seeing only
the latest revision of the directory tree. In reality, it also has the 
chance to see a previous review of the tree
directory.


## B.4 Collaborate in projects that use Subversion

To collaborate on a project that uses Subversion you
only have to have an account on the server that hosts the project and
the Subversion package installed on your Amiga. Usually
all of these programs are on Aminet, os4depot and other sites
of this kind.


## B.5 Command SVN

The suite contains a number of Subversion commands to be given
to the Shell, SVN is one of the main.
The SVN command controls most of the actions
used to collaborate in a project already started.
Of particular relevance is the version of svn and the server with which you
interact. More specifically, some new servers, such as code.google.com,
require identification through SSL, which is supported in
the Amiga version 1.7 of Subversion (a port of version 1.1.4),
So if you have a version earlier than 1.7 you cannot access
projects that reside on this server from your Amiga.
As mentioned, the command svn allows enough interaction to
complete existing projects, using appropriate
options among those offered by this command. Options used
most frequently are:

- Checkout (or co): allows you to download to your harddisk all
                    files of a project;
- Diff: shows the differences between the local review
                    (harddisks) and the Journal of the repository;
- Update (or up): upgrade to the latest revision of a file copying
                    project on your harddisk;
- Resolved: alerts the server that we have eliminated the possible
                    conflicts that were present in our local copy
                    that prevented it to send / integrate their
                    resident version on the repository design changes;
- Revert: allows you to restore one or more local files
                    replacing them with the files on the repository;
- Add: shows which new files will be added to
                    project's repository;
- Delete: indicates which files will be removed from a
                    project's repository;
- Commit: send your changes to the repository that
                    will deal with integrity;


### B.5.1 Checkout, download the source code of a project

As we mentioned, the projects managed with Subversion reside on
a server that supports this suite of programs. Among the most popular server
we have those provided by portals and sourceforge.net, code.google.com,
The first accepts and agrees for most software projects, while the second
also hosts projects which are not necessarily the sources of software,
but also documentation and guides works.

Suppose we want to collaborate on a project that resides on
sourceforge portal, for example NoWinED. The web page of
this project is:

	http://sourceforge.net/projects/nowined/

This page has a series of choices to be made by the browser, including
at the top is the link to "Code". This link leads to a javascript menu
on which are listed, among other items, SVN and SVN
Browser. The second is simply a way to see parts
of the code that make up the project directly from the browser, while
The first link is what we are concerned with. After selecting
SVN link from the site, we will enter a page that displays another link
immediately preceded by the svn command. This string is what you type
subsequently in our Shell.
Attention, followed by the svn co will create the directory inside
the current one in which the Shell is a directory containing all files
the project is accessing, then before you type svn the 
Shell must position themselves exactly to the location where we want
this directory to be created.
Then write in the Shell:

	svn co https://nowined.svn.sourceforge.net/svnroot/nowined nowined

After typing this command the program will download from the svn site
all the files needed to create a working copy of the draft in which we
participate, in our case, all files will be included in a
directory named nowined.

We have therefore introduced a first parameter of the command svn co, or
also checkout, which would serve to download from a repository
all the files that make up a project, automatically creating
all the necessary directories.

Typically the files that we are interested in are in the
program directory / trunk /. Each project obviously has it's 
own directory structure within the trunk, for example
NoWinED currently has two directories inside trunk.

Svn The command also creates in each directory private subdirectories that "monitor"
further, called. "svn". Just keep in mind that the directories by name. "Svn"
are for Subversion to perform their duties and should not be
modified or deleted.


### B.5.2 Diff, preview of the differences between local files and Review the repository

After changing one or more files of a project, before sending the
repository your changes, you may feel the need to
view from a global point of view all of the changes
you've made to the project. To achieve this the program
svn can generate an output that displays all of our changes
compared to the last revision of the project on the server.
 
Also, usually every project has the person which needs to review
before sending your changes first. Such persons
may require you to analyze your changes before
eventual integration with the project.

To get a file containing the changes we have made
simply type in the Shell, placed in the directory
where you downloaded the project with svn:

	svn diff > RAM: diff.txt

In this way we will get in RAM: the file that will contain what diff.txt
we need to reassure operators of the project which we
want to cooperate.

The output has a similar option diff syntax:

	Index: file2
	==================================================
	--- File2 (revision 46)
	+ + + File2 (working copy)
	@ @ @ @ -1.7 +1.12

	 
	- LINE REMOVED
	+ LINE ADDITION
 
lines erased than copying the repository are preceded by
a -, while the added lines are preceded by a +.


## B.5.3 Update, update their local files to the latest version

And 'good practice, prior to submission of amendments to
main server, synchronize the files on your computer with
those residing in the official repository of the project in which we're
cooperating. The upgrade could save any estimate of 
problems of incompatibility between local files and those on the repository and
above all else allows you to verify whether your changes are or not
compatible with the latest version of the project we're working.
To update our working copy with the one on the repository
Just place go in the Shell to the directory that contains the
project files we're working together and write:

	svn update

or:

	svn up

Option update (and up) allows you then to download files more
updated by the server that maintains the official version of the project
in which we cooperate. Subversion will synchronize all
files if everything went through.
If we wanted to retrieve from the server instead a particular revision
of one or more files we should type:

	svn up-r numeroRevisione

In this way we could retrieve such a file we accidentally overwrote on 
the same repository so as to restore any changes we made several revisions 
before and lost in the most recent revisions


B.5.4 Revert, resolve conflicts

A common enough occurrence when working on a project with
Subversion is the possibility of incurring conflicts. Conflict
occurs when a file has been modified locally, which in turn is
changed even in its official version on the repository.
Svn command during the update procedure warns us of
conflicts through a particular symbology. If for
example, we have updated three files to the repository, two of which
were also modified locally we have a situation
Similarly, displayed as output to Shell:

	:> svn update
	U file1
	G file2
	C file3
	Updated to revision 46.


We can see three codes output: U, G and C. U indicates that the files
Rooms have been updated successfully, G indicates that the changes
sent to the server have been successfully integrated with our modifications
while C indicates that there was a conflict to be resolved manually
before attempting to submit the changes to the repository.
Subversion behaves differently depending on the nature of the conflict
met.

In the case of minor changes, Subversion might consider such
integration changes of the official version on the repository easily,
For this purpose the program puts markers of conflict, which
are simply special strings of text that surround the
"extreme" of the problem within the file. Thus Subversion
makes visible the changes of problems that can be integrated.
In other words we will charged within a situation
this:

	<<<<<<<. Landmines
	Our changes
	=======
	OFFICIAL CHANGE
	>>>>>>>. R2

In the case of larger conflicts, for each file in which a problem
was detected, put in your Subversion working copy three extra files
that are not under the control of the program:

file.mine: This is the file that was in the working copy first
             upgrade. This file contains the latest changes
             done and nothing else. (If Subversion considers the file
             not able to be integrated, then the file. mine is not created,
             because it could be identical to the working file);

file.OLDREV: This is the file that was checked out before
               recent changes we have made;

file.NEWREV: This is the file that has just been received from the server svn
               you did when you updated the working copy;

At this point, Subversion will not allow you to send any changes to the server
until the three temporary files are removed.

We therefore must decide how to intervene to resolve conflicts:
we will have to choose the most appropriate modification,
eliminate what to discard, or combine in a single
block / file both changes.
You can also choose to discard your changes in favor
of those in the revision of the file on the server, to obtain
this just type:

	svn revert file

So with the option remove revert our changes locally,
the file locally will accept the version of the file on
the repository.

After resolving the conflicts simply type:

	svn resolved

to notify the repository that we have solved everything.


### B.5.5 Add and delete, add and remove files

In the event that you have created new files to integrate into the
project which you are working, svn offers the option svn add. With add
it is reported that at the next commit changes to files on
repository, will be added and also sent the new files.
The managers of a project might want to see these new files,
after using add, svn diff is invoked if the output of
this option displays the changes between the
content of the new file.
If we want to point out the need for Subversion to
remove some files from the project we're working together we
type:

	svn delete fileCancelled


### B.5.6 Commit, sending and integration of changes

If all the steps described until now have been successful, and managers
of the project have willingly accepted your changes
by sending the differences (diff), it is time to
send your changes to the repository. To achieve this
move to the directory in the shell that contains the project files
and type:

	svn commit-m "commentoAlleMieModifiche"

The-m flag tells SVN to attach a comment to the modifications that
they are sending to the official repositories, not mandatory, but
strongly recommended in order to make others understand what
our changes consist of. If you omit the-m flag a window will be
opened of the program and where you must enter the
edit comment.
At this point, you may be asked the root password that is not usually
possessed, just simply type send, then you will
only require the first time your userid (the same as
Your account on the server), and a password (which in the case of SourceForge
is the password for your account, while in the case of Code. Google
will be the one given to you by your project).
This way your changes will represent the current review
present in the repository.


## B.6 svnadmin, creation of own projects

So far we have dealt only with how to interact with existing projects. 
If we wanted to create from scratch a new project that uses
Subversion we will have to use another svn tool
package, the command svnadmin.
However, before using this command it is good to exhibit
assumptions regarding the choice of the server to be used for their
design and structure the directory you will create.


### B.6.1 Server custom or already prepared?

You can create your own project that uses Subversion and
employs space usually provided by your ISP or other
services such as Altervista, but such a choice involves a number of
risks and limitations. The biggest problem with the choice of
server is usually the obligation of having to install Apache,
that serves in this case to restrict access to visitors, in
so that the administrator of the server (ie us) is the only one able
to possibly delete the repository. Without Apache anyone could
destroy all of our work, we also have to have prior
knowledge of the Apache package.

Fortunately, there are portals that make a specific
server ready for use with Subversion, among them 
SourceForge and Code.Google are certainly the most known. Each
these portals allows the administrator to easily set the
rules of access to their projects, configure the visibility of
files belonging to the project (for example if we had a closed source
project we will not want to give access to its sources to
everyone), the removal and addition of users who collaborate to
project, and much more.

There are some differences between SourceForge and Code.Google:

- SourceForge allows users to send data using the 
sourceforge account password, and Code.Google provides a password
auto generated and known only to the administrator;

- SourgeForge does not accept projects that do not relate to programming
in other words within the repository of SourgeForge are
accepted only source files and the like. You are also obliged to choose
a license from those listed or propose their own, but licenses
such as Creative Commons will not be allowed to SourgeForge. All this
does not exist on Code.Google;

- Code.Google allows interaction with your server via SSL,
So prior to version 1.7 of Subversion on Amiga not
Code.Google work with, while on SourceForge it does not have
these problems (yet);

Code.Google provides a user-created tree for each project
Directory typical of a SVN repository, and SourceForge
requires more attention when the user will have to create
its standard directory tree;

Once you choose the portal to use and have created the necessary
account, the site will provide you a URL that will be the homepage of
your project (see section B.5.1) in it as usual you
will find links that will be used with the command svn (see
section B.5.1) and also with the svnadmin command. For example, if the
project was registered as "MyProject" in SourgeForge:

	https://nowined.svn.sourceforge.net/svnroot/MyProject

while Code.Google you:

	https://myproject.googlecode.com/svn/trunk


### B.6.2 Preparing the necessary files and creation of the repository

To create our own repository you must first do these actions in the
Shell. First, in RAM:

	cd RAM:

At this point we create directories that will host temporarily
our project:

	MAKEDIR temp
	MAKEDIR temp/MyProject

If the chosen server is provided by SourgeForge at this point must
create other directories:

	MAKEDIR RAM:temp/MyProject/branches
	MAKEDIR RAM:temp/MyProject/tags
	MAKEDIR RAM:temp/MyProject/trunk

This guide is does not presently discuss in detail the use
of these three directories, so for further information you
should refer to the complete guide for Subversion
(http://svnbook.red-bean.com/nightly/it/svn-book.html), suffice it to say
the trunk directory will contain all the files in your project
while branches and tags directories will remain (for now) empty.
Directories branches, tags, and trunk are not actually required by
Subversion, they simply represent a common convention
most likely to be followed.

It is time to create a temporary directory
destination (temporary repository):

	MAKEDIR RAM:svnroot

At this point you can put all the files in your project
within ram:temp/MyProject/trunk/. 
Now it is possible to create the actual repository:

	svnadmin create /ram/svnroot/repos

Finally, we must import all the files in the remote repository that we
created so far, to the URL we use for our SVN server (section B.6.1):

	svn import /ram/temp/MyProject URL_DEL_VOSTRO_PROGETTO -m "initial import"

During these steps you may be requested to
login, that which we have already described (section B.5.6).
Thus we have finally got the repository for our project,
there is nothing left to do but find a suitable space on our
harddisk and type:

	svn co URL_TO_YOUR_PROJECT MyProject

The directory will be created on the harddisk.  As usual the local copy of
our project will be resident on the remote repository.
Directories in RAM were temporary and therefore should be removed.