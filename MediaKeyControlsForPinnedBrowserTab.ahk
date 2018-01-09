/*
Script Name: Media Key Controls for Pinned Browser Tab
Author: Steven Lamphear
When I'm at work, I stream music from my home computer via Plex. Since I can't install the Plex Media Player application
on my work laptop, I decided to keep the Plex web app pinned as the first tab in my browser. Unfortunately, this
(combined with the fact that the Media Keys extension - https://addons.mozilla.org/en-US/firefox/addon/media-keys/ - does
not work with Firefox Quantum) meant that I was unable to use the media keys on my keyboard to play/pause music and skip
tracks. I wrote the following script to send the media keys' commands to Plex (which I keep as a pinned tab in my first
Firefox window) via AutoHotkey.
*/

Media_Play_Pause::
	sendCommandToPinnedTab("space")
Return

Media_Next::
	sendCommandToPinnedTab("right")
Return

Media_Prev::
	sendCommandToPinnedTab("left")
Return

sendCommandToPinnedTab(command)
{
	DetectHiddenWindows, on
	activityWasChanged := TRUE
	if WinActive("ahk_class MozillaWindowClass")
	{
		activityWasChanged := FALSE
		WinMinimize
		sleep 10
	}
	send, {LWin down}5
	sleep 150
	send, {LWin up}
	sleep 150
	send, ^1
	sleep 150
	send {%command%}
	if (activityWasChanged)
	{
		WinActive("ahk_class MozillaWindowClass")
		WinMinimize
		;One additional window might be open if multiple FireFox windows are open, so perform the check again.
		if WinActive("ahk_class MozillaWindowClass")
		{
			WinMinimize
		}
	}
}
