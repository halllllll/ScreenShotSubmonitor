set y to year of (current date) as text
set m to month of (current date) as number as text
set d to day of (current date) as text
set h to hours of (current date) as text
set mn to minutes of (current date) as text
set s to seconds of (current date) as text
-- なんかいい感じに結合させる（リストとdelimiter用意するのがめんどくさいので力技）
set file_name_format to y & "_" & m & "_" & d & "_" & h & "_" & mn & "_" & s
set file_base to "任意のディレクトリ" & file_name_format

-- キャプチャするウインドウ 数はディスプレイ数を超えてもエラーにならなかったので適当に大きい数
-- メインディスプレイは最初に出てくるっぽい
set all_file to {}
set main_captured_path to ""
repeat with i from 1 to 5
	set file_name to (file_base & "_" & i as text) & ".png"
	set end of all_file to file_name
	if i is 1 then
		set main_captured_path to POSIX file file_name
	end if
end repeat
-- リストを空白で結合
set defaultDelimit to AppleScript's text item delimiters
set AppleScript's text item delimiters to " "
set textItem to all_file as text
set AppleScript's text item delimiters to defaultDelimit
set concat_path to textItem
-- スクショ
set command to "screencapture " & concat_path
do shell script command
-- 実際にはメインディスプレイのは要らないので消去
-- 亡霊を残さないために数秒待つ まあ残ってたら再起すりゃ消えるから
delay 2
tell application "Finder"
	delete file main_captured_path
	-- emptyつけないと亡霊が残る
	empty
end tell