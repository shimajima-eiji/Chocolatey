﻿var Addon_Id = "searchbar";
var Default = "ToolBar2Right";

var item = GetAddonElement(Addon_Id);
if (!item.getAttribute("Set")) {
	item.setAttribute("MenuPos", -1);
}

if (window.Addon == 1) {
	Addons.SearchBar =
	{
		iCaret: -1,
		strName: "Search Bar",

		Change: function (o)
		{
			setTimeout(function ()
			{
				Addons.SearchBar.ShowButton();
				if (document.F.search.value.length == 0) {
					var FV = te.Ctrl(CTRL_FV);
					if (IsSearchPath(FV)) {
						CancelFilterView(FV);
					}
				}
			}, 99);
		},

		KeyDown: function (o)
		{
			if (event.keyCode == VK_RETURN) {
				Addons.SearchBar.Search();
				(function (o) { setTimeout(function () {
					o.focus();
				}, 999);}) (o);
				return false;
			}
		},

		Search: function ()
		{
			var FV = te.Ctrl(CTRL_FV);
			var s = document.F.search.value;
			if (s.length) {
				FV.FilterView(s);
			} else {
				CancelFilterView(FV);
			}
			Addons.SearchBar.ShowButton();
		},

		Focus: function (o)
		{
			o.select();
			if (this.iCaret >= 0) {
				var range = o.createTextRange();
				range.move("character", this.iCaret);
				range.select();
				this.iCaret = -1;
			}
		},

		Clear: function ()
		{
			document.F.search.value = "";
			this.Search();
		},

		ShowButton: function ()
		{
			if (WINVER < 0x602) {
				document.getElementById("ButtonSearchClear").style.display = document.F.search.value.length ? "inline" : "none";
			}
		},

		Exec: function ()
		{
			document.F.search.focus();
			return S_OK;
		}
	};

	AddEvent("ChangeView", function (Ctrl)
	{
		document.F.search.value = IsSearchPath(Ctrl) ? api.GetDisplayNameOf(Ctrl, SHGDN_INFOLDER | SHGDN_ORIGINAL) : "";
		Addons.SearchBar.ShowButton();
	});

	var width = "176px";
	var s = item.getAttribute("Width");
	if (s) {
		width = (api.QuadPart(s) == s) ? (s + "px") : s;
	}
	var icon = ExtractMacro(te, api.PathUnquoteSpaces(item.getAttribute("Icon"))) || "bitmap:ieframe.dll,216,16,17";
	//Menu
	if (item.getAttribute("MenuExec")) {
		Addons.SearchBar.nPos = api.LowPart(item.getAttribute("MenuPos"));
		var s = item.getAttribute("MenuName");
		if (s && s != "") {
			Addons.SearchBar.strName = s;
		}
		AddEvent(item.getAttribute("Menu"), function (Ctrl, hMenu, nPos)
		{
			api.InsertMenu(hMenu, Addons.SearchBar.nPos, MF_BYPOSITION | MF_STRING, ++nPos, GetText(Addons.SearchBar.strName));
			ExtraMenuCommand[nPos] = Addons.SearchBar.Exec;
			return nPos;
		});
	}
	//Key
	if (item.getAttribute("KeyExec")) {
		SetKeyExec(item.getAttribute("KeyOn"), item.getAttribute("Key"), Addons.SearchBar.Exec, "Func");
	}
	//Mouse
	if (item.getAttribute("MouseExec")) {
		SetGestureExec(item.getAttribute("MouseOn"), item.getAttribute("Mouse"), Addons.SearchBar.Exec, "Func");
	}
	AddTypeEx("Add-ons", "Search Bar", Addons.SearchBar.Exec);

	SetAddon(Addon_Id, Default, ['<input type="text" name="search" placeholder="Search" onkeydown="return Addons.SearchBar.KeyDown(this)" onmouseup="Addons.SearchBar.Change(this)" onfocus="Addons.SearchBar.Focus(this)" style="width:', EncodeSC(width), '; padding-right:', WINVER < 0x602 ? "32": "16", 'px; vertical-align: middle"><span class="button" style="position: relative"><input type="image" id="ButtonSearchClear" src="bitmap:ieframe.dll,545,13,1" onclick="Addons.SearchBar.Clear()" style="display: none; position: absolute; left: -33px; top: -4px" hidefocus="true"><input type="image" src="', EncodeSC(icon), '" onclick="Addons.SearchBar.Search()" hidefocus="true" style="position: absolute; left: -18px; top: -6px; width 16px; height: 16px"></span>'], "middle");
}
else {
	SetTabContents(0, "View", '<table style="width: 100%"><tr><td><label>Width</label></td></tr><tr><td><input type="text" name="Width" size="10" /></td><td><input type="button" value="Default" onclick="document.F.Width.value=\'\'" /></td></tr></table>');
}
