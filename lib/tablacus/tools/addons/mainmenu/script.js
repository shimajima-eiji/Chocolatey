Addon_Id = "mainmenu";
Default = "ToolBar1Left";

if (window.Addon == 1) {
	Addons.MainMenu = {
		Menu: [],

		Popup: async function (o) {
			if (!await Common.MainMenu.bClose) {
				Addons.MainMenu.Item = o;
				Common.MainMenu.Item = await GetRect(o, 1);
				for (var i = await GetLength(await Common.MainMenu.Menu); i--;) {
					Common.MainMenu.Items[i] = await GetRect(document.getElementById(await Common.MainMenu.Menu[i]), 1);
				}
				clearTimeout(Addons.MainMenu.tid);
				Addons.MainMenu.tid = setTimeout(async function () {
					delete Addons.MainMenu.tid;
					var o = Addons.MainMenu.Item;
					var p = GetPos(o, 9);
					MouseOver(o);
					$.Ctrl = await te;
					Common.MainMenu.bLoop = true;
					await Common.MainMenu.bLoop;
					AddEvent("ExitMenuLoop", async function () {
						Common.MainMenu.bLoop = false;
						Common.MainMenu.bClose = true;
						clearTimeout(Addons.MainMenu.tid2);
						Addons.MainMenu.tid2 = setTimeout("Common.MainMenu.bClose = false;", 500);
					})
					ExecMenu2(o.id.replace(/^Menu/, ""), p.x, p.y);
					MouseOut();
				}, 99);
			}
		}
	}
	Common.MainMenu = await api.CreateObject("Object");
	Common.MainMenu.Menu = await api.CreateObject("Array");
	Common.MainMenu.Items = await api.CreateObject("Array");
	Common.MainMenu.Popup = function (s) {
		Addons.MainMenu.Popup(document.getElementById(s));
	}

	// Init
	var used = {};
	var strMenus = ["&File", "&Edit", "&View", "F&avorites", "&Tools", "&Help"];
	var s = [];
	for (var i = 0; i < strMenus.length; i++) {
		var s1 = strMenus[i].replace("&", "");
		var strMenu = amp2ul(await GetText(strMenus[i]));
		var res = /&(.)/.exec(strMenu);
		if (res) {
			var c = res[1];
			if (!used[c]) {
				used[c] = true;
				SetKeyExec("All", "Alt+" + c, 'Common.MainMenu.Popup("Menu' + s1 + '");', "JScript");
			}
		}
		s.push('<label class="menu" id="Menu', s1, '" onmousedown="Addons.MainMenu.Popup(this)" onmouseover="MouseOver(this)" onmouseout="MouseOut()">', await GetText(strMenu), '</label>');
	}
	SetAddon(Addon_Id, Default, s);
	for (var i = strMenus.length; i--;) {
		var s1 = strMenus[i].replace("&", "");
		Addons.MainMenu.Menu[i] = document.getElementById('Menu' + s1);
		Common.MainMenu.Menu[i] = 'Menu' + s1;
	}
	importJScript("addons\\" + Addon_Id + "\\sync.js");
}
