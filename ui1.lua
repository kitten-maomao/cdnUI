--[[
     _      ___         ____  ______
    | | /| / (_)__  ___/ / / / /  _/
    | |/ |/ / / _ \/ _  / /_/ // / =20
    |__/|__/_/_//_/\_,_/\____/___/
   =20
    v1.6.65  |  2026-05-24  |  Roblox UI Library for scripts
   =20
    To view the source code, see the `src/` folder on the official GitHub r=
epository.
   =20
    Author: Footagesus (Footages, .ftgs, oftgs)
    Github: https://github.com/Footagesus/WindUI
    Discord: https://discord.gg/ftgs-development-hub-1300692552005189632
    License: MIT
]]

type ConfigType__DARKLUA_TYPE_a=3D{
Object:Instance,
Camera:Instance?,
Interactive:boolean?,
Height:number?,
Focused:boolean,

Window:any,
Tab:any,
Parent:Instance,
}local a a=3D{cache=3D{}, load=3Dfunction(b)if not a.cache[b]then a.cache[b=
]=3D{c=3Da[b]()}end return a.cache[b].c end}do function a.a()

local b=3D(cloneref or clonereference or function(b)return b end)

local d=3Db(game:GetService"ReplicatedStorage":WaitForChild("GetIcons",9999=
9):InvokeServer())

local function parseIconString(e)
if type(e)=3D=3D"string"then
local f=3De:find":"
if f then
local g=3De:sub(1,f-1)
local h=3De:sub(f+1)
return g,h
end
end
return nil,e
end

function d.AddIcons(e,f)
if type(e)~=3D"string"or type(f)~=3D"table"then
error"AddIcons: packName must be string, iconsData must be table"
return
end

if not d.Icons[e]then
d.Icons[e]=3D{
Icons=3D{},
Spritesheets=3D{}
}
end

for g,h in pairs(f)do
if type(h)=3D=3D"number"or(type(h)=3D=3D"string"and h:match"^rbxassetid://"=
)then
local i=3Dh
if type(h)=3D=3D"number"then
i=3D"rbxassetid://"..tostring(h)
end

d.Icons[e].Icons[g]=3D{
Image=3Di,
ImageRectSize=3DVector2.new(0,0),
ImageRectPosition=3DVector2.new(0,0),
Parts=3Dnil
}
d.Icons[e].Spritesheets[i]=3Di

elseif type(h)=3D=3D"table"then
if h.Image and h.ImageRectSize and h.ImageRectPosition then
local i=3Dh.Image
if type(i)=3D=3D"number"then
i=3D"rbxassetid://"..tostring(i)
end

d.Icons[e].Icons[g]=3D{
Image=3Di,
ImageRectSize=3Dh.ImageRectSize,
ImageRectPosition=3Dh.ImageRectPosition,
Parts=3Dh.Parts
}

if not d.Icons[e].Spritesheets[i]then
d.Icons[e].Spritesheets[i]=3Di
end
else
warn("AddIcons: Invalid spritesheet data format for icon '"..g.."'")
end
else
warn("AddIcons: Unsupported data type for icon '"..g.."': "..type(h))
end
end
end

function d.SetIconsType(e)
d.IconsType=3De
end

local e
function d.Init(f,g)
d.New=3Df
d.IconThemeTag=3Dg

e=3Df
return d
end

function d.Icon(f,g,h)
h=3Dh~=3Dfalse
local i,j=3DparseIconString(f)

local l=3Di or g or d.IconsType
local m=3Dj

local p=3Dd.Icons[l]

if p and p.Icons and p.Icons[m]then
return{
p.Spritesheets[tostring(p.Icons[m].Image)],
p.Icons[m],
}
elseif p and p[m]and string.find(p[m],"rbxassetid://")then
return h and{
p[m],
{ImageRectSize=3DVector2.new(0,0),ImageRectPosition=3DVector2.new(0,0)}
}or p[m]
end
return nil
end

function d.GetIcon(f,g)
return d.Icon(f,g,false)
end


function d.Icon2(f,g,h)
return d.Icon(f,g,true)
end

function d.Image(f)
local g=3D{
Icon=3Df.Icon or nil,
Type=3Df.Type,
Colors=3Df.Colors or{(d.IconThemeTag or Color3.new(1,1,1)),Color3.new(1,1,1=
)},
Transparency=3Df.Transparency or{0,0},
Size=3Df.Size or UDim2.new(0,24,0,24),

IconFrame=3Dnil,
}

local h=3D{}
local i=3D{}

for j,l in next,g.Colors do
h[j]=3D{
ThemeTag=3Dtypeof(l)=3D=3D"string"and l,
Color=3Dtypeof(l)=3D=3D"Color3"and l,
}
end

for j,l in next,g.Transparency do
i[j]=3D{
ThemeTag=3Dtypeof(l)=3D=3D"string"and l,
Value=3Dtypeof(l)=3D=3D"number"and l,
}
end


local j=3Dd.Icon2(g.Icon,g.Type)
local l=3Dtypeof(j)=3D=3D"string"and string.find(j,'rbxassetid://')

if d.New then
local m=3De or d.New



local p=3Dm("ImageLabel",{
Size=3Dg.Size,
BackgroundTransparency=3D1,
ImageColor3=3Dh[1].Color or nil,
ImageTransparency=3Di[1].Value or nil,
ThemeTag=3Dh[1].ThemeTag and{
ImageColor3=3Dh[1].ThemeTag,
ImageTransparency=3Di[1].ThemeTag,
},
Image=3Dl and j or j[1],
ImageRectSize=3Dl and nil or j[2].ImageRectSize,
ImageRectOffset=3Dl and nil or j[2].ImageRectPosition,
})


if not l and j[2].Parts then
for r,u in next,j[2].Parts do
local v=3Dd.Icon(u,g.Type)

m("ImageLabel",{
Size=3DUDim2.new(1,0,1,0),
BackgroundTransparency=3D1,
ImageColor3=3Dh[1+r].Color or nil,
ImageTransparency=3Di[1+r].Value or nil,
ThemeTag=3Dh[1+r].ThemeTag and{
ImageColor3=3Dh[1+r].ThemeTag,
ImageTransparency=3Di[1+r].ThemeTag,
},
Image=3Dv[1],
ImageRectSize=3Dv[2].ImageRectSize,
ImageRectOffset=3Dv[2].ImageRectPosition,
Parent=3Dp,
})
end
end

g.IconFrame=3Dp
else
local m=3DInstance.new"ImageLabel"
m.Size=3Dg.Size
m.BackgroundTransparency=3D1
m.ImageColor3=3Dh[1].Color
m.ImageTransparency=3Di[1].Value or nil
m.Image=3Dl and j or j[1]
m.ImageRectSize=3Dl and nil or j[2].ImageRectSize
m.ImageRectOffset=3Dl and nil or j[2].ImageRectPosition


if not l and j[2].Parts then
for p,r in next,j[2].Parts do
local u=3Dd.Icon(r,g.Type)

local v=3DInstance.New"ImageLabel"
v.Size=3DUDim2.new(1,0,1,0)
v.BackgroundTransparency=3D1
v.ImageColor3=3Dh[1+p].Color
v.ImageTransparency=3Di[1+p].Value or nil
v.Image=3Du[1]
v.ImageRectSize=3Du[2].ImageRectSize
v.ImageRectOffset=3Du[2].ImageRectPosition
v.Parent=3Dm
end
end

g.IconFrame=3Dm
end


return g
end

return d end function a.b()
return function(b)
return{


Primary=3D"Icon",

White=3DColor3.new(1,1,1),
Black=3DColor3.new(0,0,0),

Dialog=3D"Accent",

Background=3D"Accent",
BackgroundTransparency=3D0,
Hover=3D"Text",

PanelBackground=3D"White",
PanelBackgroundTransparency=3D0.95,

WindowBackground=3D"Background",

WindowShadow=3D"Black",


WindowTopbarTitle=3D"Text",
WindowTopbarAuthor=3D"Text",
WindowTopbarIcon=3D"Icon",
WindowTopbarButtonIcon=3D"Icon",

WindowSearchBarBackground=3D"Background",

TabBackground=3D"Hover",
TabBackgroundHover=3D"Hover",
TabBackgroundHoverTransparency=3D0.97,
TabBackgroundActive=3D"Hover",
TabBackgroundActiveTransparency=3D0.93,
TabText=3D"Text",
TabTextTransparency=3D0.3,
TabTextTransparencyActive=3D0,
TabTitle=3D"Text",
TabIcon=3D"Icon",
TabIconTransparency=3D0.4,
TabIconTransparencyActive=3D0.1,
TabBorderTransparency=3D1,
TabBorderTransparencyActive=3D0.75,
TabBorder=3D"White",

ElementBackground=3D"Text",
ElementBackgroundTransparency=3D0.93,
ElementBackgroundHover=3Db:AddColor("ElementBackground","#ffffff",0.1),
ElementTitle=3D"Text",
ElementDesc=3D"Text",
ElementIcon=3D"Icon",

PopupBackground=3D"Background",
PopupBackgroundTransparency=3D"BackgroundTransparency",
PopupTitle=3D"Text",
PopupContent=3D"Text",
PopupIcon=3D"Icon",

DialogBackground=3D"Background",
DialogBackgroundTransparency=3D"BackgroundTransparency",
DialogTitle=3D"Text",
DialogContent=3D"Text",
DialogIcon=3D"Icon",

Toggle=3D"Button",
ToggleBar=3D"White",

Checkbox=3D"Primary",
CheckboxIcon=3D"White",
CheckboxBorder=3D"White",
CheckboxBorderTransparency=3D0.75,

SliderIcon=3D"Icon",

Slider=3D"Primary",
SliderThumb=3D"White",
SliderIconFrom=3D"SliderIcon",
SliderIconTo=3D"SliderIcon",

Tooltip=3DColor3.fromHex"4C4C4C",
TooltipText=3D"White",
TooltipSecondary=3D"Primary",
TooltipSecondaryText=3D"White",

TabSectionIcon=3D"Icon",

SectionIcon=3D"Icon",

SectionExpandIcon=3D"White",
SectionExpandIconTransparency=3D0.4,
SectionBox=3D"White",
SectionBoxTransparency=3D0.95,
SectionBoxBorder=3D"White",
SectionBoxBorderTransparency=3D0.75,
SectionBoxBackground=3D"White",
SectionBoxBackgroundTransparency=3D0.95,

SearchBarBorder=3D"White",
SearchBarBorderTransparency=3D0.75,

Notification=3D"Background",
NotificationTitle=3D"Text",
NotificationTitleTransparency=3D0,
NotificationContent=3D"Text",
NotificationContentTransparency=3D0.4,
NotificationDuration=3D"White",
NotificationDurationTransparency=3D0.95,
NotificationBorder=3D"White",
NotificationBorderTransparency=3D0.75,

DropdownTabBorder=3D"White",

LabelBackground=3D"White",
LabelBackgroundTransparency=3D0.95,

ViewportBackground=3D"ElementBackground",
ViewportBackgroundTransparency=3D"ElementBackgroundTransparency",
}
end end function a.c()

local b=3D(cloneref or clonereference or function(b)
return b
end)

local d=3Db(game:GetService"RunService")
local e=3Db(game:GetService"UserInputService")
local f=3Db(game:GetService"TweenService")
local g=3Db(game:GetService"LocalizationService")
local h=3Db(game:GetService"HttpService")local i=3D

d.Heartbeat

local j=3D"https://raw.githubusercontent.com/Footagesus/Icons/main/Main-v2.=
lua"

local l
if d:IsStudio()or not writefile then
l=3Da.load'a'
else
l=3Dloadstring(
game.HttpGetAsync and game:HttpGetAsync(j)or h:GetAsync(j)
)()
end

l.SetIconsType"lucide"

local m

local p
p=3D{
Font=3D"rbxassetid://12187365364",
Localization=3Dnil,
CanDraggable=3Dtrue,
Theme=3Dnil,
Themes=3Dnil,
Icons=3Dl,
Signals=3D{},
Objects=3D{},
LocalizationObjects=3D{},
FontObjects=3D{},
Language=3Dstring.match(g.SystemLocaleId,"^[a-z]+"),
Request=3Dhttp_request or(syn and syn.request)or request,
DefaultProperties=3D{
ScreenGui=3D{
ResetOnSpawn=3Dfalse,
ZIndexBehavior=3D"Sibling",
},
CanvasGroup=3D{
BorderSizePixel=3D0,
BackgroundColor3=3DColor3.new(1,1,1),
},
Frame=3D{
BorderSizePixel=3D0,
BackgroundColor3=3DColor3.new(1,1,1),
},
TextLabel=3D{
BackgroundColor3=3DColor3.new(1,1,1),
BorderSizePixel=3D0,
Text=3D"",
RichText=3Dtrue,
TextColor3=3DColor3.new(1,1,1),
TextSize=3D14,
},
TextButton=3D{
BackgroundColor3=3DColor3.new(1,1,1),
BorderSizePixel=3D0,
Text=3D"",
AutoButtonColor=3Dfalse,
TextColor3=3DColor3.new(1,1,1),
TextSize=3D14,
},
TextBox=3D{
BackgroundColor3=3DColor3.new(1,1,1),
BorderColor3=3DColor3.new(0,0,0),
ClearTextOnFocus=3Dfalse,
Text=3D"",
TextColor3=3DColor3.new(0,0,0),
TextSize=3D14,
},
ImageLabel=3D{
BackgroundTransparency=3D1,
BackgroundColor3=3DColor3.new(1,1,1),
BorderSizePixel=3D0,
},
ImageButton=3D{
BackgroundColor3=3DColor3.new(1,1,1),
BorderSizePixel=3D0,
AutoButtonColor=3Dfalse,
},
UIListLayout=3D{
SortOrder=3D"LayoutOrder",
},
ScrollingFrame=3D{
ScrollBarImageTransparency=3D1,
BorderSizePixel=3D0,
},
VideoFrame=3D{
BorderSizePixel=3D0,
},
},
Colors=3D{
Red=3D"#e53935",
Orange=3D"#f57c00",
Green=3D"#43a047",
Blue=3D"#039be5",
White=3D"#ffffff",
Grey=3D"#484848",
},
ThemeFallbacks=3Dnil,
Shapes=3D{Square=3D
"rbxassetid://82909646051652",
["Square-Outline"]=3D"rbxassetid://72946211851948",Squircle=3D

"rbxassetid://80999662900595",SquircleOutline=3D
"rbxassetid://117788349049947",
["Squircle-Outline"]=3D"rbxassetid://117817408534198",SquircleOutline2=3D

"rbxassetid://117817408534198",

["Shadow-sm"]=3D"rbxassetid://84825982946844",

["Squircle-TL-TR"]=3D"rbxassetid://73569156276236",
["Squircle-BL-BR"]=3D"rbxassetid://93853842912264",
["Squircle-TL-TR-Outline"]=3D"rbxassetid://136702870075563",
["Squircle-BL-BR-Outline"]=3D"rbxassetid://75035847706564",

["Glass-0.7"]=3D"rbxassetid://79047752995006",
["Glass-1"]=3D"rbxassetid://97324581055162",
["Glass-1.4"]=3D"rbxassetid://95071123641270",
},
ThemeChangeCallbacks=3D{},
}

function p.Init(r)
m=3Dr

p.ThemeFallbacks=3Da.load'b'(p)
end

function p.AddSignal(r,u)
local v=3Dr:Connect(u)
table.insert(p.Signals,v)
return v
end

function p.DisconnectAll()
for r,u in next,p.Signals do
local v=3Dtable.remove(p.Signals,r)
v:Disconnect()
end
end

function p.SafeCallback(r,...)
if not r then
return
end

local u,v=3Dpcall(r,...)
if not u then
if m and m.Window and m.Window.Debug then local
x, z=3Dv:find":%d+: "

warn("[ WindUI: DEBUG Mode ] "..v)

return m:Notify{
Title=3D"DEBUG Mode: Error",
Content=3Dnot z and v or v:sub(z+1),
Duration=3D8,
}
end
end
end

function p.Gradient(r,u)
if m and m.Gradient then
return m:Gradient(r,u)
end

local v=3D{}
local x=3D{}

for z,A in next,r do
local B=3Dtonumber(z)
if B then
B=3Dmath.clamp(B/100,0,1)
table.insert(v,ColorSequenceKeypoint.new(B,A.Color))
table.insert(x,NumberSequenceKeypoint.new(B,A.Transparency or 0))
end
end

table.sort(v,function(z,A)
return z.Time&lt;A.Time
end)
table.sort(x,function(z,A)
return z.Time&lt;A.Time
end)

if#v&lt;2 then
error"ColorSequence requires at least 2 keypoints"
end

local z=3D{
Color=3DColorSequence.new(v),
Transparency=3DNumberSequence.new(x),
}

if u then
for A,B in pairs(u)do
z[A]=3DB
end
end

return z
end

function p.SetTheme(r)
local u=3Dp.Theme
p.Theme=3Dr
p.UpdateTheme(nil,false)

for v,x in next,p.ThemeChangeCallbacks do
p.SafeCallback(x,r,u)
end
end

function p.AddFontObject(r)
table.insert(p.FontObjects,r)
p.UpdateFont(p.Font)
end

function p.UpdateFont(r)
p.Font=3Dr
for u,v in next,p.FontObjects do
v.FontFace=3DFont.new(r,v.FontFace.Weight,v.FontFace.Style)
end
end

function p.GetThemeProperty(r,u)
local function getValue(v,x)
local z=3Dx[v]

if z=3D=3Dnil then
return nil
end

if typeof(z)=3D=3D"string"and string.sub(z,1,1)=3D=3D"#"then
return Color3.fromHex(z)
end

if typeof(z)=3D=3D"Color3"then
return z
end

if typeof(z)=3D=3D"number"then
return z
end

if typeof(z)=3D=3D"table"and z.Color and z.Transparency then
return z
end

if typeof(z)=3D=3D"function"then
return z(x)
end

return z
end

local v=3DgetValue(r,u)
if v~=3Dnil then
if typeof(v)=3D=3D"string"and string.sub(v,1,1)~=3D"#"then
local x=3Dp.GetThemeProperty(v,u)
if x~=3Dnil then
return x
end
else
return v
end
end

local x=3Dp.ThemeFallbacks[r]
if x~=3Dnil then
if typeof(x)=3D=3D"string"and string.sub(x,1,1)~=3D"#"then
return p.GetThemeProperty(x,u)
else
return getValue(r,{[r]=3Dx})
end
end

v=3DgetValue(r,p.Themes.Dark)
if v~=3Dnil then
if typeof(v)=3D=3D"string"and string.sub(v,1,1)~=3D"#"then
local z=3Dp.GetThemeProperty(v,p.Themes.Dark)
if z~=3Dnil then
return z
end
else
return v
end
end

if x~=3Dnil then
if typeof(x)=3D=3D"string"and string.sub(x,1,1)~=3D"#"then
return p.GetThemeProperty(x,p.Themes.Dark)
else
return getValue(r,{[r]=3Dx})
end
end

return nil
end

function p.AddThemeObject(r,u,v)
if p.Objects[r]then
for x,z in pairs(u)do
p.Objects[r].Properties[x]=3Dz
end
else
p.Objects[r]=3D{Object=3Dr,Properties=3Du}
end

if not v then
p.UpdateTheme(r,false)
end
return r
end

function p.AddLangObject(r)
local u=3Dp.LocalizationObjects[r]
if not u then
return
end

local v=3Du.Object

p.SetLangForObject(r)

return v
end

function p.UpdateTheme(r,u,v,x,z,A)
local function ApplyTheme(B)
for C,F in pairs(B.Properties or{})do
local G=3Dp.GetThemeProperty(F,p.Theme)
if G~=3Dnil then
if typeof(G)=3D=3D"Color3"then
local H=3DB.Object:FindFirstChild"LibraryGradient"
if H then
H:Destroy()
end

if v then
p.Tween(
B.Object,
x or 0.2,
{[C]=3DG},
z or Enum.EasingStyle.Quint,
A or Enum.EasingDirection.Out
):Play()
elseif u then
p.Tween(B.Object,0.08,{[C]=3DG}):Play()
else
B.Object[C]=3DG
end
elseif typeof(G)=3D=3D"table"and G.Color and G.Transparency then
B.Object[C]=3DColor3.new(1,1,1)

local H=3DB.Object:FindFirstChild"LibraryGradient"
if not H then
H=3DInstance.new"UIGradient"
H.Name=3D"LibraryGradient"
H.Parent=3DB.Object
end

H.Color=3DG.Color
H.Transparency=3DG.Transparency

for J,L in pairs(G)do
if J~=3D"Color"and J~=3D"Transparency"and H[J]~=3Dnil then
H[J]=3DL
end
end
elseif typeof(G)=3D=3D"number"then
if v then
p.Tween(
B.Object,
x or 0.2,
{[C]=3DG},
z or Enum.EasingStyle.Quint,
A or Enum.EasingDirection.Out
):Play()
elseif u then
p.Tween(B.Object,0.08,{[C]=3DG}):Play()
else
B.Object[C]=3DG
end
end
else
local H=3DB.Object:FindFirstChild"LibraryGradient"
if H then
H:Destroy()
end
end
end
end

if r then
local B=3Dp.Objects[r]
if B then
ApplyTheme(B)
end
else
for B,C in pairs(p.Objects)do
ApplyTheme(C)
end
end
end

function p.SetThemeTag(r,u,v,x,z)
p.AddThemeObject(r,u)
p.UpdateTheme(r,false,true,v,x,z)
end

function p.SetLangForObject(r)
if p.Localization and p.Localization.Enabled then
local u=3Dp.LocalizationObjects[r]
if not u then
return
end

local v=3Du.Object
local x=3Du.TranslationId

local z=3Dp.Localization.Translations[p.Language]
if z and z[x]then
v.Text=3Dz[x]
else
local A=3Dp.Localization
and p.Localization.Translations
and p.Localization.Translations.en
or nil
if A and A[x]then
v.Text=3DA[x]
else
v.Text=3D"["..x.."]"
end
end
end
end

function p.ChangeTranslationKey(r,u,v)
if p.Localization and p.Localization.Enabled then
local x=3Dstring.match(v,"^"..p.Localization.Prefix.."(.+)")
if x then
for z,A in ipairs(p.LocalizationObjects)do
if A.Object=3D=3Du then
A.TranslationId=3Dx
p.SetLangForObject(z)
return
end
end

table.insert(p.LocalizationObjects,{
TranslationId=3Dx,
Object=3Du,
})
p.SetLangForObject(#p.LocalizationObjects)
end
end
end

function p.UpdateLang(r)
if r then
p.Language=3Dr
end

for u=3D1,#p.LocalizationObjects do
local v=3Dp.LocalizationObjects[u]
if v.Object and v.Object.Parent~=3Dnil then
p.SetLangForObject(u)
else
p.LocalizationObjects[u]=3Dnil
end
end
end

function p.SetLanguage(r)
p.Language=3Dr
p.UpdateLang()
end

function p.Icon(r,u)
return l.Icon2(r,nil,u~=3Dfalse)
end

function p.AddIcons(r,u)
return l.AddIcons(r,u)
end

function p.New(r,u,v)
local x=3DInstance.new(r)

for z,A in next,p.DefaultProperties[r]or{}do
x[z]=3DA
end

for z,A in next,u or{}do
if z~=3D"ThemeTag"then
x[z]=3DA
end
if p.Localization and p.Localization.Enabled and z=3D=3D"Text"then
local B=3Dstring.match(A,"^"..p.Localization.Prefix.."(.+)")
if B then
local C=3D#p.LocalizationObjects+1
p.LocalizationObjects[C]=3D{TranslationId=3DB,Object=3Dx}

p.SetLangForObject(C)
end
end
end

for z,A in next,v or{}do
A.Parent=3Dx
end

if u and u.ThemeTag then
p.AddThemeObject(x,u.ThemeTag)
end
if u and u.FontFace then
p.AddFontObject(x)
end
return x
end

function p.Tween(r,u,v,...)
return f:Create(r,TweenInfo.new(u,...),v)
end

function p.NewRoundFrame(r,u,v,x,z,A)
local function getImageForType(B)
return p.Shapes[B]
end

local function getSliceCenterForType(B)
return not table.find({"Shadow-sm","Glass-0.7","Glass-1","Glass-1.4"},B)
and Rect.new(256,256,256,256)
or Rect.new(512,512,512,512)
end

local B=3Dp.New(z and"ImageButton"or"ImageLabel",{
Image=3DgetImageForType(u),
ScaleType=3D"Slice",
SliceCenter=3DgetSliceCenterForType(u),
SliceScale=3D1,
BackgroundTransparency=3D1,
ThemeTag=3Dv.ThemeTag and v.ThemeTag,
},x)

for C,F in pairs(v or{})do
if C~=3D"ThemeTag"then
B[C]=3DF
end
end

local function UpdateSliceScale(C)
local F=3Dnot table.find({"Shadow-sm","Glass-0.7","Glass-1","Glass-1.4"},u)
and(C/(256))
or(C/512)
B.SliceScale=3Dmath.max(F,0.0001)
end

local C=3D{}

function C.SetRadius(F,G)
UpdateSliceScale(G)
end

function C.SetType(F,G)
u=3DG
B.Image=3DgetImageForType(G)
B.SliceCenter=3DgetSliceCenterForType(G)
UpdateSliceScale(r)
end

function C.UpdateShape(F,G,H)
if H then
u=3DH
B.Image=3DgetImageForType(H)
B.SliceCenter=3DgetSliceCenterForType(H)
end
if G then
r=3DG
end
UpdateSliceScale(r)
end

function C.GetRadius(F)
return r
end

function C.GetType(F)
return u
end

UpdateSliceScale(r)

return B,A and C or nil
end

local r=3Dp.New local u=3D
p.Tween

function p.SetDraggable(v)
p.CanDraggable=3Dv
end

function p.Drag(v,x,z)
local A
local B,C,F
local G=3D{
CanDraggable=3Dtrue,
}

if not x or typeof(x)~=3D"table"then
x=3D{v}
end

local function update(H)
if not B or not G.CanDraggable then
return
end

local J=3DH.Position-C
p.Tween(v,0.02,{
Position=3DUDim2.new(
F.X.Scale,
F.X.Offset+J.X,
F.Y.Scale,
F.Y.Offset+J.Y
),
}):Play()
end

for H,J in pairs(x)do
J.InputBegan:Connect(function(L)
if
(
L.UserInputType=3D=3DEnum.UserInputType.MouseButton1
or L.UserInputType=3D=3DEnum.UserInputType.Touch
)and G.CanDraggable
then
if A=3D=3Dnil then
A=3DJ
B=3Dtrue
C=3DL.Position
F=3Dv.Position

if z and typeof(z)=3D=3D"function"then
z(true,A)
end

L.Changed:Connect(function()
if L.UserInputState=3D=3DEnum.UserInputState.End then
B=3Dfalse
A=3Dnil

if z and typeof(z)=3D=3D"function"then
z(false,nil)
end
end
end)
end
end
end)

J.InputChanged:Connect(function(L)
if B and A=3D=3DJ then
if
L.UserInputType=3D=3DEnum.UserInputType.MouseMovement
or L.UserInputType=3D=3DEnum.UserInputType.Touch
then
update(L)
end
end
end)
end

e.InputChanged:Connect(function(H)
if B and A~=3Dnil then
if
H.UserInputType=3D=3DEnum.UserInputType.MouseMovement
or H.UserInputType=3D=3DEnum.UserInputType.Touch
then
update(H)
end
end
end)

function G.Set(H,J)
G.CanDraggable=3DJ
end

return G
end

l.Init(r,"Icon")

function p.SanitizeFilename(v)
local x=3Dv:match"([^/]+)$"or v

x=3Dx:gsub("%.[^%.]+$","")

x=3Dx:gsub("[^%w%-_]","_")

if#x&gt;50 then
x=3Dx:sub(1,50)
end

return x
end

function p.Image(v,x,z,A,B,C,F,G)
A=3DA or"Temp"
x=3Dp.SanitizeFilename(x)

local H=3Dr("Frame",{
Size=3DUDim2.new(0,0,0,0),
BackgroundTransparency=3D1,
},{
r("ImageLabel",{
Size=3DUDim2.new(1,0,1,0),
BackgroundTransparency=3D1,
ScaleType=3D"Crop",
ThemeTag=3D(p.Icon(v)or F)and{
ImageColor3=3DC and(G or"Icon")or nil,
}or nil,
},{
r("UICorner",{
CornerRadius=3DUDim.new(0,z),
}),
}),
})
if p.Icon(v)then
H.ImageLabel:Destroy()

local J=3Dl.Image{
Icon=3Dv,
Size=3DUDim2.new(1,0,1,0),
Colors=3D{
(C and(G or"Icon")or false),
"Button",
},
}.IconFrame
J.Parent=3DH
elseif string.find(v,"http")and not string.find(v,"roblox.com")then
local J=3D"WindUI/"..A.."/assets/."..B.."-"..x..".png"
local L,M=3Dpcall(function()
task.spawn(function()
local L=3Dp.Request
and p.Request{
Url=3Dv,
Method=3D"GET",
}.Body
or{}

if not d:IsStudio()and writefile then
writefile(J,L)
end


local M,N=3Dpcall(getcustomasset,J)
if M then
H.ImageLabel.Image=3DN
else
warn(
string.format(
"[ WindUI.Creator ] Failed to load custom asset '%s': %s",
J,
tostring(N)
)
)
H:Destroy()

return
end
end)
end)
if not L then
warn(
"[ WindUI.Creator ]  '"..identifyexecutor()
or"Studio".."' doesnt support the URL Images. Error: "..M
)

H:Destroy()
end
elseif v=3D=3D""then
H.Visible=3Dfalse
else
H.ImageLabel.Image=3Dv
end

return H
end

function p.Color3ToHSB(v)
local x,z,A=3Dv.R,v.G,v.B
local B=3Dmath.max(x,z,A)
local C=3Dmath.min(x,z,A)
local F=3DB-C

local G=3D0
if F~=3D0 then
if B=3D=3Dx then
G=3D(z-A)/F%6
elseif B=3D=3Dz then
G=3D(A-x)/F+2
else
G=3D(x-z)/F+4
end
G=3DG*60
else
G=3D0
end

local H=3D(B=3D=3D0)and 0 or(F/B)
local J=3DB

return{
h=3Dmath.floor(G+0.5),
s=3DH,
b=3DJ,
}
end

function p.GetPerceivedBrightness(v)
local x=3Dv.R
local z=3Dv.G
local A=3Dv.B
return 0.299*x+0.587*z+0.114*A
end

function p.GetTextColorForHSB(v,x)
local z=3Dp.Color3ToHSB(v)local
A, B, C=3Dz.h, z.s, z.b
if p.GetPerceivedBrightness(v)&gt;(x or 0.5)then
return Color3.fromHSV(A/360,0,0.05)
else
return Color3.fromHSV(A/360,0,0.98)
end
end

function p.GetAverageColor(v)
local x,z,A=3D0,0,0
local B=3Dv.Color.Keypoints
for C,F in ipairs(B)do

x=3Dx+F.Value.R
z=3Dz+F.Value.G
A=3DA+F.Value.B
end
local C=3D#B
return Color3.new(x/C,z/C,A/C)
end

function p.GenerateUniqueID(v)
return h:GenerateGUID(false)
end

function p.OnThemeChange(v,x)
if typeof(x)~=3D"function"then
return
end

local z=3Dh:GenerateGUID(false)
p.ThemeChangeCallbacks[z]=3Dx

return{
Disconnect=3Dfunction()
p.ThemeChangeCallbacks[z]=3Dnil
end,
}
end

function p.AddColor(v,x,z,A)
A=3Dmath.clamp(A or 1,0,1)
if typeof(z)=3D=3D"string"then z=3DColor3.fromHex(z)end

return function(B)
local C
if typeof(x)=3D=3D"string"and string.sub(x,1,1)~=3D"#"then
C=3Dp.GetThemeProperty(x,B)
elseif typeof(x)=3D=3D"string"then
C=3DColor3.fromHex(x)
else
C=3Dx
end

if not C or typeof(C)~=3D"Color3"then
return nil
end

return Color3.new(
math.clamp(C.R+z.R*A,0,1),
math.clamp(C.G+z.G*A,0,1),
math.clamp(C.B+z.B*A,0,1)
)
end
end

return p end function a.d()

local b=3D{}







function b.New(d,e,f)
local g=3D{
Enabled=3De.Enabled or false,
Translations=3De.Translations or{},
Prefix=3De.Prefix or"loc:",
DefaultLanguage=3De.DefaultLanguage or"en"
}

f.Localization=3Dg

return g
end



return b end function a.e()
local b=3Da.load'c'
local d=3Db.New
local e=3Db.Tween

local f=3D{
Size=3DUDim2.new(0,300,1,-156),
SizeLower=3DUDim2.new(0,300,1,-56),
UICorner=3D18,
UIPadding=3D14,

Holder=3Dnil,
NotificationIndex=3D0,
Notifications=3D{}
}

function f.Init(g)
local h=3D{
Lower=3Dfalse
}

function h.SetLower(j)
h.Lower=3Dj
h.Frame.Size=3Dj and f.SizeLower or f.Size
end

h.Frame=3Dd("Frame",{
Position=3DUDim2.new(1,-29,0,56),
AnchorPoint=3DVector2.new(1,0),
Size=3Df.Size,
Parent=3Dg,
BackgroundTransparency=3D1,




},{
d("UIListLayout",{
HorizontalAlignment=3D"Center",
SortOrder=3D"LayoutOrder",
VerticalAlignment=3D"Bottom",
Padding=3DUDim.new(0,8),
}),
d("UIPadding",{
PaddingBottom=3DUDim.new(0,29)
})
})
return h
end

function f.New(g)
local h=3D{
Title=3Dg.Title or"Notification",
Content=3Dg.Content or nil,
Icon=3Dg.Icon or nil,
IconThemed=3Dg.IconThemed,
Background=3Dg.Background,
BackgroundImageTransparency=3Dg.BackgroundImageTransparency,
Duration=3Dg.Duration or 5,
Buttons=3Dg.Buttons or{},
CanClose=3Dg.CanClose~=3Dfalse,
UIElements=3D{},
Closed=3Dfalse,
}



f.NotificationIndex=3Df.NotificationIndex+1
f.Notifications[f.NotificationIndex]=3Dh









local j

if h.Icon then





















j=3Db.Image(
h.Icon,
h.Title..":"..h.Icon,
0,
g.Window,
"Notification",
h.IconThemed
)
j.Size=3DUDim2.new(0,26,0,26)
j.Position=3DUDim2.new(0,f.UIPadding,0,f.UIPadding)

end

local l
if h.CanClose then
l=3Dd("ImageButton",{
Image=3Db.Icon"x"[1],
ImageRectSize=3Db.Icon"x"[2].ImageRectSize,
ImageRectOffset=3Db.Icon"x"[2].ImageRectPosition,
BackgroundTransparency=3D1,
Size=3DUDim2.new(0,16,0,16),
Position=3DUDim2.new(1,-f.UIPadding,0,f.UIPadding),
AnchorPoint=3DVector2.new(1,0),
ThemeTag=3D{
ImageColor3=3D"Text"
},
ImageTransparency=3D.4,
},{
d("TextButton",{
Size=3DUDim2.new(1,8,1,8),
BackgroundTransparency=3D1,
AnchorPoint=3DVector2.new(0.5,0.5),
Position=3DUDim2.new(0.5,0,0.5,0),
Text=3D"",
})
})
end

local m=3Db.NewRoundFrame(f.UICorner,"Squircle",{
Size=3DUDim2.new(0,0,1,0),
ThemeTag=3D{
ImageTransparency=3D"NotificationDurationTransparency",
ImageColor3=3D"NotificationDuration",
},

})

local p=3Dd("Frame",{
Size=3DUDim2.new(1,
h.Icon and-28-f.UIPadding or 0,
1,0),
Position=3DUDim2.new(1,0,0,0),
AnchorPoint=3DVector2.new(1,0),
BackgroundTransparency=3D1,
AutomaticSize=3D"Y",
},{
d("UIPadding",{
PaddingTop=3DUDim.new(0,f.UIPadding),
PaddingLeft=3DUDim.new(0,f.UIPadding),
PaddingRight=3DUDim.new(0,f.UIPadding),
PaddingBottom=3DUDim.new(0,f.UIPadding),
}),
d("TextLabel",{
AutomaticSize=3D"Y",
Size=3DUDim2.new(1,-30-f.UIPadding,0,0),
TextWrapped=3Dtrue,
TextXAlignment=3D"Left",
RichText=3Dtrue,
BackgroundTransparency=3D1,
TextSize=3D18,
ThemeTag=3D{
TextColor3=3D"NotificationTitle",
TextTransparency=3D"NotificationTitleTransparency",
},
Text=3Dh.Title,
FontFace=3DFont.new(b.Font,Enum.FontWeight.SemiBold)
}),
d("UIListLayout",{
Padding=3DUDim.new(0,f.UIPadding/3)
})
})

if h.Content then
d("TextLabel",{
AutomaticSize=3D"Y",
Size=3DUDim2.new(1,0,0,0),
TextWrapped=3Dtrue,
TextXAlignment=3D"Left",
RichText=3Dtrue,
BackgroundTransparency=3D1,

TextSize=3D15,
ThemeTag=3D{
TextColor3=3D"NotificationContent",
TextTransparency=3D"NotificationContentTransparency",
},
Text=3Dh.Content,
FontFace=3DFont.new(b.Font,Enum.FontWeight.Medium),
Parent=3Dp
})
end


local r=3Db.NewRoundFrame(f.UICorner,"Squircle",{
Size=3DUDim2.new(1,0,0,0),
Position=3DUDim2.new(2,0,1,0),
AnchorPoint=3DVector2.new(0,1),
AutomaticSize=3D"Y",
ImageTransparency=3D.05,
ThemeTag=3D{
ImageColor3=3D"Notification"
},

},{
b.NewRoundFrame(f.UICorner,"Glass-1",{
Size=3DUDim2.new(1,0,1,0),
ThemeTag=3D{
ImageColor3=3D"NotificationBorder",
ImageTransparency=3D"NotificationBorderTransparency",
},
}),
d("Frame",{
Size=3DUDim2.new(1,0,1,0),
BackgroundTransparency=3D1,
Name=3D"DurationFrame",
},{
d("Frame",{
Size=3DUDim2.new(1,0,1,0),
BackgroundTransparency=3D1,
ClipsDescendants=3Dtrue,
},{
m,
}),





}),
d("ImageLabel",{
Name=3D"Background",
Image=3Dh.Background,
BackgroundTransparency=3D1,
Size=3DUDim2.new(1,0,1,0),
ScaleType=3D"Crop",
ImageTransparency=3Dh.BackgroundImageTransparency

},{
d("UICorner",{
CornerRadius=3DUDim.new(0,f.UICorner),
})
}),

p,
j,l,
})

local u=3Dd("Frame",{
BackgroundTransparency=3D1,
Size=3DUDim2.new(1,0,0,0),
Parent=3Dg.Holder
},{
r
})

function h.Close(v)
if not h.Closed then
h.Closed=3Dtrue
e(u,0.45,{Size=3DUDim2.new(1,0,0,-8)},Enum.EasingStyle.Quint,Enum.EasingDir=
ection.Out):Play()
e(r,0.55,{Position=3DUDim2.new(2,0,1,0)},Enum.EasingStyle.Quint,Enum.Easing=
Direction.Out):Play()
task.wait(.45)
u:Destroy()
end
end

task.spawn(function()
task.wait()
e(u,0.45,{Size=3DUDim2.new(
1,
0,
0,
r.AbsoluteSize.Y
)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
e(r,0.45,{Position=3DUDim2.new(0,0,1,0)},Enum.EasingStyle.Quint,Enum.Easing=
Direction.Out):Play()
if h.Duration then
m.Size=3DUDim2.new(0,r.DurationFrame.AbsoluteSize.X,1,0)
e(r.DurationFrame.Frame,h.Duration,{Size=3DUDim2.new(0,0,1,0)},Enum.EasingS=
tyle.Linear,Enum.EasingDirection.InOut):Play()
task.wait(h.Duration)
h:Close()
end
end)

if l then
b.AddSignal(l.TextButton.MouseButton1Click,function()
h:Close()
end)
end


return h
end

return f end function a.f()












local b=3D4294967296;local d=3Db-1;local function c(e,f)local g,h=3D0,1;whi=
le e~=3D0 or f~=3D0 do local j,l=3De%2,f%2;local m=3D(j+l)%2;g=3Dg+m*h;e=3D=
math.floor(e/2)f=3Dmath.floor(f/2)h=3Dh*2 end;return g%b end;local function=
 k(e,f,g,...)local h;if f then e=3De%b;f=3Df%b;h=3Dc(e,f)if g then h=3Dk(h,=
g,...)end;return h elseif e then return e%b else return 0 end end;local fun=
ction n(e,f,g,...)local h;if f then e=3De%b;f=3Df%b;h=3D(e+f-c(e,f))/2;if g=
 then h=3Dn(h,g,...)end;return h elseif e then return e%b else return d end=
 end;local function o(e)return d-e end;local function q(e,f)if f&lt;0 then =
return lshift(e,-f)end;return math.floor(e%4294967296/2^f)end;local functio=
n s(e,f)if f&gt;31 or f&lt;-31 then return 0 end;return q(e%b,f)end;local f=
unction lshift(e,f)if f&lt;0 then return s(e,-f)end;return e*2^f%4294967296=
 end;local function t(e,f)e=3De%b;f=3Df%32;local g=3Dn(e,2^f-1)return s(e,f=
)+lshift(g,32-f)end;local e=3D{0x428a2f98,0x71374491,0xb5c0fbcf,0xe9b5dba5,=
0x3956c25b,0x59f111f1,0x923f82a4,0xab1c5ed5,0xd807aa98,0x12835b01,0x243185b=
e,0x550c7dc3,0x72be5d74,0x80deb1fe,0x9bdc06a7,0xc19bf174,0xe49b69c1,0xefbe4=
786,0x0fc19dc6,0x240ca1cc,0x2de92c6f,0x4a7484aa,0x5cb0a9dc,0x76f988da,0x983=
e5152,0xa831c66d,0xb00327c8,0xbf597fc7,0xc6e00bf3,0xd5a79147,0x06ca6351,0x1=
4292967,0x27b70a85,0x2e1b2138,0x4d2c6dfc,0x53380d13,0x650a7354,0x766a0abb,0=
x81c2c92e,0x92722c85,0xa2bfe8a1,0xa81a664b,0xc24b8b70,0xc76c51a3,0xd192e819=
,0xd6990624,0xf40e3585,0x106aa070,0x19a4c116,0x1e376c08,0x2748774c,0x34b0bc=
b5,0x391c0cb3,0x4ed8aa4a,0x5b9cca4f,0x682e6ff3,0x748f82ee,0x78a5636f,0x84c8=
7814,0x8cc70208,0x90befffa,0xa4506ceb,0xbef9a3f7,0xc67178f2}local function =
w(f)return string.gsub(f,".",function(g)return string.format("%02x",string.=
byte(g))end)end;local function y(f,g)local h=3D""for j=3D1,g do local l=3Df=
%256;h=3Dstring.char(l)..h;f=3D(f-l)/256 end;return h end;local function D(=
f,g)local h=3D0;for j=3Dg,g+3 do h=3Dh*256+string.byte(f,j)end;return h end=
;local function E(f,g)local h=3D64-(g+9)%64;g=3Dy(8*g,8)f=3Df.."\128"..stri=
ng.rep("\0",h)..g;assert(#f%64=3D=3D0)return f end;local function I(f)f[1]=
=3D0x6a09e667;f[2]=3D0xbb67ae85;f[3]=3D0x3c6ef372;f[4]=3D0xa54ff53a;f[5]=3D=
0x510e527f;f[6]=3D0x9b05688c;f[7]=3D0x1f83d9ab;f[8]=3D0x5be0cd19;return f e=
nd;local function K(f,g,h)local j=3D{}for l=3D1,16 do j[l]=3DD(f,g+(l-1)*4)=
end;for l=3D17,64 do local m=3Dj[l-15]local p=3Dk(t(m,7),t(m,18),s(m,3))m=
=3Dj[l-2]j[l]=3D(j[l-16]+p+j[l-7]+k(t(m,17),t(m,19),s(m,10)))%b end;local l=
,m,p,r,u,v,x,z=3Dh[1],h[2],h[3],h[4],h[5],h[6],h[7],h[8]for A=3D1,64 do loc=
al B=3Dk(t(l,2),t(l,13),t(l,22))local C=3Dk(n(l,m),n(l,p),n(m,p))local F=3D=
(B+C)%b;local G=3Dk(t(u,6),t(u,11),t(u,25))local H=3Dk(n(u,v),n(o(u),x))loc=
al J=3D(z+G+H+e[A]+j[A])%b;z=3Dx;x=3Dv;v=3Du;u=3D(r+J)%b;r=3Dp;p=3Dm;m=3Dl;=
l=3D(J+F)%b end;h[1]=3D(h[1]+l)%b;h[2]=3D(h[2]+m)%b;h[3]=3D(h[3]+p)%b;h[4]=
=3D(h[4]+r)%b;h[5]=3D(h[5]+u)%b;h[6]=3D(h[6]+v)%b;h[7]=3D(h[7]+x)%b;h[8]=3D=
(h[8]+z)%b end;local function Z(f)f=3DE(f,#f)local g=3DI{}for h=3D1,#f,64 d=
o K(f,h,g)end;return w(y(g[1],4)..y(g[2],4)..y(g[3],4)..y(g[4],4)..y(g[5],4=
)..y(g[6],4)..y(g[7],4)..y(g[8],4))end;local f;local g=3D{["\\"]=3D"\\",["\=
""]=3D"\"",["\b"]=3D"b",["\f"]=3D"f",["\n"]=3D"n",["\r"]=3D"r",["\t"]=3D"t"=
}local h=3D{["/"]=3D"/"}for j,l in pairs(g)do h[l]=3Dj end;local j=3Dfuncti=
on(j)return"\\"..(g[j]or string.format("u%04x",j:byte()))end;local l=3Dfunc=
tion(l)return"null"end;local m=3Dfunction(m,p)local r=3D{}p=3Dp or{}if p[m]=
then error"circular reference"end;p[m]=3Dtrue;if rawget(m,1)~=3Dnil or next=
(m)=3D=3Dnil then local u=3D0;for v in pairs(m)do if type(v)~=3D"number"the=
n error"invalid table: mixed or invalid key types"end;u=3Du+1 end;if u~=3D#=
m then error"invalid table: sparse array"end;for v,x in ipairs(m)do table.i=
nsert(r,f(x,p))end;p[m]=3Dnil;return"["..table.concat(r,",").."]"else for u=
,v in pairs(m)do if type(u)~=3D"string"then error"invalid table: mixed or i=
nvalid key types"end;table.insert(r,f(u,p)..":"..f(v,p))end;p[m]=3Dnil;retu=
rn"{"..table.concat(r,",").."}"end end;local p=3Dfunction(p)return'"'..p:gs=
ub('[%z\1-\31\\"]',j)..'"'end;local r=3Dfunction(r)if r~=3Dr or r&lt;=3D-ma=
th.huge or r&gt;=3Dmath.huge then error("unexpected number value '"..tostri=
ng(r).."'")end;return string.format("%.14g",r)end;local u=3D{["nil"]=3Dl,ta=
ble=3Dm,string=3Dp,number=3Dr,boolean=3Dtostring}f=3Dfunction(v,x)local z=
=3Dtype(v)local A=3Du[z]if A then return A(v,x)end;error("unexpected type '=
"..z.."'")end;local v=3Dfunction(v)return f(v)end;local x;local z=3Dfunctio=
n(...)local z=3D{}for A=3D1,select("#",...)do z[select(A,...)]=3Dtrue end;r=
eturn z end;local A=3Dz(" ","\t","\r","\n")local B=3Dz(" ","\t","\r","\n","=
]","}",",")local C=3Dz("\\","/",'"',"b","f","n","r","t","u")local F=3Dz("tr=
ue","false","null")local G=3D{["true"]=3Dtrue,["false"]=3Dfalse,null=3Dnil}=
local H=3Dfunction(H,J,L,M)for N=3DJ,#H do if L[H:sub(N,N)]~=3DM then retur=
n N end end;return#H+1 end;local J=3Dfunction(J,L,M)local N=3D1;local O=3D1=
;for P=3D1,L-1 do O=3DO+1;if J:sub(P,P)=3D=3D"\n"then N=3DN+1;O=3D1 end end=
;error(string.format("%s at line %d col %d",M,N,O))end;local L=3Dfunction(L=
)local M=3Dmath.floor;if L&lt;=3D0x7f then return string.char(L)elseif L&lt=
;=3D0x7ff then return string.char(M(L/64)+192,L%64+128)elseif L&lt;=3D0xfff=
f then return string.char(M(L/4096)+224,M(L%4096/64)+128,L%64+128)elseif L&=
lt;=3D0x10ffff then return string.char(M(L/262144)+240,M(L%262144/4096)+128=
,M(L%4096/64)+128,L%64+128)end;error(string.format("invalid unicode codepoi=
nt '%x'",L))end;local M=3Dfunction(M)local N=3Dtonumber(M:sub(1,4),16)local=
 O=3Dtonumber(M:sub(7,10),16)if O then return L((N-0xd800)*0x400+O-0xdc00+0=
x10000)else return L(N)end end;local N=3Dfunction(N,O)local P=3D""local Q=
=3DO+1;local R=3DQ;while Q&lt;=3D#N do local S=3DN:byte(Q)if S&lt;32 then J=
(N,Q,"control character in string")elseif S=3D=3D92 then P=3DP..N:sub(R,Q-1=
)Q=3DQ+1;local T=3DN:sub(Q,Q)if T=3D=3D"u"then local U=3DN:match("^[dD][89a=
AbB]%x%x\\u%x%x%x%x",Q+1)or N:match("^%x%x%x%x",Q+1)or J(N,Q-1,"invalid uni=
code escape in string")P=3DP..M(U)Q=3DQ+#U else if not C[T]then J(N,Q-1,"in=
valid escape char '"..T.."' in string")end;P=3DP..h[T]end;R=3DQ+1 elseif S=
=3D=3D34 then P=3DP..N:sub(R,Q-1)return P,Q+1 end;Q=3DQ+1 end;J(N,O,"expect=
ed closing quote for string")end;local O=3Dfunction(O,P)local Q=3DH(O,P,B)l=
ocal R=3DO:sub(P,Q-1)local S=3Dtonumber(R)if not S then J(O,P,"invalid numb=
er '"..R.."'")end;return S,Q end;local P=3Dfunction(P,Q)local R=3DH(P,Q,B)l=
ocal S=3DP:sub(Q,R-1)if not F[S]then J(P,Q,"invalid literal '"..S.."'")end;=
return G[S],R end;local Q=3Dfunction(Q,R)local S=3D{}local T=3D1;R=3DR+1;wh=
ile 1 do local U;R=3DH(Q,R,A,true)if Q:sub(R,R)=3D=3D"]"then R=3DR+1;break =
end;U,R=3Dx(Q,R)S[T]=3DU;T=3DT+1;R=3DH(Q,R,A,true)local V=3DQ:sub(R,R)R=3DR=
+1;if V=3D=3D"]"then break end;if V~=3D","then J(Q,R,"expected ']' or ','")=
end end;return S,R end;local R=3Dfunction(R,S)local T=3D{}S=3DS+1;while 1 d=
o local U,V;S=3DH(R,S,A,true)if R:sub(S,S)=3D=3D"}"then S=3DS+1;break end;i=
f R:sub(S,S)~=3D'"'then J(R,S,"expected string for key")end;U,S=3Dx(R,S)S=
=3DH(R,S,A,true)if R:sub(S,S)~=3D":"then J(R,S,"expected ':' after key")end=
;S=3DH(R,S+1,A,true)V,S=3Dx(R,S)T[U]=3DV;S=3DH(R,S,A,true)local W=3DR:sub(S=
,S)S=3DS+1;if W=3D=3D"}"then break end;if W~=3D","then J(R,S,"expected '}' =
or ','")end end;return T,S end;local S=3D{['"']=3DN,["0"]=3DO,["1"]=3DO,["2=
"]=3DO,["3"]=3DO,["4"]=3DO,["5"]=3DO,["6"]=3DO,["7"]=3DO,["8"]=3DO,["9"]=3D=
O,["-"]=3DO,t=3DP,f=3DP,n=3DP,["["]=3DQ,["{"]=3DR}x=3Dfunction(T,U)local V=
=3DT:sub(U,U)local W=3DS[V]if W then return W(T,U)end;J(T,U,"unexpected cha=
racter '"..V.."'")end;local T=3Dfunction(T)if type(T)~=3D"string"then error=
("expected argument of type string, got "..type(T))end;local U,V=3Dx(T,H(T,=
1,A,true))V=3DH(T,V,A,true)if V&lt;=3D#T then J(T,V,"trailing garbage")end;=
return U end;
local U,V,W=3Dv,T,Z;





local X=3D{}

local Y=3D(cloneref or clonereference or function(Y)return Y end)


function X.New(_,aa)

local ab=3D_;
local ac=3Daa;
local ad=3Dtrue;


local ae=3Dfunction(ae)end;


repeat task.wait(1)until game:IsLoaded();


local af=3Dfalse;
local ag,ah,ai,aj,ak,al,am,an,ao=3Dsetclipboard or toclipboard,request or h=
ttp_request or syn_request,string.char,tostring,string.sub,os.time,math.ran=
dom,math.floor,gethwid or function()return Y(game:GetService"Players").Loca=
lPlayer.UserId end
local ap,aq=3D"",0;


local ar=3D"https://api.platoboost.app";
local as=3Dah{
Url=3Dar.."/public/connectivity",
Method=3D"GET"
};
if as.StatusCode~=3D200 and as.StatusCode~=3D429 then
ar=3D"https://api.platoboost.net";
end


function cacheLink()
if aq+(600)&lt;al()then
local at=3Dah{
Url=3Dar.."/public/start",
Method=3D"POST",
Body=3DU{
service=3Dab,
identifier=3DW(ao())
},
Headers=3D{
["Content-Type"]=3D"application/json",
["User-Agent"]=3D"Roblox/Exploit"
}
};

if at.StatusCode=3D=3D200 then
local au=3DV(at.Body);

if au.success=3D=3Dtrue then
ap=3Dau.data.url;
aq=3Dal();
return true,ap
else
ae(au.message);
return false,au.message
end
elseif at.StatusCode=3D=3D429 then
local au=3D"you are being rate limited, please wait 20 seconds and try agai=
n.";
ae(au);
return false,au
end

local au=3D"Failed to cache link.";
ae(au);
return false,au
else
return true,ap
end
end

cacheLink();


local at=3Dfunction()
local at=3D""
for au=3D1,16 do
at=3Dat..ai(an(am()*(26))+97)
end
return at
end


for au=3D1,5 do
local av=3Dat();
task.wait(0.2)
if at()=3D=3Dav then
local aw=3D"platoboost nonce error.";
ae(aw);
error(aw);
end
end


local au=3Dfunction()
local au,av=3DcacheLink();

if au then
ag(av);
end
end


local av=3Dfunction(av)
local aw=3Dat();
local ax=3Dar.."/public/redeem/"..aj(ab);

local ay=3D{
identifier=3DW(ao()),
key=3Dav
}

if ad then
ay.nonce=3Daw;
end

local az=3Dah{
Url=3Dax,
Method=3D"POST",
Body=3DU(ay),
Headers=3D{
["Content-Type"]=3D"application/json"
}
};

if az.StatusCode=3D=3D200 then
local aA=3DV(az.Body);

if aA.success=3D=3Dtrue then
if aA.data.valid=3D=3Dtrue then
if ad then
if aA.data.hash=3D=3DW("true".."-"..aw.."-"..ac)then
return true
else
ae"failed to verify integrity.";
return false
end
else
return true
end
else
ae"key is invalid.";
return false
end
else
if ak(aA.message,1,27)=3D=3D"unique constraint violation"then
ae"you already have an active key, please wait for it to expire before rede=
eming it.";
return false
else
ae(aA.message);
return false
end
end
elseif az.StatusCode=3D=3D429 then
ae"you are being rate limited, please wait 20 seconds and try again.";
return false
else
ae"server returned an invalid status code, please try again later.";
return false
end
end


local aw=3Dfunction(aw)
if af=3D=3Dtrue then
return false,("A request is already being sent, please slow down.")
else
af=3Dtrue;
end

local ax=3Dat();
local ay=3Dar.."/public/whitelist/"..aj(ab).."?identifier=3D"..W(ao()).."&a=
mp;key=3D"..aw;

if ad then
ay=3Day.."&amp;nonce=3D"..ax;
end

local az=3Dah{
Url=3Day,
Method=3D"GET",
};

af=3Dfalse;

if az.StatusCode=3D=3D200 then
local aA=3DV(az.Body);

if aA.success=3D=3Dtrue then
if aA.data.valid=3D=3Dtrue then
if ad then
if aA.data.hash=3D=3DW("true".."-"..ax.."-"..ac)then
return true,""
else
return false,("failed to verify integrity.")
end
else
return true
end
else
if ak(aw,1,4)=3D=3D"KEY_"then
return true,av(aw)
else
return false,("Key is invalid.")
end
end
else
return false,(aA.message)
end
elseif az.StatusCode=3D=3D429 then
return false,("You are being rate limited, please wait 20 seconds and try a=
gain.")
else
return false,("Server returned an invalid status code, please try again lat=
er.")
end
end


local ax=3Dfunction(ax)
local ay=3Dat();
local az=3Dar.."/public/flag/"..aj(ab).."?name=3D"..ax;

if ad then
az=3Daz.."&amp;nonce=3D"..ay;
end

local aA=3Dah{
Url=3Daz,
Method=3D"GET",
};

if aA.StatusCode=3D=3D200 then
local aB=3DV(aA.Body);

if aB.success=3D=3Dtrue then
if ad then
if aB.data.hash=3D=3DW(aj(aB.data.value).."-"..ay.."-"..ac)then
return aB.data.value
else
ae"failed to verify integrity.";
return nil
end
else
return aB.data.value
end
else
ae(aB.message);
return nil
end
else
return nil
end
end


return{
Verify=3Daw,
GetFlag=3Dax,
Copy=3Dau,
}
end


return X end function a.g()






local aa=3D(cloneref or clonereference or function(aa)
return aa
end)

local ab=3Daa(game:GetService"HttpService")
local ac=3D{}

function ac.New(ad)
local ae=3Dgethwid or function()
return aa(game:GetService"Players").LocalPlayer.UserId
end
local af,ag=3Drequest or http_request or syn_request,setclipboard or toclip=
board

function ValidateKey(ah)
local ai=3D"https://new.pandadevelopment.net/api/v1/keys/validate"

local aj=3D{
ServiceID=3Dad,
HWID=3Dtostring(ae()),
Key=3Dtostring(ah),
}

local ak=3Dab:JSONEncode(aj)
local al,am=3Dpcall(function()
return af{
Url=3Dai,
Method=3D"POST",
Headers=3D{
["User-Agent"]=3D"Roblox/Exploit",
["Content-Type"]=3D"application/json",
},
Body=3Dak,
}
end)

if al and am then
if am.Success then
local an,ao=3Dpcall(function()
return ab:JSONDecode(am.Body)
end)

if an and ao then
if ao.Authenticated_Status and ao.Authenticated_Status=3D=3D"Success"then
return true,"Authenticated"
else
local ap=3Dao.Note or"Unknown reason"
return false,"Authentication failed: "..ap
end
else
return false,"JSON decode error"
end
else
warn(
" HTTP request was not successful. Code: "
..tostring(am.StatusCode)
.." Message: "
..am.StatusMessage
)
return false,"HTTP request failed: "..am.StatusMessage
end
else
return false,"Request pcall error"
end
end

function GetKeyLink()
return"https://new.pandadevelopment.net/getkey/"..tostring(ad).."?hwid=3D".=
.tostring(ae())
end

function CopyLink()
return ag(GetKeyLink())
end

return{
Verify=3DValidateKey,
Copy=3DCopyLink,
}
end

return ac end function a.h()









local aa=3D{}


function aa.New(ab,ac)
local ad=3D"https://sdkapi-public.luarmor.net/library.lua"

local ae=3Dloadstring(
game.HttpGetAsync and game:HttpGetAsync(ad)
or HttpService:GetAsync(ad)
)()
local af=3Dsetclipboard or toclipboard

ae.script_id=3Dab

function ValidateKey(ag)
local ah=3Dae.check_key(ag);


if(ah.code=3D=3D"KEY_VALID")then
return true,"Whitelisted!"

elseif(ah.code=3D=3D"KEY_HWID_LOCKED")then
return false,"Key linked to a different HWID. Please reset it using our bot=
"

elseif(ah.code=3D=3D"KEY_INCORRECT")then
return false,"Key is wrong or deleted!"
else
return false,"Key check failed:"..ah.message.." Code: "..ah.code
end
end

function CopyLink()
af(tostring(ac))
end

return{
Verify=3DValidateKey,
Copy=3DCopyLink
}
end


return aa end function a.i()








local aa=3D{}

function aa.New(ab,ac,ad)
JunkieProtected.API_KEY=3Dac
JunkieProtected.PROVIDER=3Dad
JunkieProtected.SERVICE_ID=3Dab

local function ValidateKey(ae)
if not ae or ae=3D=3D""then
print"No key provided!"

return false,"No key provided. Please get a key."
end

local af=3DJunkieProtected.IsKeylessMode()
if af and af.keyless_mode then
print"Keyless mode enabled. Starting script..."
return true,"Keyless mode enabled. Starting script..."
end

local ag=3DJunkieProtected.ValidateKey{Key=3Dae}
if ag=3D=3D"valid"then
print"Key is valid! Starting script..."
load()
if _G.JD_IsPremium then
print"Premium user detected!"
else
print"Standard user"
end

return true,"Key is valid!"
else
local ah=3DJunkieProtected.GetKeyLink()
print"Invalid key!"

return false,"Invalid key. Get one from:"..ah
end
end

local function copyLink()
local ae=3DJunkieProtected.GetKeyLink()

if setclipboard then
setclipboard(ae)
end
end
return{
Verify=3DValidateKey,
Copy=3DcopyLink
}
end

return aa end function a.j()



return{
platoboost=3D{
Name=3D"Platoboost",
Icon=3D"rbxassetid://75920162824531",
Args=3D{"ServiceId","Secret"},

New=3Da.load'f'.New
},
pandadevelopment=3D{
Name=3D"Panda Development",
Icon=3D"panda",
Args=3D{"ServiceId"},

New=3Da.load'g'.New
},
luarmor=3D{
Name=3D"Luarmor",
Icon=3D"rbxassetid://130918283130165",
Args=3D{"ScriptId","Discord"},

New=3Da.load'h'.New
},
junkiedevelopment=3D{
Name=3D"Junkie Development",
Icon=3D"rbxassetid://106310347705078",
Args=3D{"ServiceId","ApiKey","Provider"},

New=3Da.load'i'.New
},


}end function a.k()



return[[
{
    "name": "windui",
    "version": "1.6.65",
    "main": "./dist/main.lua",
    "repository": "https://github.com/Footagesus/WindUI",
    "discord": "https://discord.gg/ftgs-development-hub-1300692552005189632=
",
    "author": "Footagesus",
    "description": "Roblox UI Library for scripts",
    "license": "MIT",
    "scripts": {
        "dev": "bash build/build.sh dev $INPUT_FILE",
        "build": "bash build/build.sh build $INPUT_FILE",
        "live": "python3 -m http.server 8642",
        "watch": "chokidar . -i 'node_modules' -i 'dist' -i 'build' -c 'npm=
 run dev --'",
        "live-build": "concurrently \"npm run live\" \"npm run watch --\"",
        "example-live-build": "INPUT_FILE=3Dmain_example.lua npm run live-b=
uild",
        "updater": "python3 updater/main.py"
    },
    "keywords": [
        "ui-library",
        "ui-design",
        "script",
        "script-hub",
        "exploiting"
    ],
    "devDependencies": {
        "chokidar-cli": "^3.0.0",
        "concurrently": "^9.2.0"
    }
}
]]end function a.l()

local aa=3D{}

local ab=3Da.load'c'
local ac=3Dab.New
local ad=3Dab.Tween

function aa.New(ae,af,ag,ah,ai,aj,ak,al)
ah=3Dah or"Primary"
local am=3Dal or(not ak and 10 or 99)
local an
if af and af~=3D""then
an=3Dac("ImageLabel",{
Image=3Dab.Icon(af)[1],
ImageRectSize=3Dab.Icon(af)[2].ImageRectSize,
ImageRectOffset=3Dab.Icon(af)[2].ImageRectPosition,
Size=3DUDim2.new(0,21,0,21),
BackgroundTransparency=3D1,
ImageColor3=3Dah=3D=3D"White"and Color3.new(0,0,0)or nil,
ImageTransparency=3Dah=3D=3D"White"and 0.4 or 0,
ThemeTag=3D{
ImageColor3=3Dah~=3D"White"and"Icon"or nil,
},
})
end

local ao=3Dac("TextButton",{
Size=3DUDim2.new(0,0,1,0),
AutomaticSize=3D"X",
Parent=3Dai,
BackgroundTransparency=3D1,
},{
ab.NewRoundFrame(am,"Squircle",{
ThemeTag=3D{
ImageColor3=3Dah~=3D"White"and"Button"or nil,
},
ImageColor3=3Dah=3D=3D"White"and Color3.new(1,1,1)or nil,
Size=3DUDim2.new(1,0,1,0),
Name=3D"Squircle",
ImageTransparency=3Dah=3D=3D"Primary"and 0 or ah=3D=3D"White"and 0 or 0.9,
}),

ab.NewRoundFrame(am,"Squircle",{



ImageColor3=3DColor3.new(1,1,1),
Size=3DUDim2.new(1,0,1,0),
Name=3D"Special",
ImageTransparency=3Dah=3D=3D"Secondary"and 0.95 or 1,
}),

ab.NewRoundFrame(am,"Shadow-sm",{



ImageColor3=3DColor3.new(0,0,0),
Size=3DUDim2.new(1,3,1,3),
AnchorPoint=3DVector2.new(0.5,0.5),
Position=3DUDim2.new(0.5,0,0.5,0),
Name=3D"Shadow",

ImageTransparency=3D1,
Visible=3Dnot ak,
}),

ab.NewRoundFrame(am,not ak and"Glass-1"or"Glass-0.7",{
ThemeTag=3D{
ImageColor3=3D"White",
},
Size=3DUDim2.new(1,0,1,0),

ImageTransparency=3D0.6,
Name=3D"Outline",
},{













}),

ab.NewRoundFrame(am,"Squircle",{
Size=3DUDim2.new(1,0,1,0),
Name=3D"Frame",
ThemeTag=3D{
ImageColor3=3Dah~=3D"White"and"Text"or nil,
},
ImageColor3=3Dah=3D=3D"White"and Color3.new(0,0,0)or nil,
ImageTransparency=3D1,
},{
ac("UIPadding",{
PaddingLeft=3DUDim.new(0,16),
PaddingRight=3DUDim.new(0,16),
}),
ac("UIListLayout",{
FillDirection=3D"Horizontal",
Padding=3DUDim.new(0,8),
VerticalAlignment=3D"Center",
HorizontalAlignment=3D"Center",
}),
an,
ac("TextLabel",{
BackgroundTransparency=3D1,
FontFace=3DFont.new(ab.Font,Enum.FontWeight.SemiBold),
Text=3Dae or"Button",
ThemeTag=3D{
TextColor3=3D(ah~=3D"Primary"and ah~=3D"White")and"Text",
},
TextColor3=3Dah=3D=3D"Primary"and Color3.new(1,1,1)
or ah=3D=3D"White"and Color3.new(0,0,0)
or nil,
AutomaticSize=3D"XY",
TextSize=3D18,
}),
}),
})

ab.AddSignal(ao.MouseEnter,function()
ad(ao.Frame,0.047,{ImageTransparency=3D0.95}):Play()
end)
ab.AddSignal(ao.MouseLeave,function()
ad(ao.Frame,0.047,{ImageTransparency=3D1}):Play()
end)
ab.AddSignal(ao.MouseButton1Up,function()
if aj then
aj:Close()()
end
if ag then
ab.SafeCallback(ag)
end
end)

return ao
end

return aa end function a.m()

local aa=3D{}

local ab=3Da.load'c'
local ac=3Dab.New local ad=3D
ab.Tween


function aa.New(ae,af,ag,ah,ai,aj,ak,al)
ah=3Dah or"Input"
local am=3Dak or 10
local an
if af and af~=3D""then
an=3Dac("ImageLabel",{
Image=3Dab.Icon(af)[1],
ImageRectSize=3Dab.Icon(af)[2].ImageRectSize,
ImageRectOffset=3Dab.Icon(af)[2].ImageRectPosition,
Size=3DUDim2.new(0,21,0,21),
BackgroundTransparency=3D1,
ThemeTag=3D{
ImageColor3=3D"Icon",
}
})
end

local ao=3Dah~=3D"Input"

local ap=3Dac("TextBox",{
BackgroundTransparency=3D1,
TextSize=3D17,
FontFace=3DFont.new(ab.Font,Enum.FontWeight.Regular),
Size=3DUDim2.new(1,an and-29 or 0,1,0),
PlaceholderText=3Dae,
ClearTextOnFocus=3Dal or false,
ClipsDescendants=3Dtrue,
TextWrapped=3Dao,
MultiLine=3Dao,
TextXAlignment=3D"Left",
TextYAlignment=3Dah=3D=3D"Input"and"Center"or"Top",

ThemeTag=3D{
PlaceholderColor3=3D"PlaceholderText",
TextColor3=3D"Text",
},
})

local aq=3Dac("Frame",{
Size=3DUDim2.new(1,0,0,42),
Parent=3Dag,
BackgroundTransparency=3D1
},{
ac("Frame",{
Size=3DUDim2.new(1,0,1,0),
BackgroundTransparency=3D1,
},{
ab.NewRoundFrame(am,"Squircle",{
ThemeTag=3D{
ImageColor3=3D"Accent",
},
Size=3DUDim2.new(1,0,1,0),
ImageTransparency=3D.97,
}),
ab.NewRoundFrame(am,"Glass-1",{
ThemeTag=3D{
ImageColor3=3D"Outline",
},
Size=3DUDim2.new(1,0,1,0),
ImageTransparency=3D.75,
},{













}),
ab.NewRoundFrame(am,"Squircle",{
Size=3DUDim2.new(1,0,1,0),
Name=3D"Frame",
ImageColor3=3DColor3.new(1,1,1),
ImageTransparency=3D.95
},{
ac("UIPadding",{
PaddingTop=3DUDim.new(0,ah=3D=3D"Input"and 0 or 12),
PaddingLeft=3DUDim.new(0,12),
PaddingRight=3DUDim.new(0,12),
PaddingBottom=3DUDim.new(0,ah=3D=3D"Input"and 0 or 12),
}),
ac("UIListLayout",{
FillDirection=3D"Horizontal",
Padding=3DUDim.new(0,8),
VerticalAlignment=3Dah=3D=3D"Input"and"Center"or"Top",
HorizontalAlignment=3D"Left",
}),
an,
ap,
})
})
})










if aj then
ab.AddSignal(ap:GetPropertyChangedSignal"Text",function()
if ai then
ab.SafeCallback(ai,ap.Text)
end
end)
else
ab.AddSignal(ap.FocusLost,function()
if ai then
ab.SafeCallback(ai,ap.Text)
end
end)
end

return aq
end


return aa end function a.n()
local aa=3Da.load'c'
local ab=3Daa.New
local ac=3Daa.Tween




local ad=3D{
Holder=3Dnil,

Parent=3Dnil,
}


function ad.Create(ae,af,ag,ah,ai)
local aj=3D{
UICorner=3D28,
UIPadding=3D12,

Window=3Dag,
WindUI=3Dah,

UIElements=3D{},
}

if ae then
aj.UIPadding=3D0
end
if ae then
aj.UICorner=3D26
end

af=3Daf or"Dialog"

if not ae then
aj.UIElements.FullScreen=3Dab("Frame",{
ZIndex=3D999,
BackgroundTransparency=3D1,
BackgroundColor3=3DColor3.fromHex"#000000",
Size=3DUDim2.new(1,0,1,0),
Active=3Dfalse,
Visible=3Dfalse,
Parent=3Dad.Parent
or(ag and ag.UIElements and ag.UIElements.Main and ag.UIElements.Main.Main)=
,
},{
ab("UICorner",{
CornerRadius=3DUDim.new(0,ag.UICorner),
}),
})
end

ab("ImageLabel",{
Image=3D"rbxassetid://8992230677",
ThemeTag=3D{
ImageColor3=3D"WindowShadow",

},
ImageTransparency=3D1,
Size=3DUDim2.new(1,100,1,100),
Position=3DUDim2.new(0,-50,0,-50),
ScaleType=3D"Slice",
SliceCenter=3DRect.new(99,99,99,99),
BackgroundTransparency=3D1,
ZIndex=3D-999999999999999,
Name=3D"Blur",
})

aj.UIElements.Main=3Dab("Frame",{
Size=3DUDim2.new(0,280,0,0),
ThemeTag=3D{
BackgroundColor3=3Daf.."Background",
},
AutomaticSize=3D"Y",
BackgroundTransparency=3D1,
Visible=3Dfalse,
ZIndex=3D99999,
},{
ab("UIPadding",{
PaddingTop=3DUDim.new(0,aj.UIPadding),
PaddingLeft=3DUDim.new(0,aj.UIPadding),
PaddingRight=3DUDim.new(0,aj.UIPadding),
PaddingBottom=3DUDim.new(0,aj.UIPadding),
}),
})

aj.UIElements.MainContainer=3Daa.NewRoundFrame(aj.UICorner,"Squircle",{
Visible=3Dfalse,

ImageTransparency=3Dae and 0.15 or 0,
Parent=3Dai or aj.UIElements.FullScreen,
Position=3DUDim2.new(0.5,0,0.5,0),
AnchorPoint=3DVector2.new(0.5,0.5),
AutomaticSize=3D"XY",
ThemeTag=3D{
ImageColor3=3Daf.."Background",
ImageTransparency=3Daf.."BackgroundTransparency",
},
ZIndex=3D9999,
},{
aa.NewRoundFrame(aj.UICorner,"Glass-1",{
ImageTransparency=3D0.89,
Size=3DUDim2.new(1,0,1,0)
}),
aj.UIElements.Main,




















})

function aj.Open(ak)
if not ae then
aj.UIElements.FullScreen.Visible=3Dtrue
aj.UIElements.FullScreen.Active=3Dtrue
end

task.spawn(function()
aj.UIElements.MainContainer.Visible=3Dtrue

if not ae then
ac(aj.UIElements.FullScreen,0.1,{BackgroundTransparency=3D0.3}):Play()
end
ac(aj.UIElements.MainContainer,0.1,{ImageTransparency=3D0}):Play()


task.spawn(function()
task.wait(0.05)
aj.UIElements.Main.Visible=3Dtrue
end)
end)
end
function aj.Close(ak)
if not ae then
ac(aj.UIElements.FullScreen,0.1,{BackgroundTransparency=3D1}):Play()
aj.UIElements.FullScreen.Active=3Dfalse
task.spawn(function()
task.wait(0.1)
aj.UIElements.FullScreen.Visible=3Dfalse
end)
end
aj.UIElements.Main.Visible=3Dfalse

ac(aj.UIElements.MainContainer,0.1,{ImageTransparency=3D1}):Play()



task.spawn(function()
task.wait(0.1)
if not ae then
aj.UIElements.FullScreen:Destroy()
else
aj.UIElements.MainContainer:Destroy()
end
end)

return function()end
end


return aj
end

return ad end function a.o()
local aa=3D{}

local ab=3Da.load'c'
local ac=3Dab.New
local ad=3Dab.Tween

local ae=3Da.load'l'.New
local af=3Da.load'm'.New

function aa.new(ag,ah,ai,aj)
local ak=3Da.load'n'
local al=3Dak.Create(true,"Popup",ag.Window,ag.WindUI,ag.WindUI.ScreenGui.K=
eySystem)

local am=3D{}

local an

local ao=3D(ag.KeySystem.Thumbnail and ag.KeySystem.Thumbnail.Width)or 200

local ap=3D430
if ag.KeySystem.Thumbnail and ag.KeySystem.Thumbnail.Image then
ap=3D430+(ao/2)
end

al.UIElements.Main.AutomaticSize=3D"Y"
al.UIElements.Main.Size=3DUDim2.new(0,ap,0,0)

local aq

if ag.Icon then
aq=3D
ab.Image(ag.Icon,ag.Title..":"..ag.Icon,0,"Temp","KeySystem",ag.IconThemed)
aq.Size=3DUDim2.new(0,24,0,24)
aq.LayoutOrder=3D-1
end

local ar=3Dac("TextLabel",{
AutomaticSize=3D"XY",
BackgroundTransparency=3D1,
Text=3Dag.KeySystem.Title or ag.Title,
FontFace=3DFont.new(ab.Font,Enum.FontWeight.SemiBold),
ThemeTag=3D{
TextColor3=3D"Text",
},
TextSize=3D20,
})

local as=3Dac("TextLabel",{
AutomaticSize=3D"XY",
BackgroundTransparency=3D1,
Text=3D"Key System",
AnchorPoint=3DVector2.new(1,0.5),
Position=3DUDim2.new(1,0,0.5,0),
TextTransparency=3D1,
FontFace=3DFont.new(ab.Font,Enum.FontWeight.Medium),
ThemeTag=3D{
TextColor3=3D"Text",
},
TextSize=3D16,
})

local at=3Dac("Frame",{
BackgroundTransparency=3D1,
AutomaticSize=3D"XY",
},{
ac("UIListLayout",{
Padding=3DUDim.new(0,14),
FillDirection=3D"Horizontal",
VerticalAlignment=3D"Center",
}),
aq,
ar,
})

local au=3Dac("Frame",{
AutomaticSize=3D"Y",
Size=3DUDim2.new(1,0,0,0),
BackgroundTransparency=3D1,
},{





at,
as,
})

local av=3Daf("Enter Key","key",nil,"Input",function(av)
an=3Dav
end)

local aw
if ag.KeySystem.Note and ag.KeySystem.Note~=3D""then
aw=3Dac("TextLabel",{
Size=3DUDim2.new(1,0,0,0),
AutomaticSize=3D"Y",
FontFace=3DFont.new(ab.Font,Enum.FontWeight.Medium),
TextXAlignment=3D"Left",
Text=3Dag.KeySystem.Note,
TextSize=3D18,
TextTransparency=3D0.4,
ThemeTag=3D{
TextColor3=3D"Text",
},
BackgroundTransparency=3D1,
RichText=3Dtrue,
TextWrapped=3Dtrue,
})
end

local ax=3Dac("Frame",{
Size=3DUDim2.new(1,0,0,42),
BackgroundTransparency=3D1,
},{
ac("Frame",{
BackgroundTransparency=3D1,
AutomaticSize=3D"X",
Size=3DUDim2.new(0,0,1,0),
},{
ac("UIListLayout",{
Padding=3DUDim.new(0,9),
FillDirection=3D"Horizontal",
}),
}),
})

local ay
if ag.KeySystem.Thumbnail and ag.KeySystem.Thumbnail.Image then
local az
if ag.KeySystem.Thumbnail.Title then
az=3Dac("TextLabel",{
Text=3Dag.KeySystem.Thumbnail.Title,
ThemeTag=3D{
TextColor3=3D"Text",
},
TextSize=3D18,
FontFace=3DFont.new(ab.Font,Enum.FontWeight.Medium),
BackgroundTransparency=3D1,
AutomaticSize=3D"XY",
AnchorPoint=3DVector2.new(0.5,0.5),
Position=3DUDim2.new(0.5,0,0.5,0),
})
end
ay=3Dac("ImageLabel",{
Image=3Dag.KeySystem.Thumbnail.Image,
BackgroundTransparency=3D1,
Size=3DUDim2.new(0,ao,1,-12),
Position=3DUDim2.new(0,6,0,6),
Parent=3Dal.UIElements.Main,
ScaleType=3D"Crop",
},{
az,
ac("UICorner",{
CornerRadius=3DUDim.new(0,20),
}),
})
end

ac("Frame",{

Size=3DUDim2.new(1,ay and-ao or 0,1,0),
Position=3DUDim2.new(0,ay and ao or 0,0,0),
BackgroundTransparency=3D1,
Parent=3Dal.UIElements.Main,
},{
ac("Frame",{

Size=3DUDim2.new(1,0,1,0),
BackgroundTransparency=3D1,
},{
ac("UIListLayout",{
Padding=3DUDim.new(0,18),
FillDirection=3D"Vertical",
}),
au,
aw,
av,
ax,
ac("UIPadding",{
PaddingTop=3DUDim.new(0,16),
PaddingLeft=3DUDim.new(0,16),
PaddingRight=3DUDim.new(0,16),
PaddingBottom=3DUDim.new(0,16),
}),
}),
})





local az=3Dae("Exit","log-out",function()
al:Close()()
end,"Tertiary",ax.Frame)

if ay then
az.Parent=3Day
az.Size=3DUDim2.new(0,0,0,42)
az.Position=3DUDim2.new(0,10,1,-10)
az.AnchorPoint=3DVector2.new(0,1)
end

if ag.KeySystem.URL then
ae("Get key","key",function()
setclipboard(ag.KeySystem.URL)
end,"Secondary",ax.Frame)
end

if ag.KeySystem.API then








local aA=3D240
local aB=3Dfalse
local b=3Dae("Get key","key",nil,"Secondary",ax.Frame)

local d=3Dab.NewRoundFrame(99,"Squircle",{
Size=3DUDim2.new(0,1,1,0),
ThemeTag=3D{
ImageColor3=3D"Text",
},
ImageTransparency=3D0.9,
})

ac("Frame",{
BackgroundTransparency=3D1,
Size=3DUDim2.new(0,0,1,0),
AutomaticSize=3D"X",
Parent=3Db.Frame,
},{
d,
ac("UIPadding",{
PaddingLeft=3DUDim.new(0,5),
PaddingRight=3DUDim.new(0,5),
}),
})

local f=3Dab.Image("chevron-down","chevron-down",0,"Temp","KeySystem",true)

f.Size=3DUDim2.new(1,0,1,0)

ac("Frame",{
Size=3DUDim2.new(0,21,0,21),
Parent=3Db.Frame,
BackgroundTransparency=3D1,
},{
f,
})

local g=3Dab.NewRoundFrame(15,"Squircle",{
Size=3DUDim2.new(1,0,0,0),
AutomaticSize=3D"Y",
ThemeTag=3D{
ImageColor3=3D"Background",
},
},{
ac("UIPadding",{
PaddingTop=3DUDim.new(0,5),
PaddingLeft=3DUDim.new(0,5),
PaddingRight=3DUDim.new(0,5),
PaddingBottom=3DUDim.new(0,5),
}),
ac("UIListLayout",{
FillDirection=3D"Vertical",
Padding=3DUDim.new(0,5),
}),
})

local h=3Dac("Frame",{
BackgroundTransparency=3D1,
Size=3DUDim2.new(0,aA,0,0),
ClipsDescendants=3Dtrue,
AnchorPoint=3DVector2.new(1,0),
Parent=3Db,
Position=3DUDim2.new(1,0,1,15),
},{
g,
})

ac("TextLabel",{
Text=3D"Select Service",
BackgroundTransparency=3D1,
FontFace=3DFont.new(ab.Font,Enum.FontWeight.Medium),
ThemeTag=3D{TextColor3=3D"Text"},
TextTransparency=3D0.2,
TextSize=3D16,
Size=3DUDim2.new(1,0,0,0),
AutomaticSize=3D"Y",
TextWrapped=3Dtrue,
TextXAlignment=3D"Left",
Parent=3Dg,
},{
ac("UIPadding",{
PaddingTop=3DUDim.new(0,10),
PaddingLeft=3DUDim.new(0,10),
PaddingRight=3DUDim.new(0,10),
PaddingBottom=3DUDim.new(0,10),
}),
})

for j,l in next,ag.KeySystem.API do
local m=3Dag.WindUI.Services[l.Type]
if m then
local p=3D{}
for r,u in next,m.Args do
table.insert(p,l[u])
end

local r=3Dm.New(table.unpack(p))
r.Type=3Dl.Type
table.insert(am,r)

local u=3Dab.Image(
l.Icon or m.Icon or Icons[l.Type]or"user",
l.Icon or m.Icon or Icons[l.Type]or"user",
0,
"Temp",
"KeySystem",
true
)
u.Size=3DUDim2.new(0,24,0,24)

local v=3Dab.NewRoundFrame(10,"Squircle",{
Size=3DUDim2.new(1,0,0,0),
ThemeTag=3D{ImageColor3=3D"Text"},
ImageTransparency=3D1,
Parent=3Dg,
AutomaticSize=3D"Y",
},{
ac("UIListLayout",{
FillDirection=3D"Horizontal",
Padding=3DUDim.new(0,10),
VerticalAlignment=3D"Center",
}),
u,
ac("UIPadding",{
PaddingTop=3DUDim.new(0,10),
PaddingLeft=3DUDim.new(0,10),
PaddingRight=3DUDim.new(0,10),
PaddingBottom=3DUDim.new(0,10),
}),
ac("Frame",{
BackgroundTransparency=3D1,
Size=3DUDim2.new(1,-34,0,0),
AutomaticSize=3D"Y",
},{
ac("UIListLayout",{
FillDirection=3D"Vertical",
Padding=3DUDim.new(0,5),
HorizontalAlignment=3D"Center",
}),
ac("TextLabel",{
Text=3Dl.Title or m.Name,
BackgroundTransparency=3D1,
FontFace=3DFont.new(ab.Font,Enum.FontWeight.Medium),
ThemeTag=3D{TextColor3=3D"Text"},
TextTransparency=3D0.05,
TextSize=3D18,
Size=3DUDim2.new(1,0,0,0),
AutomaticSize=3D"Y",
TextWrapped=3Dtrue,
TextXAlignment=3D"Left",
}),
ac("TextLabel",{
Text=3Dl.Desc or"",
BackgroundTransparency=3D1,
FontFace=3DFont.new(ab.Font,Enum.FontWeight.Regular),
ThemeTag=3D{TextColor3=3D"Text"},
TextTransparency=3D0.2,
TextSize=3D16,
Size=3DUDim2.new(1,0,0,0),
AutomaticSize=3D"Y",
TextWrapped=3Dtrue,
Visible=3Dl.Desc and true or false,
TextXAlignment=3D"Left",
}),
}),
},true)

ab.AddSignal(v.MouseEnter,function()
ad(v,0.08,{ImageTransparency=3D0.95}):Play()
end)
ab.AddSignal(v.InputEnded,function()
ad(v,0.08,{ImageTransparency=3D1}):Play()
end)
ab.AddSignal(v.MouseButton1Click,function()
r.Copy()
ag.WindUI:Notify{
Title=3D"Key System",
Content=3D"Key link copied to clipboard.",
Image=3D"key",
}
end)
end
end

ab.AddSignal(b.MouseButton1Click,function()
if not aB then
ad(
h,
0.3,
{Size=3DUDim2.new(0,aA,0,g.AbsoluteSize.Y+1)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
ad(f,0.3,{Rotation=3D180},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):=
Play()
else
ad(
h,
0.25,
{Size=3DUDim2.new(0,aA,0,0)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
ad(f,0.25,{Rotation=3D0},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):P=
lay()
end
aB=3Dnot aB
end)
end

local function handleSuccess(aA)
al:Close()()
writefile((ag.Folder or"Temp").."/"..ah..".key",tostring(aA))
task.wait(0.4)
ai(true)
end

local aA=3Dae("Submit","arrow-right",function()
local aA=3Dtostring(an or"empty")local aB=3D
ag.Folder or ag.Title

if ag.KeySystem.KeyValidator then
local b=3Dag.KeySystem.KeyValidator(aA)

if b then
if ag.KeySystem.SaveKey then
handleSuccess(aA)
else
al:Close()()
task.wait(0.4)
ai(true)
end
else
ag.WindUI:Notify{
Title=3D"Key System. Error",
Content=3D"Invalid key.",
Icon=3D"triangle-alert",
}
end
elseif not ag.KeySystem.API then
local b=3Dtype(ag.KeySystem.Key)=3D=3D"table"and table.find(ag.KeySystem.Ke=
y,aA)
or ag.KeySystem.Key=3D=3DaA

if b then
if ag.KeySystem.SaveKey then
handleSuccess(aA)
else
al:Close()()
task.wait(0.4)
ai(true)
end
end
else
local b,d
for f,g in next,am do
local h,j=3Dg.Verify(aA)
if h then
b,d=3Dtrue,j
break
end
d=3Dj
end

if b then
handleSuccess(aA)
else
ag.WindUI:Notify{
Title=3D"Key System. Error",
Content=3Dd,
Icon=3D"triangle-alert",
}
end
end
end,"Primary",ax)

aA.AnchorPoint=3DVector2.new(1,0.5)
aA.Position=3DUDim2.new(1,0,0.5,0)










al:Open()
end

return aa end function a.p()




local aa=3D(cloneref or clonereference or function(aa)return aa end)


local function map(ab,ac,ad,ae,af)
return(ab-ac)*(af-ae)/(ad-ac)+ae
end

local function viewportPointToWorld(ab,ac)
local ad=3Daa(game:GetService"Workspace").CurrentCamera:ScreenPointToRay(ab=
.X,ab.Y)
return ad.Origin+ad.Direction*ac
end

local function getOffset()
local ab=3Daa(game:GetService"Workspace").CurrentCamera.ViewportSize.Y
return map(ab,0,2560,8,56)
end

return{viewportPointToWorld,getOffset}end function a.q()



local aa=3D(cloneref or clonereference or function(aa)
return aa
end)

local ab=3Da.load'c'
local ac=3Dab.New

local ad,ae=3Dunpack(a.load'p')
local af=3DInstance.new("Folder",aa(game:GetService"Workspace").CurrentCame=
ra)

local function createAcrylic()
local ag=3Dac("Part",{
Name=3D"Body",
Color=3DColor3.new(0,0,0),
Material=3DEnum.Material.Glass,
Size=3DVector3.new(1,1,0),
Anchored=3Dtrue,
CanCollide=3Dfalse,
Locked=3Dtrue,
CastShadow=3Dfalse,
Transparency=3D0.98,
},{
ac("SpecialMesh",{
MeshType=3DEnum.MeshType.Brick,
Offset=3DVector3.new(0,0,-1E-6),
}),
})

return ag
end

local function createAcrylicBlur(ag)
local ah=3D{}

ag=3Dag or 0.001
local ai=3D{
topLeft=3DVector2.new(),
topRight=3DVector2.new(),
bottomRight=3DVector2.new(),
}
local aj=3DcreateAcrylic()
aj.Parent=3Daf

local function updatePositions(ak,al)
ai.topLeft=3Dal
ai.topRight=3Dal+Vector2.new(ak.X,0)
ai.bottomRight=3Dal+ak
end

local function render()
local ak=3Daa(game:GetService"Workspace").CurrentCamera
if ak then
ak=3Dak.CFrame
end
local al=3Dak
if not al then
al=3DCFrame.new()
end

local am=3Dal
local an=3Dai.topLeft
local ao=3Dai.topRight
local ap=3Dai.bottomRight

local aq=3Dad(an,ag)
local ar=3Dad(ao,ag)
local as=3Dad(ap,ag)

local at=3D(ar-aq).Magnitude
local au=3D(ar-as).Magnitude

if aj and aj.Parent and aj:FindFirstChild"Mesh"and aj.Mesh.Parent and aj.Me=
sh.Scale then
aj.CFrame=3D
CFrame.fromMatrix((aq+as)/2,am.XVector,am.YVector,am.ZVector)
aj.Mesh.Scale=3DVector3.new(at,au,0)
end
end

local function onChange(ak)
local al=3Dae()
local am=3Dak.AbsoluteSize-Vector2.new(al,al)
local an=3Dak.AbsolutePosition+Vector2.new(al/2,al/2)

updatePositions(am,an)
task.spawn(render)
end

local function renderOnChange()
local ak=3Daa(game:GetService"Workspace").CurrentCamera
if not ak then
return
end

table.insert(ah,ak:GetPropertyChangedSignal"CFrame":Connect(render))
table.insert(ah,ak:GetPropertyChangedSignal"ViewportSize":Connect(render))
table.insert(ah,ak:GetPropertyChangedSignal"FieldOfView":Connect(render))
task.spawn(render)
end

aj.Destroying:Connect(function()
for ak,al in ah do
pcall(function()
al:Disconnect()
end)
end
end)

renderOnChange()

return onChange,aj
end

return function(ag)
local ah=3D{}
local ai,aj=3DcreateAcrylicBlur(ag)

local ak=3Dac("Frame",{
BackgroundTransparency=3D1,
Size=3DUDim2.fromScale(1,1),
})

ab.AddSignal(ak:GetPropertyChangedSignal"AbsolutePosition",function()
ai(ak)
end)

ab.AddSignal(ak:GetPropertyChangedSignal"AbsoluteSize",function()
ai(ak)
end)

ah.AddParent=3Dfunction(al)
ab.AddSignal(al:GetPropertyChangedSignal"Visible",function()

end)
end

ah.SetVisibility=3Dfunction(al)
aj.Transparency=3Dal and 0.98 or 1
end

ah.Frame=3Dak
ah.Model=3Daj

return ah
end end function a.r()



local aa=3Da.load'c'
local ab=3Da.load'q'

local ac=3Daa.New

return function(ad)
local ae=3D{}

ae.Frame=3Dac("Frame",{
Size=3DUDim2.fromScale(1,1),
BackgroundTransparency=3D1,
BackgroundColor3=3DColor3.fromRGB(255,255,255),
BorderSizePixel=3D0,
},{












ac("UICorner",{
CornerRadius=3DUDim.new(0,8),
}),

ac("Frame",{
BackgroundTransparency=3D1,
Size=3DUDim2.fromScale(1,1),
Name=3D"Background",
ThemeTag=3D{
BackgroundColor3=3D"AcrylicMain",
},
},{
ac("UICorner",{
CornerRadius=3DUDim.new(0,8),
}),
}),

ac("Frame",{
BackgroundColor3=3DColor3.fromRGB(255,255,255),
BackgroundTransparency=3D1,
Size=3DUDim2.fromScale(1,1),
},{










}),

ac("ImageLabel",{
Image=3D"rbxassetid://9968344105",
ImageTransparency=3D0.98,
ScaleType=3DEnum.ScaleType.Tile,
TileSize=3DUDim2.new(0,128,0,128),
Size=3DUDim2.fromScale(1,1),
BackgroundTransparency=3D1,
},{
ac("UICorner",{
CornerRadius=3DUDim.new(0,8),
}),
}),

ac("ImageLabel",{
Image=3D"rbxassetid://9968344227",
ImageTransparency=3D0.9,
ScaleType=3DEnum.ScaleType.Tile,
TileSize=3DUDim2.new(0,128,0,128),
Size=3DUDim2.fromScale(1,1),
BackgroundTransparency=3D1,
ThemeTag=3D{
ImageTransparency=3D"AcrylicNoise",
},
},{
ac("UICorner",{
CornerRadius=3DUDim.new(0,8),
}),
}),

ac("Frame",{
BackgroundTransparency=3D1,
Size=3DUDim2.fromScale(1,1),
ZIndex=3D2,
},{










}),
})


local af

task.wait()
if ad.UseAcrylic then
af=3Dab()

af.Frame.Parent=3Dae.Frame
ae.Model=3Daf.Model
ae.AddParent=3Daf.AddParent
ae.SetVisibility=3Daf.SetVisibility
end

return ae,af
end end function a.s()



local aa=3D(cloneref or clonereference or function(aa)return aa end)


local ab=3D{
AcrylicBlur=3Da.load'q',

AcrylicPaint=3Da.load'r',
}

function ab.init()
local ac=3DInstance.new"DepthOfFieldEffect"
ac.FarIntensity=3D0
ac.InFocusRadius=3D0.1
ac.NearIntensity=3D1

local ad=3D{}

function ab.Enable()
for ae,af in pairs(ad)do
af.Enabled=3Dfalse
end
ac.Parent=3Daa(game:GetService"Lighting")
end

function ab.Disable()
for ae,af in pairs(ad)do
af.Enabled=3Daf.enabled
end
ac.Parent=3Dnil
end

local function registerDefaults()
local function register(ae)
if ae:IsA"DepthOfFieldEffect"then
ad[ae]=3D{enabled=3Dae.Enabled}
end
end

for ae,af in pairs(aa(game:GetService"Lighting"):GetChildren())do
register(af)
end

if aa(game:GetService"Workspace").CurrentCamera then
for ae,af in pairs(aa(game:GetService"Workspace").CurrentCamera:GetChildren=
())do
register(af)
end
end
end

registerDefaults()
ab.Enable()
end

return ab end function a.t()

local aa=3D{}

local ab=3Da.load'c'
local ac=3Dab.New local ad=3D
ab.Tween


function aa.new(ae,af)
local ag=3D{
Title=3Dae.Title or"Dialog",
Content=3Dae.Content,
Icon=3Dae.Icon,
IconThemed=3Dae.IconThemed,
Thumbnail=3Dae.Thumbnail,
Buttons=3Dae.Buttons,

IconSize=3D22,
}

local ah=3Da.load'n'
local ai=3Dah.Create(true,"Popup",ae.WindUI.Window,ae.WindUI,af)

local aj=3D200

local ak=3D430
if ag.Thumbnail and ag.Thumbnail.Image then
ak=3D430+(aj/2)
end

ai.UIElements.Main.AutomaticSize=3D"Y"
ai.UIElements.Main.Size=3DUDim2.new(0,ak,0,0)



local al

if ag.Icon then
al=3Dab.Image(
ag.Icon,
ag.Title..":"..ag.Icon,
0,
ae.WindUI.Window,
"Popup",
true,
ae.IconThemed,
"PopupIcon"
)
al.Size=3DUDim2.new(0,ag.IconSize,0,ag.IconSize)
al.LayoutOrder=3D-1
end


local am=3Dac("TextLabel",{
AutomaticSize=3D"Y",
BackgroundTransparency=3D1,
Text=3Dag.Title,
TextXAlignment=3D"Left",
FontFace=3DFont.new(ab.Font,Enum.FontWeight.SemiBold),
ThemeTag=3D{
TextColor3=3D"PopupTitle",
},
TextSize=3D20,
TextWrapped=3Dtrue,
Size=3DUDim2.new(1,al and-ag.IconSize-14 or 0,0,0)
})

local an=3Dac("Frame",{
BackgroundTransparency=3D1,
AutomaticSize=3D"XY",
},{
ac("UIListLayout",{
Padding=3DUDim.new(0,14),
FillDirection=3D"Horizontal",
VerticalAlignment=3D"Center"
}),
al,am
})

local ao=3Dac("Frame",{
AutomaticSize=3D"Y",
Size=3DUDim2.new(1,0,0,0),
BackgroundTransparency=3D1,
},{





an,
})

local ap
if ag.Content and ag.Content~=3D""then
ap=3Dac("TextLabel",{
Size=3DUDim2.new(1,0,0,0),
AutomaticSize=3D"Y",
FontFace=3DFont.new(ab.Font,Enum.FontWeight.Medium),
TextXAlignment=3D"Left",
Text=3Dag.Content,
TextSize=3D18,
TextTransparency=3D.2,
ThemeTag=3D{
TextColor3=3D"PopupContent",
},
BackgroundTransparency=3D1,
RichText=3Dtrue,
TextWrapped=3Dtrue,
})
end

local aq=3Dac("Frame",{
Size=3DUDim2.new(1,0,0,42),
BackgroundTransparency=3D1,
},{
ac("UIListLayout",{
Padding=3DUDim.new(0,9),
FillDirection=3D"Horizontal",
HorizontalAlignment=3D"Right"
})
})

local ar
if ag.Thumbnail and ag.Thumbnail.Image then
local as
if ag.Thumbnail.Title then
as=3Dac("TextLabel",{
Text=3Dag.Thumbnail.Title,
ThemeTag=3D{
TextColor3=3D"Text",
},
TextSize=3D18,
FontFace=3DFont.new(ab.Font,Enum.FontWeight.Medium),
BackgroundTransparency=3D1,
AutomaticSize=3D"XY",
AnchorPoint=3DVector2.new(0.5,0.5),
Position=3DUDim2.new(0.5,0,0.5,0),
})
end
ar=3Dac("ImageLabel",{
Image=3Dag.Thumbnail.Image,
BackgroundTransparency=3D1,
Size=3DUDim2.new(0,aj,1,0),
Parent=3Dai.UIElements.Main,
ScaleType=3D"Crop"
},{
as,
ac("UICorner",{
CornerRadius=3DUDim.new(0,0),
})
})
end

ac("Frame",{

Size=3DUDim2.new(1,ar and-aj or 0,1,0),
Position=3DUDim2.new(0,ar and aj or 0,0,0),
BackgroundTransparency=3D1,
Parent=3Dai.UIElements.Main
},{
ac("Frame",{

Size=3DUDim2.new(1,0,1,0),
BackgroundTransparency=3D1,
},{
ac("UIListLayout",{
Padding=3DUDim.new(0,18),
FillDirection=3D"Vertical",
}),
ao,
ap,
aq,
ac("UIPadding",{
PaddingTop=3DUDim.new(0,16),
PaddingLeft=3DUDim.new(0,16),
PaddingRight=3DUDim.new(0,16),
PaddingBottom=3DUDim.new(0,16),
})
}),
})

local as=3Da.load'l'.New

for at,au in next,ag.Buttons do
as(au.Title,au.Icon,au.Callback,au.Variant,aq,ai)
end

ai:Open()


return ag
end

return aa end function a.u()
return function(aa,ab)
return{
Dark=3D{
Name=3D"Dark",

Accent=3DColor3.fromHex"#18181b",
Dialog=3DColor3.fromHex"#161616",
Outline=3DColor3.fromHex"#FFFFFF",
Text=3DColor3.fromHex"#FFFFFF",
Placeholder=3DColor3.fromHex"#7a7a7a",
Background=3DColor3.fromHex"#101010",
Button=3DColor3.fromHex"#52525b",
Icon=3DColor3.fromHex"#a1a1aa",
Toggle=3DColor3.fromHex"#33C759",
Slider=3DColor3.fromHex"#0091FF",
Checkbox=3DColor3.fromHex"#0091FF",

PanelBackground=3DColor3.fromHex"#FFFFFF",
PanelBackgroundTransparency=3D0.95,

SliderIcon=3DColor3.fromHex"#908F95",
Primary=3DColor3.fromHex"#0091FF",


LabelBackground=3DColor3.fromHex"#000000",
LabelBackgroundTransparency=3D0.83,

ElementBackground=3DColor3.fromHex"#2A2A2C",
ElementBackgroundTransparency=3D0,
},

Light=3D{
Name=3D"Light",

Accent=3DColor3.fromHex"#FFFFFF",
Dialog=3DColor3.fromHex"#f4f4f5",
Outline=3DColor3.fromHex"#ffffff",
Text=3DColor3.fromHex"#000000",
Placeholder=3DColor3.fromHex"#555555",
Background=3DColor3.fromHex"#e9e9e9",
Button=3DColor3.fromHex"#18181b",
Icon=3DColor3.fromHex"#52525b",
Toggle=3DColor3.fromHex"#33C759",
Slider=3DColor3.fromHex"#0091FF",
Checkbox=3DColor3.fromHex"#0091FF",

TabBackground=3DColor3.fromHex"#ffffff",
TabBackgroundHover=3DColor3.fromHex"#ffffff",
TabBackgroundHoverTransparency=3D0.5,
TabBackgroundActive=3DColor3.fromHex"#ffffff",
TabBackgroundActiveTransparency=3D0,

PanelBackground=3DColor3.fromHex"#FFFFFF",
PanelBackgroundTransparency=3D0,

LabelBackground=3DColor3.fromHex"#ffffff",
LabelBackgroundTransparency=3D0,

ElementBackground=3DColor3.fromHex"#EEEEEE",
ElementBackgroundTransparency=3D0,
},

Rose=3D{
Name=3D"Rose",

Accent=3DColor3.fromHex"#be185d",
Dialog=3DColor3.fromHex"#4c0519",

Text=3DColor3.fromHex"#fdf2f8",
Placeholder=3DColor3.fromHex"#d67aa6",
Background=3DColor3.fromHex"#1f0308",
Button=3DColor3.fromHex"#e95f74",
Icon=3DColor3.fromHex"#fb7185",

ElementBackground=3DColor3.fromHex"#381E23",
ElementBackgroundTransparency=3D0,
},

Plant=3D{
Name=3D"Plant",

Accent=3DColor3.fromHex"#166534",
Dialog=3DColor3.fromHex"#052e16",

Text=3DColor3.fromHex"#f0fdf4",
Placeholder=3DColor3.fromHex"#4fbf7a",
Background=3DColor3.fromHex"#0a1b0f",
Button=3DColor3.fromHex"#16a34a",
Icon=3DColor3.fromHex"#4ade80",

ElementBackground=3DColor3.fromHex"#28342A",
ElementBackgroundTransparency=3D0,
},

Red=3D{
Name=3D"Red",

Accent=3DColor3.fromHex"#991b1b",
Dialog=3DColor3.fromHex"#450a0a",

Text=3DColor3.fromHex"#fef2f2",
Placeholder=3DColor3.fromHex"#d95353",
Background=3DColor3.fromHex"#1c0606",
Button=3DColor3.fromHex"#dc2626",
Icon=3DColor3.fromHex"#ef4444",

ElementBackground=3DColor3.fromHex"#322221",
ElementBackgroundTransparency=3D0,
},

Indigo=3D{
Name=3D"Indigo",

Accent=3DColor3.fromHex"#3730a3",
Dialog=3DColor3.fromHex"#1e1b4b",

Text=3DColor3.fromHex"#f1f5f9",
Placeholder=3DColor3.fromHex"#7078d9",
Background=3DColor3.fromHex"#0f0a2e",
Button=3DColor3.fromHex"#4f46e5",
Icon=3DColor3.fromHex"#6366f1",

ElementBackground=3DColor3.fromHex"#282543",
ElementBackgroundTransparency=3D0,
},

Sky=3D{
Name=3D"Sky",

Accent=3DColor3.fromHex"#00d4ff",
Dialog=3DColor3.fromHex"#0a4d66",

Text=3DColor3.fromHex"#e6f7ff",
Placeholder=3DColor3.fromHex"#66b3cc",
Background=3DColor3.fromHex"#051a26",
Button=3DColor3.fromHex"#00a8cc",
Icon=3DColor3.fromHex"#2db8d9",

Toggle=3DColor3.fromHex"#00d9d9",
Slider=3DColor3.fromHex"#00d4ff",
Checkbox=3DColor3.fromHex"#00d4ff",

PanelBackground=3DColor3.fromHex"#0d3a47",
PanelBackgroundTransparency=3D0.8,

ElementBackground=3DColor3.fromHex"#172E3B",
ElementBackgroundTransparency=3D0,
},

Violet=3D{
Name=3D"Violet",

Accent=3DColor3.fromHex"#6d28d9",
Dialog=3DColor3.fromHex"#3c1361",

Text=3DColor3.fromHex"#faf5ff",
Placeholder=3DColor3.fromHex"#8f7ee0",
Background=3DColor3.fromHex"#1e0a3e",
Button=3DColor3.fromHex"#7c3aed",
Icon=3DColor3.fromHex"#8b5cf6",

ElementBackground=3DColor3.fromHex"#342650",
ElementBackgroundTransparency=3D0,
},

Amber=3D{
Name=3D"Amber",

Accent=3Daa:Gradient({
["0"]=3D{Color=3DColor3.fromHex"#b45309",Transparency=3D0},
["100"]=3D{Color=3DColor3.fromHex"#d97706",Transparency=3D0},
},{Rotation=3D45}),

Dialog=3Daa:Gradient({
["0"]=3D{Color=3DColor3.fromHex"#451a03",Transparency=3D0},
["100"]=3D{Color=3DColor3.fromHex"#6b2e05",Transparency=3D0},
},{Rotation=3D90}),






Text=3Daa:Gradient({
["0"]=3D{Color=3DColor3.fromHex"#fffbeb",Transparency=3D0},
["100"]=3D{Color=3DColor3.fromHex"#fff7ed",Transparency=3D0},
},{Rotation=3D45}),

Placeholder=3Daa:Gradient({
["0"]=3D{Color=3DColor3.fromHex"#d1a326",Transparency=3D0},
["100"]=3D{Color=3DColor3.fromHex"#fbbf24",Transparency=3D0},
},{Rotation=3D45}),

Background=3Daa:Gradient({
["0"]=3D{Color=3DColor3.fromHex"#1c1003",Transparency=3D0},
["100"]=3D{Color=3DColor3.fromHex"#3f210d",Transparency=3D0},
},{Rotation=3D90}),

Button=3Daa:Gradient({
["0"]=3D{Color=3DColor3.fromHex"#d97706",Transparency=3D0},
["100"]=3D{Color=3DColor3.fromHex"#f59e0b",Transparency=3D0},
},{Rotation=3D45}),

Icon=3DColor3.fromHex"#f59e0b",

Toggle=3Daa:Gradient({
["0"]=3D{Color=3DColor3.fromHex"#d97706",Transparency=3D0},
["100"]=3D{Color=3DColor3.fromHex"#f59e0b",Transparency=3D0},
},{Rotation=3D45}),

Slider=3DColor3.fromHex"#d97706",

Checkbox=3Daa:Gradient({
["0"]=3D{Color=3DColor3.fromHex"#d97706",Transparency=3D0},
["100"]=3D{Color=3DColor3.fromHex"#fbbf24",Transparency=3D0},
},{Rotation=3D45}),

PanelBackground=3DColor3.fromHex"#FFFFFF",
PanelBackgroundTransparency=3D0.95,

ElementBackground=3DColor3.fromHex"#3A2E22",
ElementBackgroundTransparency=3D0,
},

Emerald=3D{
Name=3D"Emerald",

Accent=3DColor3.fromHex"#047857",
Dialog=3DColor3.fromHex"#022c22",

Text=3DColor3.fromHex"#ecfdf5",
Placeholder=3DColor3.fromHex"#3fbf8f",
Background=3DColor3.fromHex"#011411",
Button=3DColor3.fromHex"#059669",
Icon=3DColor3.fromHex"#10b981",

ElementBackground=3DColor3.fromHex"#202E2A",
ElementBackgroundTransparency=3D0,
},

Midnight=3D{
Name=3D"Midnight",

Accent=3DColor3.fromHex"#1e3a8a",
Dialog=3DColor3.fromHex"#0c1e42",

Text=3DColor3.fromHex"#dbeafe",
Placeholder=3DColor3.fromHex"#2f74d1",
Background=3DColor3.fromHex"#0a0f1e",
Button=3DColor3.fromHex"#2563eb",
Primary=3DColor3.fromHex"#2563eb",
Icon=3DColor3.fromHex"#5591f4",

ElementBackground=3DColor3.fromHex"#242836",
ElementBackgroundTransparency=3D0,
},

Crimson=3D{
Name=3D"Crimson",

Accent=3DColor3.fromHex"#b91c1c",
Dialog=3DColor3.fromHex"#450a0a",

Text=3DColor3.fromHex"#fef2f2",
Placeholder=3DColor3.fromHex"#6f757b",
Background=3DColor3.fromHex"#0c0404",
Button=3DColor3.fromHex"#991b1b",
Icon=3DColor3.fromHex"#dc2626",

ElementBackground=3DColor3.fromHex"#251F1F",
ElementBackgroundTransparency=3D0,
},

MonokaiPro=3D{
Name=3D"Monokai Pro",

Accent=3DColor3.fromHex"#fc9867",
Dialog=3DColor3.fromHex"#1e1e1e",

Text=3DColor3.fromHex"#fcfcfa",
Placeholder=3DColor3.fromHex"#6f6f6f",
Background=3DColor3.fromHex"#191622",
Button=3DColor3.fromHex"#ab9df2",
Icon=3DColor3.fromHex"#a9dc76",

ElementBackground=3DColor3.fromHex"#323039",
ElementBackgroundTransparency=3D0,

Metadata=3D{
PullRequest=3D23,
},
},

CottonCandy=3D{
Name=3D"Cotton Candy",

Accent=3DColor3.fromHex"#ec4899",
Dialog=3DColor3.fromHex"#2d1b3d",

Text=3DColor3.fromHex"#fdf2f8",
Placeholder=3DColor3.fromHex"#8a5fd3",
Background=3DColor3.fromHex"#1a0b2e",
Button=3DColor3.fromHex"#d946ef",
Slider=3DColor3.fromHex"#d946ef",
Icon=3DColor3.fromHex"#06b6d4",

ElementBackground=3DColor3.fromHex"#312643",
ElementBackgroundTransparency=3D0,
},

Mellowsi=3D{
Name=3D"Mellowsi",

Accent=3DColor3.fromHex"#342A1E",
Dialog=3DColor3.fromHex"#291C13",

Text=3DColor3.fromHex"#F5EBDD",
Placeholder=3DColor3.fromHex"#9C8A73",
Background=3DColor3.fromHex"#1C1002",
Button=3DColor3.fromHex"#342A1E",
Icon=3DColor3.fromHex"#C9B79C",

Toggle=3DColor3.fromHex"#a9873f",
Slider=3DColor3.fromHex"#C9A24D",
Checkbox=3DColor3.fromHex"#C9A24D",

ElementBackground=3DColor3.fromHex"#33291E",
ElementBackgroundTransparency=3D0,

Metadata=3D{
PullRequest=3D52,
},
},

Rainbow=3D{
Name=3D"Rainbow",

Accent=3Daa:Gradient({
["0"]=3D{Color=3DColor3.fromHex"#00ff41",Transparency=3D0},
["33"]=3D{Color=3DColor3.fromHex"#00ffff",Transparency=3D0},
["66"]=3D{Color=3DColor3.fromHex"#0080ff",Transparency=3D0},
["100"]=3D{Color=3DColor3.fromHex"#8000ff",Transparency=3D0},
},{Rotation=3D45}),

Dialog=3Daa:Gradient({
["0"]=3D{Color=3DColor3.fromHex"#ff0080",Transparency=3D0},
["25"]=3D{Color=3DColor3.fromHex"#8000ff",Transparency=3D0},
["50"]=3D{Color=3DColor3.fromHex"#0080ff",Transparency=3D0},
["75"]=3D{Color=3DColor3.fromHex"#00ff80",Transparency=3D0},
["100"]=3D{Color=3DColor3.fromHex"#ff8000",Transparency=3D0},
},{Rotation=3D135}),


Text=3DColor3.fromHex"#ffffff",
Placeholder=3DColor3.fromHex"#00ff80",

Background=3Daa:Gradient({
["0"]=3D{Color=3DColor3.fromHex"#ff0040",Transparency=3D0},
["20"]=3D{Color=3DColor3.fromHex"#ff4000",Transparency=3D0},
["40"]=3D{Color=3DColor3.fromHex"#ffff00",Transparency=3D0},
["60"]=3D{Color=3DColor3.fromHex"#00ff40",Transparency=3D0},
["80"]=3D{Color=3DColor3.fromHex"#0040ff",Transparency=3D0},
["100"]=3D{Color=3DColor3.fromHex"#4000ff",Transparency=3D0},
},{Rotation=3D90}),

Button=3Daa:Gradient({
["0"]=3D{Color=3DColor3.fromHex"#ff0080",Transparency=3D0},
["25"]=3D{Color=3DColor3.fromHex"#ff8000",Transparency=3D0},
["50"]=3D{Color=3DColor3.fromHex"#ffff00",Transparency=3D0},
["75"]=3D{Color=3DColor3.fromHex"#80ff00",Transparency=3D0},
["100"]=3D{Color=3DColor3.fromHex"#00ffff",Transparency=3D0},
},{Rotation=3D60}),

Icon=3DColor3.fromHex"#ffffff",
},
}
end end function a.v()

local aa=3D{}

local ab=3Da.load'c'
local ac=3Dab.New local ad=3D
ab.Tween

function aa.New(ae,af,ag,ah,ai)
local aj=3Dai or 10
local ak
if af and af~=3D""then
ak=3Dac("ImageLabel",{
Image=3Dab.Icon(af)[1],
ImageRectSize=3Dab.Icon(af)[2].ImageRectSize,
ImageRectOffset=3Dab.Icon(af)[2].ImageRectPosition,
Size=3DUDim2.new(0,21,0,21),
BackgroundTransparency=3D1,
ThemeTag=3D{
ImageColor3=3D"Icon",
},
})
end

local al=3Dac("TextLabel",{
BackgroundTransparency=3D1,
TextSize=3D17,
FontFace=3DFont.new(ab.Font,Enum.FontWeight.Regular),
Size=3DUDim2.new(1,ak and-29 or 0,1,0),
TextXAlignment=3D"Left",
ThemeTag=3D{
TextColor3=3Dah and"Placeholder"or"Text",
},
Text=3Dae,
})

local am=3Dac("TextButton",{
Size=3DUDim2.new(1,0,0,42),
Parent=3Dag,
BackgroundTransparency=3D1,
Text=3D"",
},{
ac("Frame",{
Size=3DUDim2.new(1,0,1,0),
BackgroundTransparency=3D1,
},{
ab.NewRoundFrame(aj,"Squircle",{
ThemeTag=3D{
ImageColor3=3D"Accent",
},
Size=3DUDim2.new(1,0,1,0),
ImageTransparency=3D0.97,
}),
ab.NewRoundFrame(aj,"Glass-1.4",{
ThemeTag=3D{
ImageColor3=3D"Outline",
},
Size=3DUDim2.new(1,0,1,0),
ImageTransparency=3D0.67,
},{













}),
ab.NewRoundFrame(aj,"Squircle",{
Size=3DUDim2.new(1,0,1,0),
Name=3D"Frame",
ThemeTag=3D{
ImageColor3=3D"LabelBackground",
ImageTransparency=3D"LabelBackgroundTransparency",
},


},{
ac("UIPadding",{
PaddingLeft=3DUDim.new(0,12),
PaddingRight=3DUDim.new(0,12),
}),
ac("UIListLayout",{
FillDirection=3D"Horizontal",
Padding=3DUDim.new(0,8),
VerticalAlignment=3D"Center",
HorizontalAlignment=3D"Left",
}),
ak,
al,
}),
}),
})

return am
end

return aa end function a.w()

local aa=3D{}

local ab=3D(cloneref or clonereference or function(ab)return ab end)


local ac=3Dab(game:GetService"UserInputService")

local ad=3Da.load'c'
local ae=3Dad.New local af=3D
ad.Tween


function aa.New(ag,ah,ai,aj)
local ak=3Dae("Frame",{
Size=3DUDim2.new(0,aj,1,0),
BackgroundTransparency=3D1,
Position=3DUDim2.new(1,0,0,0),
AnchorPoint=3DVector2.new(1,0),
Parent=3Dah,
ZIndex=3D999,
Active=3Dtrue,
})

local al=3Dad.NewRoundFrame(aj/2,"Squircle",{
Size=3DUDim2.new(1,0,0,0),
ImageTransparency=3D0.85,
ThemeTag=3D{ImageColor3=3D"Text"},
Parent=3Dak,
})

local am=3Dae("Frame",{
Size=3DUDim2.new(1,12,1,12),
Position=3DUDim2.new(0.5,0,0.5,0),
AnchorPoint=3DVector2.new(0.5,0.5),
BackgroundTransparency=3D1,
Active=3Dtrue,
ZIndex=3D999,
Parent=3Dal,
})

local an=3Dfalse
local ao=3D0

local function updateSliderSize()
local ap=3Dag
local aq=3Dap.AbsoluteCanvasSize.Y
local ar=3Dap.AbsoluteWindowSize.Y

if aq&lt;=3Dar then
al.Visible=3Dfalse
return
end

local as=3Dmath.clamp(ar/aq,0.1,1)
al.Size=3DUDim2.new(1,0,as,0)
al.Visible=3Dtrue
end

local function updateScrollingFramePosition()
local ap=3Dal.Position.Y.Scale
local aq=3Dag.AbsoluteCanvasSize.Y
local ar=3Dag.AbsoluteWindowSize.Y
local as=3Dmath.max(aq-ar,0)

if as&lt;=3D0 then return end

local at=3Dmath.max(1-al.Size.Y.Scale,0)
if at&lt;=3D0 then return end

local au=3Dap/at

ag.CanvasPosition=3DVector2.new(
ag.CanvasPosition.X,
au*as
)
end

local function updateThumbPosition()
if an then return end

local ap=3Dag.CanvasPosition.Y
local aq=3Dag.AbsoluteCanvasSize.Y
local ar=3Dag.AbsoluteWindowSize.Y
local as=3Dmath.max(aq-ar,0)

if as&lt;=3D0 then
al.Position=3DUDim2.new(0,0,0,0)
return
end

local at=3Dap/as
local au=3Dmath.max(1-al.Size.Y.Scale,0)
local av=3Dmath.clamp(at*au,0,au)

al.Position=3DUDim2.new(0,0,av,0)
end

ad.AddSignal(ak.InputBegan,function(ap)
if(ap.UserInputType=3D=3DEnum.UserInputType.MouseButton1 or ap.UserInputTyp=
e=3D=3DEnum.UserInputType.Touch)then
local aq=3Dal.AbsolutePosition.Y
local ar=3Daq+al.AbsoluteSize.Y

if not(ap.Position.Y&gt;=3Daq and ap.Position.Y&lt;=3Dar)then
local as=3Dak.AbsolutePosition.Y
local at=3Dak.AbsoluteSize.Y
local au=3Dal.AbsoluteSize.Y

local av=3Dap.Position.Y-as-au/2
local aw=3Dat-au

local ax=3Dmath.clamp(av/aw,0,1-al.Size.Y.Scale)

al.Position=3DUDim2.new(0,0,ax,0)
updateScrollingFramePosition()
end
end
end)

ad.AddSignal(am.InputBegan,function(ap)
if ap.UserInputType=3D=3DEnum.UserInputType.MouseButton1 or ap.UserInputTyp=
e=3D=3DEnum.UserInputType.Touch then
an=3Dtrue
ao=3Dap.Position.Y-al.AbsolutePosition.Y

local aq
local ar

aq=3Dac.InputChanged:Connect(function(as)
if as.UserInputType=3D=3DEnum.UserInputType.MouseMovement or as.UserInputTy=
pe=3D=3DEnum.UserInputType.Touch then
local at=3Dak.AbsolutePosition.Y
local au=3Dak.AbsoluteSize.Y
local av=3Dal.AbsoluteSize.Y

local aw=3Das.Position.Y-at-ao
local ax=3Dau-av

local ay=3Dmath.clamp(aw/ax,0,1-al.Size.Y.Scale)

al.Position=3DUDim2.new(0,0,ay,0)
updateScrollingFramePosition()
end
end)

ar=3Dac.InputEnded:Connect(function(as)
if as.UserInputType=3D=3DEnum.UserInputType.MouseButton1 or as.UserInputTyp=
e=3D=3DEnum.UserInputType.Touch then
an=3Dfalse
if aq then aq:Disconnect()end
if ar then ar:Disconnect()end
end
end)
end
end)

ad.AddSignal(ag:GetPropertyChangedSignal"AbsoluteWindowSize",function()
updateSliderSize()
updateThumbPosition()
end)

ad.AddSignal(ag:GetPropertyChangedSignal"AbsoluteCanvasSize",function()
updateSliderSize()
updateThumbPosition()
end)

ad.AddSignal(ag:GetPropertyChangedSignal"CanvasPosition",function()
if not an then
updateThumbPosition()
end
end)

updateSliderSize()
updateThumbPosition()

return ak
end


return aa end function a.x()
local aa=3D{}

local ab=3Da.load'c'
local ac=3Dab.New
local ad=3Dab.Tween

function aa.New(ae,af,ag)
local ah=3D{
Title=3Daf.Title or"Tag",
Icon=3Daf.Icon,
Color=3Daf.Color or Color3.fromHex"#315dff",
Radius=3Daf.Radius or 999,
Border=3Daf.Border or false,

TagFrame=3Dnil,
Height=3D26,
Padding=3D10,
TextSize=3D14,
IconSize=3D16,
}

local ai
if ah.Icon then
ai=3Dab.Image(ah.Icon,ah.Icon,0,af.Window,"Tag",false)

ai.Size=3DUDim2.new(0,ah.IconSize,0,ah.IconSize)
ai.ImageLabel.ImageColor3=3Dtypeof(ah.Color)=3D=3D"Color3"
and ab.GetTextColorForHSB(ah.Color)
or typeof(ah.Color)=3D=3D"string"
and(ab.GetTextColorForHSB(ab.GetThemeProperty(ah.Color,ab.Theme)))
end

local aj=3Dac("TextLabel",{
BackgroundTransparency=3D1,
AutomaticSize=3D"XY",
TextSize=3Dah.TextSize,
FontFace=3DFont.new(ab.Font,Enum.FontWeight.SemiBold),
Text=3Dah.Title,
TextColor3=3Dtypeof(ah.Color)=3D=3D"Color3"and ab.GetTextColorForHSB(ah.Col=
or)or typeof(
ah.Color
)=3D=3D"string"and(ab.GetTextColorForHSB(ab.GetThemeProperty(ah.Color,ab.Th=
eme))),
})

local ak

if typeof(ah.Color)=3D=3D"table"then
ak=3Dac"UIGradient"
for al,am in next,ah.Color do
ak[al]=3Dam
end

aj.TextColor3=3Dab.GetTextColorForHSB(ab.GetAverageColor(ak))
if ai then
ai.ImageLabel.ImageColor3=3Dab.GetTextColorForHSB(ab.GetAverageColor(ak))
end
end

local al=3Dab.NewRoundFrame(ah.Radius,"Squircle",{
AutomaticSize=3D"X",
Size=3DUDim2.new(0,0,0,ah.Height),
Parent=3Dag,
ImageColor3=3Dtypeof(ah.Color)=3D=3D"Color3"and ah.Color
or typeof(ah.Color)=3D=3D"table"and Color3.new(1,1,1)
or nil,
ThemeTag=3Dtypeof(ah.Color)=3D=3D"string"and{
ImageColor3=3Dah.Color,
},
},{
ak,
ab.NewRoundFrame(ah.Radius,"Glass-1",{
Size=3DUDim2.new(1,0,1,0),
ThemeTag=3D{
ImageColor3=3D"White",
},
ImageTransparency=3D0.75,
}),
ac("Frame",{
Size=3DUDim2.new(0,0,1,0),
AutomaticSize=3D"X",
Name=3D"Content",
BackgroundTransparency=3D1,
},{
ai,
aj,
ac("UIPadding",{
PaddingLeft=3DUDim.new(0,ah.Padding),
PaddingRight=3DUDim.new(0,ah.Padding),
}),
ac("UIListLayout",{
FillDirection=3D"Horizontal",
VerticalAlignment=3D"Center",
Padding=3DUDim.new(0,ah.Padding/1.5),
}),
}),
})

function ah.SetTitle(am,an)
ah.Title=3Dan
aj.Text=3Dan

return ah
end

function ah.SetColor(am,an)
ah.Color=3Dan
if typeof(an)=3D=3D"table"then
local ao=3Dab.GetAverageColor(an)
ad(aj,0.06,{TextColor3=3Dab.GetTextColorForHSB(ao)}):Play()
local ap=3Dal:FindFirstChildOfClass"UIGradient"or ac("UIGradient",{Parent=
=3Dal})
for aq,ar in next,an do
ap[aq]=3Dar
end
ad(al,0.06,{ImageColor3=3DColor3.new(1,1,1)}):Play()
else
if ak then
ak:Destroy()
end
ad(aj,0.06,{TextColor3=3Dab.GetTextColorForHSB(an)}):Play()
if ai then
ad(ai.ImageLabel,0.06,{ImageColor3=3Dab.GetTextColorForHSB(an)}):Play()
end
ad(al,0.06,{ImageColor3=3Dan}):Play()
end

return ah
end

function ah.SetIcon(am,an)
ah.Icon=3Dan

if an then
ai=3Dab.Image(an,an,0,af.Window,"Tag",false)

ai.Size=3DUDim2.new(0,ah.IconSize,0,ah.IconSize)
ai.Parent=3Dal

if typeof(ah.Color)=3D=3D"Color3"then
ai.ImageLabel.ImageColor3=3Dab.GetTextColorForHSB(ah.Color)
elseif typeof(ah.Color)=3D=3D"table"then
ai.ImageLabel.ImageColor3=3Dab.GetTextColorForHSB(ab.GetAverageColor(ak))
end
else
if ai then
ai:Destroy()
ai=3Dnil
end
end
return ah
end

function ah.Destroy(am)
al:Destroy()
return ah
end

ab:OnThemeChange(function(am,an)
aj.TextColor3=3Dab.GetTextColorForHSB(ab.GetThemeProperty(ah.Color,ab.Theme=
))
ai.ImageLabel.ImageColor3=3D
ab.GetTextColorForHSB(ab.GetThemeProperty(ah.Color,ab.Theme))
end)

return ah
end

return aa end function a.y()

local aa=3D(cloneref or clonereference or function(aa)return aa end)


local ab=3Daa(game:GetService"RunService")
local ac=3Daa(game:GetService"HttpService")

local ad

local ae
ae=3D{
Folder=3Dnil,
Path=3Dnil,
Configs=3D{},
Parser=3D{
Colorpicker=3D{
Save=3Dfunction(af)
return{
__type=3Daf.__type,
value=3Daf.Default:ToHex(),
transparency=3Daf.Transparency or nil,
}
end,
Load=3Dfunction(af,ag)
if af and af.Update then
af:Update(Color3.fromHex(ag.value),ag.transparency or nil)
end
end
},
Dropdown=3D{
Save=3Dfunction(af)
return{
__type=3Daf.__type,
value=3Daf.Value,
}
end,
Load=3Dfunction(af,ag)
if af and af.Select then
af:Select(ag.value)
end
end
},
Input=3D{
Save=3Dfunction(af)
return{
__type=3Daf.__type,
value=3Daf.Value,
}
end,
Load=3Dfunction(af,ag)
if af and af.Set then
af:Set(ag.value)
end
end
},
Keybind=3D{
Save=3Dfunction(af)
return{
__type=3Daf.__type,
value=3Daf.Value,
}
end,
Load=3Dfunction(af,ag)
if af and af.Set then
af:Set(ag.value)
end
end
},
Slider=3D{
Save=3Dfunction(af)
return{
__type=3Daf.__type,
value=3Daf.Value.Default,
}
end,
Load=3Dfunction(af,ag)
if af and af.Set then
af:Set(tonumber(ag.value))
end
end
},
Toggle=3D{
Save=3Dfunction(af)
return{
__type=3Daf.__type,
value=3Daf.Value,
}
end,
Load=3Dfunction(af,ag)
if af and af.Set then
af:Set(ag.value)
end
end
},
}
}

function ae.Init(af,ag)
if not ag.Folder then
warn"[ WindUI.ConfigManager ] Window.Folder is not specified."
return false
end
if ab:IsStudio()or not writefile then
warn"[ WindUI.ConfigManager ] The config system doesn't work in the studio.=
"
return false
end

ad=3Dag
ae.Folder=3Dad.Folder
ae.Path=3D"WindUI/"..tostring(ae.Folder).."/config/"

if not isfolder(ae.Path)then
makefolder(ae.Path)
end

local ah=3Dae:AllConfigs()

for ai,aj in next,ah do
if isfile and readfile and isfile(aj..".json")then
ae.Configs[aj]=3Dreadfile(aj..".json")
end
end

return ae
end

function ae.SetPath(af,ag)
if not ag then
warn"[ WindUI.ConfigManager ] Custom path is not specified."
return false
end

ae.Path=3Dag
if not ag:match"/$"then
ae.Path=3Dag.."/"
end

if not isfolder(ae.Path)then
makefolder(ae.Path)
end

return true
end

function ae.CreateConfig(af,ag,ah)
local ai=3D{
Path=3Dae.Path..ag..".json",
Elements=3D{},
CustomData=3D{},
AutoLoad=3Dah or false,
Version=3D1.2,
}

if not ag then
return false,"No config file is selected"
end

function ai.SetAsCurrent(aj)
ad:SetCurrentConfig(ai)
end

function ai.Register(aj,ak,al)
ai.Elements[ak]=3Dal
end

function ai.Set(aj,ak,al)
ai.CustomData[ak]=3Dal
end

function ai.Get(aj,ak)
return ai.CustomData[ak]
end

function ai.SetAutoLoad(aj,ak)
ai.AutoLoad=3Dak
end

function ai.Save(aj)
if ad.PendingFlags then
for ak,al in next,ad.PendingFlags do
ai:Register(ak,al)
end
end

local ak=3D{
__version=3Dai.Version,
__elements=3D{},
__autoload=3Dai.AutoLoad,
__custom=3Dai.CustomData
}

for al,am in next,ai.Elements do
if ae.Parser[am.__type]then
ak.__elements[tostring(al)]=3Dae.Parser[am.__type].Save(am)
end
end

local al=3Dac:JSONEncode(ak)
if writefile then
writefile(ai.Path,al)
end

return ak
end

function ai.Load(aj)
if isfile and not isfile(ai.Path)then
return false,"Config file does not exist"
end

local ak,al=3Dpcall(function()
local ak=3Dreadfile or function()
warn"[ WindUI.ConfigManager ] The config system doesn't work in the studio.=
"
return nil
end
return ac:JSONDecode(ak(ai.Path))
end)

if not ak then
return false,"Failed to parse config file"
end

if not al.__version then
local am=3D{
__version=3Dai.Version,
__elements=3Dal,
__custom=3D{}
}
al=3Dam
end

if ad.PendingFlags then
for am,an in next,ad.PendingFlags do
ai:Register(am,an)
end
end

for am,an in next,(al.__elements or{})do
if ai.Elements[am]and ae.Parser[an.__type]then
task.spawn(function()
ae.Parser[an.__type].Load(ai.Elements[am],an)
end)
end
end

ai.CustomData=3Dal.__custom or{}

return ai.CustomData
end

function ai.Delete(aj)
if not delfile then
return false,"delfile function is not available"
end

if not isfile(ai.Path)then
return false,"Config file does not exist"
end

local ak,al=3Dpcall(function()
delfile(ai.Path)
end)

if not ak then
return false,"Failed to delete config file: "..tostring(al)
end

ae.Configs[ag]=3Dnil

if ad.CurrentConfig=3D=3Dai then
ad.CurrentConfig=3Dnil
end

return true,"Config deleted successfully"
end

function ai.GetData(aj)
return{
elements=3Dai.Elements,
custom=3Dai.CustomData,
autoload=3Dai.AutoLoad
}
end


if isfile(ai.Path)then
local aj,ak=3Dpcall(function()
return ac:JSONDecode(readfile(ai.Path))
end)

if aj and ak and ak.__autoload then
ai.AutoLoad=3Dtrue

task.spawn(function()
task.wait(0.5)
local al,am=3Dpcall(function()
return ai:Load()
end)
if al then
if ad.Debug then print("[ WindUI.ConfigManager ] AutoLoaded config: "..ag)e=
nd
else
warn("[ WindUI.ConfigManager ] Failed to AutoLoad config: "..ag.." - "..tos=
tring(am))
end
end)
end
end


ai:SetAsCurrent()
ae.Configs[ag]=3Dai
return ai
end

function ae.Config(af,ag,ah)
return ae:CreateConfig(ag,ah)
end

function ae.GetAutoLoadConfigs(af)
local ag=3D{}

for ah,ai in pairs(ae.Configs)do
if ai.AutoLoad then
table.insert(ag,ah)
end
end

return ag
end

function ae.DeleteConfig(af,ag)
if not delfile then
return false,"delfile function is not available"
end

local ah=3Dae.Path..ag..".json"

if not isfile(ah)then
return false,"Config file does not exist"
end

local ai,aj=3Dpcall(function()
delfile(ah)
end)

if not ai then
return false,"Failed to delete config file: "..tostring(aj)
end

ae.Configs[ag]=3Dnil

if ad.CurrentConfig and ad.CurrentConfig.Path=3D=3Dah then
ad.CurrentConfig=3Dnil
end

return true,"Config deleted successfully"
end

function ae.AllConfigs(af)
if not listfiles then return{}end

local ag=3D{}
if not isfolder(ae.Path)then
makefolder(ae.Path)
return ag
end

for ah,ai in next,listfiles(ae.Path)do
local aj=3Dai:match"([^\\/]+)%.json$"
if aj then
table.insert(ag,aj)
end
end

return ag
end

function ae.GetConfig(af,ag)
return ae.Configs[ag]
end

return ae end function a.z()
local aa=3D{}

local ab=3Da.load'c'
local ac=3Dab.New
local ad=3Dab.Tween


local ae=3D(cloneref or clonereference or function(ae)return ae end)


ae(game:GetService"UserInputService")


function aa.New(af)
local ag=3D{
Button=3Dnil
}

local ah













local ai=3Dac("TextLabel",{
Text=3Daf.Title,
TextSize=3D17,
FontFace=3DFont.new(ab.Font,Enum.FontWeight.Medium),
BackgroundTransparency=3D1,
AutomaticSize=3D"XY",
})

local aj=3Dac("Frame",{
Size=3DUDim2.new(0,36,0,36),
BackgroundTransparency=3D1,
Name=3D"Drag",
},{
ac("ImageLabel",{
Image=3Dab.Icon"move"[1],
ImageRectOffset=3Dab.Icon"move"[2].ImageRectPosition,
ImageRectSize=3Dab.Icon"move"[2].ImageRectSize,
Size=3DUDim2.new(0,18,0,18),
BackgroundTransparency=3D1,
Position=3DUDim2.new(0.5,0,0.5,0),
AnchorPoint=3DVector2.new(0.5,0.5),
ThemeTag=3D{
ImageColor3=3D"Icon",
},
ImageTransparency=3D.3,
})
})
local ak=3Dac("Frame",{
Size=3DUDim2.new(0,1,1,0),
Position=3DUDim2.new(0,36,0.5,0),
AnchorPoint=3DVector2.new(0,0.5),
BackgroundColor3=3DColor3.new(1,1,1),
BackgroundTransparency=3D.9,
})

local al=3Dac("Frame",{
Size=3DUDim2.new(0,0,0,0),
Position=3DUDim2.new(0.5,0,0,28),
AnchorPoint=3DVector2.new(0.5,0.5),
Parent=3Daf.Parent,
BackgroundTransparency=3D1,
Active=3Dtrue,
Visible=3Dfalse,
})


local am=3Dac("UIScale",{
Scale=3D1,
})

local an=3Dac("Frame",{
Size=3DUDim2.new(0,0,0,44),
AutomaticSize=3D"X",
Parent=3Dal,
Active=3Dfalse,
BackgroundTransparency=3D.25,
ZIndex=3D99,
BackgroundColor3=3DColor3.new(0,0,0),
},{
am,
ac("UICorner",{
CornerRadius=3DUDim.new(1,0)
}),
ac("UIStroke",{
Thickness=3D1,
ApplyStrokeMode=3D"Border",
Color=3DColor3.new(1,1,1),
Transparency=3D0,
},{
ac("UIGradient",{
Color=3DColorSequence.new(Color3.fromHex"40c9ff",Color3.fromHex"e81cff")
})
}),
aj,
ak,

ac("UIListLayout",{
Padding=3DUDim.new(0,4),
FillDirection=3D"Horizontal",
VerticalAlignment=3D"Center",
}),

ac("TextButton",{
AutomaticSize=3D"XY",
Active=3Dtrue,
BackgroundTransparency=3D1,
Size=3DUDim2.new(0,0,0,36),

BackgroundColor3=3DColor3.new(1,1,1),
},{
ac("UICorner",{
CornerRadius=3DUDim.new(1,-4)
}),
ah,
ac("UIListLayout",{
Padding=3DUDim.new(0,af.UIPadding),
FillDirection=3D"Horizontal",
VerticalAlignment=3D"Center",
}),
ai,
ac("UIPadding",{
PaddingLeft=3DUDim.new(0,11),
PaddingRight=3DUDim.new(0,11),
}),
}),
ac("UIPadding",{
PaddingLeft=3DUDim.new(0,4),
PaddingRight=3DUDim.new(0,4),
})
})

ag.Button=3Dan



function ag.SetIcon(ao,ap)
if ah then
ah:Destroy()
end
if ap then
ah=3Dab.Image(
ap,
af.Title,
0,
af.Folder,
"OpenButton",
true,
af.IconThemed
)
ah.Size=3DUDim2.new(0,22,0,22)
ah.LayoutOrder=3D-1
ah.Parent=3Dag.Button.TextButton
end
end

if af.Icon then
ag:SetIcon(af.Icon)
end



ab.AddSignal(an:GetPropertyChangedSignal"AbsoluteSize",function()
al.Size=3DUDim2.new(
0,an.AbsoluteSize.X,
0,an.AbsoluteSize.Y
)
end)

ab.AddSignal(an.TextButton.MouseEnter,function()
ad(an.TextButton,.1,{BackgroundTransparency=3D.93}):Play()
end)
ab.AddSignal(an.TextButton.MouseLeave,function()
ad(an.TextButton,.1,{BackgroundTransparency=3D1}):Play()
end)

local ao=3Dab.Drag(al)


function ag.Visible(ap,aq)
al.Visible=3Daq
end

function ag.SetScale(ap,aq)
am.Scale=3Daq
end

function ag.Edit(ap,aq)
local ar=3D{
Title=3Daq.Title,
Icon=3Daq.Icon,
Enabled=3Daq.Enabled,
Position=3Daq.Position,
OnlyIcon=3Daq.OnlyIcon or false,
Draggable=3Daq.Draggable or nil,
OnlyMobile=3Daq.OnlyMobile,
CornerRadius=3Daq.CornerRadius or UDim.new(1,0),
StrokeThickness=3Daq.StrokeThickness or 2,
Scale=3Daq.Scale or 1,
Color=3Daq.Color
or ColorSequence.new(Color3.fromHex"40c9ff",Color3.fromHex"e81cff"),
}



if ar.Enabled=3D=3Dfalse then
af.IsOpenButtonEnabled=3Dfalse
end

if ar.OnlyMobile~=3Dfalse then
ar.OnlyMobile=3Dtrue
else
af.IsPC=3Dfalse
end


if ar.Draggable=3D=3Dfalse and aj and ak then
aj.Visible=3Dar.Draggable
ak.Visible=3Dar.Draggable

if ao then
ao:Set(ar.Draggable)
end
end

if ar.Position and al then
al.Position=3Dar.Position
end

if ar.OnlyIcon=3D=3Dtrue and ai then
ai.Visible=3Dfalse
an.TextButton.UIPadding.PaddingLeft=3DUDim.new(0,7)
an.TextButton.UIPadding.PaddingRight=3DUDim.new(0,7)
elseif ar.OnlyIcon=3D=3Dfalse then
ai.Visible=3Dtrue
an.TextButton.UIPadding.PaddingLeft=3DUDim.new(0,11)
an.TextButton.UIPadding.PaddingRight=3DUDim.new(0,11)
end





if ai then
if ar.Title then
ai.Text=3Dar.Title
ab:ChangeTranslationKey(ai,ar.Title)
elseif ar.Title=3D=3Dnil then

end
end

if ar.Icon then
ag:SetIcon(ar.Icon)
end

an.UIStroke.UIGradient.Color=3Dar.Color
if Glow then
Glow.UIGradient.Color=3Dar.Color
end

an.UICorner.CornerRadius=3Dar.CornerRadius
an.TextButton.UICorner.CornerRadius=3DUDim.new(ar.CornerRadius.Scale,ar.Cor=
nerRadius.Offset-4)
an.UIStroke.Thickness=3Dar.StrokeThickness

ag:SetScale(ar.Scale)
end

return ag
end



return aa end function a.A()
local aa=3D{}

local ab=3Da.load'c'
local ac=3Dab.New
local ad=3Dab.Tween


function aa.New(ae,af,ag,ah,ai,aj)
local ak=3D{
Container=3Dnil,
TooltipSize=3D16,

TooltipArrowSizeX=3Dai=3D=3D"Small"and 16 or 24,
TooltipArrowSizeY=3Dai=3D=3D"Small"and 6 or 9,

PaddingX=3Dai=3D=3D"Small"and 12 or 14,
PaddingY=3Dai=3D=3D"Small"and 7 or 9,

Radius=3D999,

TitleFrame=3Dnil,
}

ah=3Dah or""
aj=3Daj~=3Dfalse

local al=3Dac("TextLabel",{
AutomaticSize=3D"XY",
TextWrapped=3Daj,
BackgroundTransparency=3D1,
FontFace=3DFont.new(ab.Font,Enum.FontWeight.Medium),
Text=3Dae,
TextSize=3Dai=3D=3D"Small"and 15 or 17,
TextTransparency=3D1,
ThemeTag=3D{
TextColor3=3D"Tooltip"..ah.."Text",
}
})

ak.TitleFrame=3Dal

local am=3Dac("UIScale",{
Scale=3D.9
})

local an=3Dac("Frame",{
AnchorPoint=3DVector2.new(0.5,0),
AutomaticSize=3D"XY",
BackgroundTransparency=3D1,
Parent=3Daf,

Visible=3Dfalse
},{
ac("UISizeConstraint",{
MaxSize=3DVector2.new(400,math.huge)
}),
ac("Frame",{
AutomaticSize=3D"XY",
BackgroundTransparency=3D1,
LayoutOrder=3D99,
Visible=3Dag,
Name=3D"Arrow",
},{
ac("ImageLabel",{
Size=3DUDim2.new(0,ak.TooltipArrowSizeX,0,ak.TooltipArrowSizeY),
BackgroundTransparency=3D1,

Image=3D"rbxassetid://105854070513330",
ThemeTag=3D{
ImageColor3=3D"Tooltip"..ah,
},
},{










}),
}),
ab.NewRoundFrame(ak.Radius,"Squircle",{
AutomaticSize=3D"XY",
ThemeTag=3D{
ImageColor3=3D"Tooltip"..ah,
},
ImageTransparency=3D1,
Name=3D"Background",
},{



ac("Frame",{



AutomaticSize=3D"XY",
BackgroundTransparency=3D1,
},{
ac("UICorner",{
CornerRadius=3DUDim.new(0,16),
}),
ac("UIListLayout",{
Padding=3DUDim.new(0,12),
FillDirection=3D"Horizontal",
VerticalAlignment=3D"Center"
}),

al,
ac("UIPadding",{
PaddingTop=3DUDim.new(0,ak.PaddingY),
PaddingLeft=3DUDim.new(0,ak.PaddingX),
PaddingRight=3DUDim.new(0,ak.PaddingX),
PaddingBottom=3DUDim.new(0,ak.PaddingY),
}),
})
}),
am,
ac("UIListLayout",{
Padding=3DUDim.new(0,0),
FillDirection=3D"Vertical",
VerticalAlignment=3D"Center",
HorizontalAlignment=3D"Center",
}),
})
ak.Container=3Dan

function ak.Open(ao)
an.Visible=3Dtrue


ad(an.Background,.2,{ImageTransparency=3D0},Enum.EasingStyle.Quint,Enum.Eas=
ingDirection.Out):Play()
ad(an.Arrow.ImageLabel,.2,{ImageTransparency=3D0},Enum.EasingStyle.Quint,En=
um.EasingDirection.Out):Play()
ad(al,.2,{TextTransparency=3D0},Enum.EasingStyle.Quint,Enum.EasingDirection=
.Out):Play()
ad(am,.22,{Scale=3D1},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play=
()
end

function ak.Close(ao,ap)

ad(an.Background,.3,{ImageTransparency=3D1},Enum.EasingStyle.Quint,Enum.Eas=
ingDirection.Out):Play()
ad(an.Arrow.ImageLabel,.2,{ImageTransparency=3D1},Enum.EasingStyle.Quint,En=
um.EasingDirection.Out):Play()
ad(al,.3,{TextTransparency=3D1},Enum.EasingStyle.Quint,Enum.EasingDirection=
.Out):Play()
ad(am,.35,{Scale=3D.9},Enum.EasingStyle.Quint,Enum.EasingDirection.In):Play=
()

ap=3Dap~=3Dfalse
if ap then
task.wait(.35)

an.Visible=3Dfalse
an:Destroy()
end
end

return ak
end



return aa end function a.B()
game:GetService"ReplicatedStorage"
local aa=3Da.load'c'
local ab=3Daa.New
local ac=3Daa.NewRoundFrame
local ad=3Daa.Tween

local ae=3D(cloneref or clonereference or function(ae)
return ae
end)

ae(game:GetService"UserInputService")

local function Color3ToHSB(af)
local ag,ah,ai=3Daf.R,af.G,af.B
local aj=3Dmath.max(ag,ah,ai)
local ak=3Dmath.min(ag,ah,ai)
local al=3Daj-ak

local am=3D0
if al~=3D0 then
if aj=3D=3Dag then
am=3D(ah-ai)/al%6
elseif aj=3D=3Dah then
am=3D(ai-ag)/al+2
else
am=3D(ag-ah)/al+4
end
am=3Dam*60
else
am=3D0
end

local an=3D(aj=3D=3D0)and 0 or(al/aj)
local ao=3Daj

return{
h=3Dmath.floor(am+0.5),
s=3Dan,
b=3Dao,
}
end

local function GetPerceivedBrightness(af)
local ag=3Daf.R
local ah=3Daf.G
local ai=3Daf.B
return 0.299*ag+0.587*ah+0.114*ai
end

local function GetTextColorForHSB(af)
local ag=3DColor3ToHSB(af)local
ah, ai, aj=3Dag.h, ag.s, ag.b
if GetPerceivedBrightness(af)&gt;0.5 then
return Color3.fromHSV(ah/360,0,0.05)
else
return Color3.fromHSV(ah/360,0,0.98)
end
end

local function getElementPosition(af,ag)
if type(ag)~=3D"number"or ag~=3Dmath.floor(ag)then
return nil,1
end






local ah=3D#af


if ah=3D=3D0 or ag&lt;1 or ag&gt;ah then
return nil,2
end

local function isDelimiter(ai)
if ai=3D=3Dnil then
return true
end
local aj=3Dai.__type
return aj=3D=3D"Divider"or aj=3D=3D"Space"or aj=3D=3D"Section"or aj=3D=3D"C=
ode"
end

if isDelimiter(af[ag])then
return nil,3
end

local function calculate(ai,aj)
if aj=3D=3D1 then
return"Squircle"
end
if ai=3D=3D1 then
return"Squircle-TL-TR"
end
if ai=3D=3Daj then
return"Squircle-BL-BR"
end
return"Square"
end

local ai=3D1
local aj=3D0

for ak=3D1,ah do
local al=3Daf[ak]
if isDelimiter(al)then
if ag&gt;=3Dai and ag&lt;=3Dak-1 then
local am=3Dag-ai+1
return calculate(am,aj)
end
ai=3Dak+1
aj=3D0
else
aj=3Daj+1
end
end

if ag&gt;=3Dai and ag&lt;=3Dah then
local ak=3Dag-ai+1
return calculate(ak,aj)
end

return nil,4
end

return function(af)
local ag=3D{
Title=3Daf.Title,
Desc=3Daf.Desc or nil,
Hover=3Daf.Hover,
Thumbnail=3Daf.Thumbnail,
ThumbnailSize=3Daf.ThumbnailSize or 80,
Image=3Daf.Image,
IconThemed=3Daf.IconThemed or false,
ImageSize=3Daf.ImageSize or 30,
Color=3Daf.Color,
Scalable=3Daf.Scalable,
Parent=3Daf.Parent,
Justify=3Daf.Justify or"Between",
UIPadding=3Daf.Window.ElementConfig.UIPadding,
UICorner=3Daf.Window.ElementConfig.UICorner,
Size=3Daf.Size or"Default",
UIElements=3D{},

Index=3Daf.Index,
}

local ah=3Dag.Size=3D=3D"Small"and-4 or ag.Size=3D=3D"Large"and 4 or 0
local ai=3Dag.Size=3D=3D"Small"and-4 or ag.Size=3D=3D"Large"and 4 or 0

local aj=3Dag.ImageSize
local ak=3Dag.ThumbnailSize
local al=3Dtrue


local am=3D0

local an
local ao
if ag.Thumbnail then
an=3Daa.Image(
ag.Thumbnail,
ag.Title,
af.Window.NewElements and ag.UICorner-11 or(ag.UICorner-4),
af.Window.Folder,
"Thumbnail",
false,
ag.IconThemed
)
an.Size=3DUDim2.new(1,0,0,ak)
end
if ag.Image then
ao=3Daa.Image(
ag.Image,
ag.Title,
af.Window.NewElements and ag.UICorner-11 or(ag.UICorner-4),
af.Window.Folder,
"Image",
ag.IconThemed,
not ag.Color and true or false,
"ElementIcon"
)

if typeof(ag.Color)=3D=3D"string"and not string.find(ag.Image,"rbxthumb")th=
en
ao.ImageLabel.ImageColor3=3DGetTextColorForHSB(Color3.fromHex(aa.Colors[ag.=
Color]))
elseif typeof(ag.Color)=3D=3D"Color3"and not string.find(ag.Image,"rbxthumb=
")then
ao.ImageLabel.ImageColor3=3DGetTextColorForHSB(ag.Color)
end

ao.Size=3DUDim2.new(0,aj,0,aj)

am=3Daj
end

local function CreateText(ap,aq)
local ar=3Dtypeof(ag.Color)=3D=3D"string"
and GetTextColorForHSB(Color3.fromHex(aa.Colors[ag.Color]))
or typeof(ag.Color)=3D=3D"Color3"and GetTextColorForHSB(ag.Color)

return ab("TextLabel",{
BackgroundTransparency=3D1,
Text=3Dap or"",
TextSize=3Daq=3D=3D"Desc"and 15 or 17,
TextXAlignment=3D"Left",
ThemeTag=3D{
TextColor3=3Dnot ag.Color and("Element"..aq)or nil,
},
TextColor3=3Dag.Color and ar or nil,
TextTransparency=3Daq=3D=3D"Desc"and 0.3 or 0,
TextWrapped=3Dtrue,
Size=3DUDim2.new(ag.Justify=3D=3D"Between"and 1 or 0,0,0,0),
AutomaticSize=3Dag.Justify=3D=3D"Between"and"Y"or"XY",
FontFace=3DFont.new(aa.Font,aq=3D=3D"Desc"and Enum.FontWeight.Medium or Enu=
m.FontWeight.SemiBold),
})
end

local ap=3DCreateText(ag.Title,"Title")
local aq=3DCreateText(ag.Desc,"Desc")
if not ag.Title or ag.Title=3D=3D""then
aq.Visible=3Dfalse
end
if not ag.Desc or ag.Desc=3D=3D""then
aq.Visible=3Dfalse
end

ag.UIElements.Title=3Dap
ag.UIElements.Desc=3Daq

ag.UIElements.Container=3Dab("Frame",{
Size=3DUDim2.new(1,0,1,0),
AutomaticSize=3D"Y",
BackgroundTransparency=3D1,
},{
ab("UIListLayout",{
Padding=3DUDim.new(0,ag.UIPadding),
FillDirection=3D"Vertical",
VerticalAlignment=3D"Center",
HorizontalAlignment=3Dag.Justify=3D=3D"Between"and"Left"or"Center",
}),
an,
ab("Frame",{
Size=3DUDim2.new(
ag.Justify=3D=3D"Between"and 1 or 0,
ag.Justify=3D=3D"Between"and-af.TextOffset or 0,
0,
0
),
AutomaticSize=3Dag.Justify=3D=3D"Between"and"Y"or"XY",
BackgroundTransparency=3D1,
Name=3D"TitleFrame",
},{
ab("UIListLayout",{
Padding=3DUDim.new(0,ag.UIPadding),
FillDirection=3D"Horizontal",
VerticalAlignment=3Daf.Window.NewElements and(ag.Justify=3D=3D"Between"and"=
Top"or"Center")
or"Center",
HorizontalAlignment=3Dag.Justify~=3D"Between"and ag.Justify or"Center",
}),
ao,
ab("Frame",{
BackgroundTransparency=3D1,
AutomaticSize=3Dag.Justify=3D=3D"Between"and"Y"or"XY",
Size=3DUDim2.new(
ag.Justify=3D=3D"Between"and 1 or 0,
ag.Justify=3D=3D"Between"and(ao and-am-ag.UIPadding or-am)
or 0,
1,
0
),
Name=3D"TitleFrame",
},{
ab("UIPadding",{
PaddingTop=3DUDim.new(0,(af.Window.NewElements and ag.UIPadding/2 or 0)+ai)=
,
PaddingLeft=3DUDim.new(0,(af.Window.NewElements and ag.UIPadding/2 or 0)+ah=
),
PaddingRight=3DUDim.new(
0,
(af.Window.NewElements and ag.UIPadding/2 or 0)+ah
),
PaddingBottom=3DUDim.new(
0,
(af.Window.NewElements and ag.UIPadding/2 or 0)+ai
),
}),
ab("UIListLayout",{
Padding=3DUDim.new(0,6),
FillDirection=3D"Vertical",
VerticalAlignment=3D"Center",
HorizontalAlignment=3D"Left",
}),
ap,
aq,
}),
}),
})





local ar=3Daa.Image("lock","lock",0,af.Window.Folder,"Lock",false)
ar.Size=3DUDim2.new(0,20,0,20)
ar.ImageLabel.ImageColor3=3DColor3.new(1,1,1)
ar.ImageLabel.ImageTransparency=3D0.4

local as=3Dab("TextLabel",{
Text=3D"Locked",
TextSize=3D18,
FontFace=3DFont.new(aa.Font,Enum.FontWeight.Medium),
AutomaticSize=3D"XY",
BackgroundTransparency=3D1,
TextColor3=3DColor3.new(1,1,1),
TextTransparency=3D0.05,
})

local at=3Dab("Frame",{
Size=3DUDim2.new(1,ag.UIPadding*2,1,ag.UIPadding*2),
BackgroundTransparency=3D1,
AnchorPoint=3DVector2.new(0.5,0.5),
Position=3DUDim2.new(0.5,0,0.5,0),
ZIndex=3D9999999,
})

local au,av=3Dac(ag.UICorner,"Squircle",{
Size=3DUDim2.new(1,0,1,0),
ImageTransparency=3D0.25,
ImageColor3=3DColor3.new(0,0,0),
Visible=3Dfalse,
Active=3Dfalse,
Parent=3Dat,
},{
ab("UIListLayout",{
FillDirection=3D"Horizontal",
VerticalAlignment=3D"Center",
HorizontalAlignment=3D"Center",
Padding=3DUDim.new(0,8),
}),
ar,
as,
},nil,true)

local aw,ax=3Dac(ag.UICorner,"Squircle-Outline",{
Size=3DUDim2.new(1,0,1,0),
ImageTransparency=3D1,
Active=3Dfalse,
ThemeTag=3D{
ImageColor3=3D"Text",
},
Parent=3Dat,
},{
ab("UIListLayout",{
FillDirection=3D"Horizontal",
VerticalAlignment=3D"Center",
HorizontalAlignment=3D"Center",
Padding=3DUDim.new(0,8),
}),
},nil,true)

local ay,az=3Dac(ag.UICorner,"Squircle",{
Size=3DUDim2.new(1,0,1,0),
ImageTransparency=3D1,
Active=3Dfalse,
ThemeTag=3D{
ImageColor3=3D"Text",
},
Parent=3Dat,
},{
ab("UIListLayout",{
FillDirection=3D"Horizontal",
VerticalAlignment=3D"Center",
HorizontalAlignment=3D"Center",
Padding=3DUDim.new(0,8),
}),
},nil,true)

local aA,aB=3Dac(ag.UICorner,"Squircle-Outline",{
Size=3DUDim2.new(1,0,1,0),
ImageTransparency=3D1,
Active=3Dfalse,
ThemeTag=3D{
ImageColor3=3D"Text",
},
Parent=3Dat,
},{
ab("UIListLayout",{
FillDirection=3D"Horizontal",
VerticalAlignment=3D"Center",
HorizontalAlignment=3D"Center",
Padding=3DUDim.new(0,8),
}),
ab("UIGradient",{
Name=3D"HoverGradient",
Color=3DColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(0.5,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.new(1,1,1)),
},
Transparency=3DNumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.25,0.9),
NumberSequenceKeypoint.new(0.5,0.3),
NumberSequenceKeypoint.new(0.75,0.9),
NumberSequenceKeypoint.new(1,1),
},
}),
},nil,true)

local b,d=3Dac(ag.UICorner,"Squircle",{
Size=3DUDim2.new(1,0,1,0),
ImageTransparency=3D1,
Active=3Dfalse,
ThemeTag=3D{
ImageColor3=3D"Text",
},
Parent=3Dat,
},{
ab("UIGradient",{
Name=3D"HoverGradient",
Color=3DColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(0.5,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.new(1,1,1)),
},
Transparency=3DNumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.25,0.9),
NumberSequenceKeypoint.new(0.5,0.3),
NumberSequenceKeypoint.new(0.75,0.9),
NumberSequenceKeypoint.new(1,1),
},
}),
ab("UIListLayout",{
FillDirection=3D"Horizontal",
VerticalAlignment=3D"Center",
HorizontalAlignment=3D"Center",
Padding=3DUDim.new(0,8),
}),
},nil,true)

local f,g=3Dac(ag.UICorner,"Squircle",{
Size=3DUDim2.new(1,0,0,0),
AutomaticSize=3D"Y",
ImageTransparency=3Dag.Color and 0.05 or nil,



Parent=3Daf.Parent,
ThemeTag=3D{
ImageColor3=3Dnot ag.Color and"ElementBackground"or nil,
ImageTransparency=3Dnot ag.Color and"ElementBackgroundTransparency"or nil,
},
ImageColor3=3Dag.Color and(typeof(ag.Color)=3D=3D"string"and Color3.fromHex=
(
aa.Colors[ag.Color]
)or typeof(ag.Color)=3D=3D"Color3"and ag.Color)or nil,
},{
ag.UIElements.Container,
at,
ab("UIPadding",{
PaddingTop=3DUDim.new(0,ag.UIPadding),
PaddingLeft=3DUDim.new(0,ag.UIPadding),
PaddingRight=3DUDim.new(0,ag.UIPadding),
PaddingBottom=3DUDim.new(0,ag.UIPadding),
}),
},true,true)

ag.UIElements.Main=3Df
ag.UIElements.Locked=3Dau

if ag.Hover then
aa.AddSignal(f.MouseEnter,function()
if al then

ad(b,0.12,{ImageTransparency=3D0.9}):Play()
ad(aA,0.12,{ImageTransparency=3D0.8}):Play()
aa.AddSignal(f.MouseMoved,function(h,j)
b.HoverGradient.Offset=3D
Vector2.new(((h-f.AbsolutePosition.X)/f.AbsoluteSize.X)-0.5,0)
aA.HoverGradient.Offset=3D
Vector2.new(((h-f.AbsolutePosition.X)/f.AbsoluteSize.X)-0.5,0)
end)
end
end)
aa.AddSignal(f.InputEnded,function()
if al then

ad(b,0.12,{ImageTransparency=3D1}):Play()
ad(aA,0.12,{ImageTransparency=3D1}):Play()
end
end)
end

function ag.SetTitle(h,j)
ag.Title=3Dj
ap.Text=3Dj
end

function ag.SetDesc(h,j)
ag.Desc=3Dj
aq.Text=3Dj or""
if not j then
aq.Visible=3Dfalse
elseif not aq.Visible then
aq.Visible=3Dtrue
end
end

function ag.Colorize(h,j,l)
if ag.Color then
j[l]=3Dtypeof(ag.Color)=3D=3D"string"
and GetTextColorForHSB(Color3.fromHex(aa.Colors[ag.Color]))
or typeof(ag.Color)=3D=3D"Color3"and GetTextColorForHSB(ag.Color)
or nil
end
end

if af.ElementTable then
aa.AddSignal(ap:GetPropertyChangedSignal"Text",function()
if ag.Title~=3Dap.Text then
ag:SetTitle(ap.Text)
af.ElementTable.Title=3Dap.Text
end
end)
aa.AddSignal(aq:GetPropertyChangedSignal"Text",function()
if ag.Desc~=3Daq.Text then
ag:SetDesc(aq.Text)
af.ElementTable.Desc=3Daq.Text
end
end)
end





function ag.SetThumbnail(h,j,l)
ag.Thumbnail=3Dj
if l then
ag.ThumbnailSize=3Dl
ak=3Dl
end

if an then
if j then
an:Destroy()
an=3Daa.Image(
j,
ag.Title,
ag.UICorner-3,
af.Window.Folder,
"Thumbnail",
false,
ag.IconThemed
)
if an then
an.Size=3DUDim2.new(1,0,0,ak)
an.Parent=3Dag.UIElements.Container
local m=3Dag.UIElements.Container:FindFirstChild"UIListLayout"
if m then
an.LayoutOrder=3D-1
end
end
else
an.Visible=3Dfalse

end
else
if j then
an=3Daa.Image(
j,
ag.Title,
ag.UICorner-3,
af.Window.Folder,
"Thumbnail",
false,
ag.IconThemed
)
if an then
an.Size=3DUDim2.new(1,0,0,ak)
an.Parent=3Dag.UIElements.Container
local m=3Dag.UIElements.Container:FindFirstChild"UIListLayout"
if m then
an.LayoutOrder=3D-1
end
end
end
end
end

function ag.SetImage(h,j,l)
ag.Image=3Dj
if l then
ag.ImageSize=3Dl
aj=3Dl
end

if j then
local m=3Dao and ao.Parent or ag.UIElements.Container.TitleFrame
if ao then ao:Destroy()end

ao=3Daa.Image(
j,
j,
ag.UICorner-3,
af.Window.Folder,
"Image",
not ag.Color and true or false
)
if ao then
if typeof(ag.Color)=3D=3D"string"and not string.find(ag.Image,"rbxthumb")th=
en
ao.ImageLabel.ImageColor3=3DGetTextColorForHSB(Color3.fromHex(aa.Colors[ag.=
Color]))
elseif typeof(ag.Color)=3D=3D"Color3"and not string.find(ag.Image,"rbxthumb=
")then
ao.ImageLabel.ImageColor3=3DGetTextColorForHSB(ag.Color)
end


ao.Visible=3Dtrue
ao.Parent=3Dm
ao.LayoutOrder=3D-99

ao.Size=3DUDim2.new(0,aj,0,aj)
am=3Dag.ImageSize+ag.UIPadding
end
else
if ao then
ao.Visible=3Dtrue
end
am=3D0
end

ag.UIElements.Container.TitleFrame.TitleFrame.Size=3DUDim2.new(1,-am,1,0)
end

function ag.Destroy(h)
f:Destroy()
end

function ag.Lock(h,j)
al=3Dfalse
au.Active=3Dtrue
au.Visible=3Dtrue
as.Text=3Dj or"Locked"
end

function ag.Unlock(h)
al=3Dtrue
au.Active=3Dfalse
au.Visible=3Dfalse
end

function ag.Highlight(h)
local j=3Dab("UIGradient",{
Color=3DColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(0.5,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.new(1,1,1)),
},
Transparency=3DNumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.1,0.9),
NumberSequenceKeypoint.new(0.5,0.3),
NumberSequenceKeypoint.new(0.9,0.9),
NumberSequenceKeypoint.new(1,1),
},
Rotation=3D0,
Offset=3DVector2.new(-1,0),
Parent=3Daw,
})

local l=3Dab("UIGradient",{
Color=3DColorSequence.new{
ColorSequenceKeypoint.new(0,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(0.5,Color3.new(1,1,1)),
ColorSequenceKeypoint.new(1,Color3.new(1,1,1)),
},
Transparency=3DNumberSequence.new{
NumberSequenceKeypoint.new(0,1),
NumberSequenceKeypoint.new(0.15,0.8),
NumberSequenceKeypoint.new(0.5,0.1),
NumberSequenceKeypoint.new(0.85,0.8),
NumberSequenceKeypoint.new(1,1),
},
Rotation=3D0,
Offset=3DVector2.new(-1,0),
Parent=3Day,
})

aw.ImageTransparency=3D0.65
ay.ImageTransparency=3D0.88

ad(j,0.75,{
Offset=3DVector2.new(1,0),
}):Play()

ad(l,0.75,{
Offset=3DVector2.new(1,0),
}):Play()

task.spawn(function()
task.wait(0.75)
aw.ImageTransparency=3D1
ay.ImageTransparency=3D1
j:Destroy()
l:Destroy()
end)
end

function ag.UpdateShape(h)
if af.Window.NewElements then
local j
if af.ParentConfig.ParentType=3D=3D"Group"then
j=3D"Squircle"
else
j=3DgetElementPosition(h.Elements,ag.Index)
end

if j and f then
g:SetType(j)
av:SetType(j)
az:SetType(j)
ax:SetType(j.."-Outline")
d:SetType(j)
aB:SetType(j.."-Outline")
end
end
end





return ag
end end function a.C()

local aa=3Da.load'c'
local ab=3Daa.New

local ac=3D{}

local ad=3Da.load'l'.New

function ac.New(ae,af)
af.Hover=3Dfalse
af.TextOffset=3D0
af.ParentConfig=3Daf
af.IsButtons=3Daf.Buttons and#af.Buttons&gt;0 and true or false

local ag=3D{
__type=3D"Paragraph",
Title=3Daf.Title or"Paragraph",
Desc=3Daf.Desc or nil,

Locked=3Daf.Locked or false,
}
local ah=3Da.load'B'(af)

ag.ParagraphFrame=3Dah
if af.Buttons and#af.Buttons&gt;0 then
local ai=3Dab("Frame",{
Size=3DUDim2.new(1,0,0,38),
BackgroundTransparency=3D1,
AutomaticSize=3D"Y",
Parent=3Dah.UIElements.Container,
},{
ab("UIListLayout",{
Padding=3DUDim.new(0,10),
FillDirection=3D"Vertical",
}),
})

for aj,ak in next,af.Buttons do
local al=3Dad(
ak.Title,
ak.Icon,
ak.Callback,
ak.Variant or"White",
ai,
nil,
nil,
af.Window.NewElements and 999 or 10
)
al.Size=3DUDim2.new(1,0,0,38)

end
end

return ag.__type,ag
end

return ac end function a.D()

local aa=3Da.load'c'local ab=3D
aa.New

local ac=3D{}

function ac.New(ad,ae)
local af=3D{
__type=3D"Button",
Title=3Dae.Title or"Button",
Desc=3Dae.Desc or nil,
Icon=3Dae.Icon or"mouse-pointer-click",
IconThemed=3Dae.IconThemed or false,
Color=3Dae.Color,
Justify=3Dae.Justify or"Between",
IconAlign=3Dae.IconAlign or"Right",
Locked=3Dae.Locked or false,
LockedTitle=3Dae.LockedTitle,
Callback=3Dae.Callback or function()end,
UIElements=3D{}
}

local ag=3Dtrue

af.ButtonFrame=3Da.load'B'{
Title=3Daf.Title,
Desc=3Daf.Desc,
Parent=3Dae.Parent,




Window=3Dae.Window,
Color=3Daf.Color,
Justify=3Daf.Justify,
TextOffset=3D20,
Hover=3Dtrue,
Scalable=3Dtrue,
Tab=3Dae.Tab,
Index=3Dae.Index,
ElementTable=3Daf,
ParentConfig=3Dae,
Size=3Dae.Size,
}














af.UIElements.ButtonIcon=3Daa.Image(
af.Icon,
af.Icon,
0,
ae.Window.Folder,
"Button",
not af.Color and true or nil,
af.IconThemed
)

af.UIElements.ButtonIcon.Size=3DUDim2.new(0,20,0,20)
af.UIElements.ButtonIcon.Parent=3Daf.Justify=3D=3D"Between"and af.ButtonFra=
me.UIElements.Main or af.ButtonFrame.UIElements.Container.TitleFrame
af.UIElements.ButtonIcon.LayoutOrder=3Daf.IconAlign=3D=3D"Left"and-99999 or=
 99999
af.UIElements.ButtonIcon.AnchorPoint=3DVector2.new(1,0.5)
af.UIElements.ButtonIcon.Position=3DUDim2.new(1,0,0.5,0)

af.ButtonFrame:Colorize(af.UIElements.ButtonIcon.ImageLabel,"ImageColor3")

function af.Lock(ah)
af.Locked=3Dtrue
ag=3Dfalse
return af.ButtonFrame:Lock(af.LockedTitle)
end
function af.Unlock(ah)
af.Locked=3Dfalse
ag=3Dtrue
return af.ButtonFrame:Unlock()
end

if af.Locked then
af:Lock()
end

aa.AddSignal(af.ButtonFrame.UIElements.Main.MouseButton1Click,function()
if ag then
task.spawn(function()
aa.SafeCallback(af.Callback)
end)
end
end)
return af.__type,af
end

return ac end function a.E()
local aa=3D{}

local ab=3Da.load'c'
local ac=3Dab.New
local ad=3Dab.Tween

local ae=3Dgame:GetService"UserInputService"

function aa.New(af,ag,ah,ai,aj,ak,al)
local am=3D{
GlassSpritesheet=3D{
Id=3D"rbxassetid://77297718671545",
MirroredId=3D"rbxassetid://92258969882244",
Size=3DVector2.new(102,128),
Total=3D80,
Cols=3D10,
}
}

function am.GetGlassFrame(an,ao:number):(string,Vector2,Vector2)
local ap=3Dam.GlassSpritesheet
local aq:number

if ao&lt;=3D0.4 then
aq=3Dmath.floor((ao/0.4)*(ap.Total-1))
elseif ao&lt;0.6 then
aq=3Dap.Total-1
else
aq=3Dmath.floor(((ao-0.6)/0.4)*(ap.Total-1))
end

aq=3Dmath.clamp(aq,0,ap.Total-1)

local ar=3Dao&gt;=3D0.6
if ar then
aq=3D(ap.Total-1)-aq
end

local as=3Dar and ap.MirroredId or ap.Id

return as,
ap.Size,
Vector2.new(
(aq%ap.Cols)*ap.Size.X,
math.floor(aq/ap.Cols)*ap.Size.Y
)
end

local an=3D12
local ao
if ag and ag~=3D""then
ao=3Dac("ImageLabel",{
Size=3DUDim2.new(0,13,0,13),
BackgroundTransparency=3D1,
AnchorPoint=3DVector2.new(0.5,0.5),
Position=3DUDim2.new(0.5,0,0.5,0),
Image=3Dab.Icon(ag)[1],
ImageRectOffset=3Dab.Icon(ag)[2].ImageRectPosition,
ImageRectSize=3Dab.Icon(ag)[2].ImageRectSize,
ImageTransparency=3D1,
ImageColor3=3DColor3.new(0,0,0),
})
end

local ap=3Dac("Frame",{
Size=3DUDim2.new(0,2,0,26),
BackgroundTransparency=3D1,
Parent=3Dai,
})

local aq=3Dab.NewRoundFrame(an,"Squircle",{
ImageTransparency=3D.85,
ThemeTag=3D{
ImageColor3=3D"Text"
},
Parent=3Dap,
Size=3DUDim2.new(0,ak and(52)or(40.8),0,24),
AnchorPoint=3DVector2.new(1,0.5),
Position=3DUDim2.new(0,0,0.5,0),
Name=3D"ToggleFrame",
},{
ab.NewRoundFrame(an,"Squircle",{
Size=3DUDim2.new(1,0,1,0),
Name=3D"Layer",
ThemeTag=3D{
ImageColor3=3D"Toggle",
},
ImageTransparency=3D1,
}),
ab.NewRoundFrame(an,"SquircleOutline",{
Size=3DUDim2.new(1,0,1,0),
Name=3D"Stroke",
ImageColor3=3DColor3.new(1,1,1),
ImageTransparency=3D1,
},{
ac("UIGradient",{
Rotation=3D90,
Transparency=3DNumberSequence.new{
NumberSequenceKeypoint.new(0,0),
NumberSequenceKeypoint.new(1,1),
}
})
}),


ab.NewRoundFrame(an,"Squircle",{
Size=3DUDim2.new(0,ak and 30 or 20,0,20),
Position=3DUDim2.new(0,2,0.5,0),
AnchorPoint=3DVector2.new(0,0.5),
ImageTransparency=3D1,
Name=3D"Frame",
},{
ab.NewRoundFrame(an,"Squircle",{
Size=3DUDim2.new(1,0,1,0),
ImageTransparency=3D0,

AnchorPoint=3DVector2.new(0.5,0.5),
Position=3DUDim2.new(0.5,0,0.5,0),
Name=3D"Bar"
},{
ab.NewRoundFrame(an,"Glass-1.4",{
Size=3DUDim2.new(1,0,1,0),
ImageColor3=3DColor3.new(1,1,1),
Name=3D"Highlight",
ImageTransparency=3D1,
},{













ab.NewRoundFrame(an,"Squircle",{
Size=3DUDim2.new(1,0,1,0),
Name=3D"GlassBackground",
ImageTransparency=3D0,
ThemeTag=3D{
ImageColor3=3D"ElementBackground",
},
ZIndex=3D-1,
}),
ac("ImageLabel",{
Size=3DUDim2.new(1,0,1,0),
BackgroundTransparency=3D1,
Name=3D"Glass",
ImageTransparency=3D0,
},{
ac("UICorner",{
CornerRadius=3DUDim.new(1,0),
})
}),
ab.NewRoundFrame(an,"Glass-1.4",{
Size=3DUDim2.new(1,0,1,0),
ImageColor3=3DColor3.new(1,1,1),
Name=3D"Highlight",
ImageTransparency=3D0.3,
}),
ab.NewRoundFrame(an,"Squircle",{
Size=3DUDim2.new(1,0,1,0),
Name=3D"BarOverlay",
ThemeTag=3D{
ImageColor3=3D"ToggleBar",
},
ZIndex=3D999,
})
}),
ao,
ac("UIScale",{
Scale=3D1,
})
}),
}),
ac("TextButton",{
Size=3DUDim2.new(1,0,1,0),
BackgroundTransparency=3D1,
Position=3DUDim2.new(0.5,0,0.5,0),
AnchorPoint=3DVector2.new(0.5,0.5),
Name=3D"Hitbox",
Text=3D"",
})
})

local ar
local as

local at=3Dak and 30 or 20
local au=3Daq.Size.X.Offset

function am.Set(av,aw,ax,ay)
if not ay then
if aw then
ad(aq.Frame,0.35,{
Position=3DUDim2.new(0,au-at-2,0.5,0),
},Enum.EasingStyle.Back,Enum.EasingDirection.Out):Play()
ab.SetThemeTag(aq.Frame.Bar.Highlight.Glass,{ImageColor3=3D"Toggle"},0.15)
ad(aq.Frame.Bar.Highlight.Glass,0.15,{ImageTransparency=3D0},Enum.EasingSty=
le.Quint,Enum.EasingDirection.Out):Play()
else
ad(aq.Frame,0.35,{
Position=3DUDim2.new(0,2,0.5,0),
},Enum.EasingStyle.Back,Enum.EasingDirection.Out):Play()
ab.SetThemeTag(aq.Frame.Bar.Highlight.Glass,{ImageColor3=3D"Text"},0.15)
ad(aq.Frame.Bar.Highlight.Glass,0.15,{ImageTransparency=3D0.85},Enum.Easing=
Style.Quint,Enum.EasingDirection.Out):Play()
end
else
if aw then
aq.Frame.Position=3DUDim2.new(0,au-at-2,0.5,0)
else
aq.Frame.Position=3DUDim2.new(0,2,0.5,0)
end
end

if aw then
ad(aq.Layer,0.1,{
ImageTransparency=3D0,
}):Play()
ab.SetThemeTag(aq.Frame.Bar.Highlight.Glass,{ImageColor3=3D"Toggle"},0.1)
ad(aq.Frame.Bar.Highlight.Glass,0.1,{ImageTransparency=3D0},Enum.EasingStyl=
e.Quint,Enum.EasingDirection.Out):Play()

if ao then
ad(ao,0.1,{
ImageTransparency=3D0,
}):Play()
end

local az,aA,aB=3Dam:GetGlassFrame(1)

aq.Frame.Bar.Highlight.Glass.Image=3Daz
aq.Frame.Bar.Highlight.Glass.ImageRectSize=3DaA
aq.Frame.Bar.Highlight.Glass.ImageRectOffset=3DaB
else
ad(aq.Layer,0.1,{
ImageTransparency=3D1,
}):Play()
ab.SetThemeTag(aq.Frame.Bar.Highlight.Glass,{ImageColor3=3D"Text"},0.1)
ad(aq.Frame.Bar.Highlight.Glass,0.1,{ImageTransparency=3D0.85},Enum.EasingS=
tyle.Quint,Enum.EasingDirection.Out):Play()

if ao then
ad(ao,0.1,{
ImageTransparency=3D1,
}):Play()
end

local az,aA,aB=3Dam:GetGlassFrame(0)

aq.Frame.Bar.Highlight.Glass.Image=3Daz
aq.Frame.Bar.Highlight.Glass.ImageRectSize=3DaA
aq.Frame.Bar.Highlight.Glass.ImageRectOffset=3DaB
end

ax=3Dax~=3Dfalse

task.spawn(function()
if aj and ax then
ab.SafeCallback(aj,aw)
end
end)
end


function am.Animate(av,aw,ax)
if not al.Window.IsToggleDragging then
al.Window.IsToggleDragging=3Dtrue

local ay=3Daw.Position.X
local az=3Daw.Position.Y
local aA=3Daq.Frame.Position.X.Offset
local aB=3Dfalse
local b=3Dfalse

ad(aq.Frame.Bar.UIScale,0.28,{Scale=3D1.5},Enum.EasingStyle.Quint,Enum.Easi=
ngDirection.Out):Play()
ad(aq.Frame.Bar.Highlight.BarOverlay,0.28,{ImageTransparency=3D.86},Enum.Ea=
singStyle.Quint,Enum.EasingDirection.Out):Play()

if ar then ar:Disconnect()end

ar=3Dae.InputChanged:Connect(function(d)
if not al.Window.IsToggleDragging then return end
if d.UserInputType~=3DEnum.UserInputType.MouseMovement and d.UserInputType~=
=3DEnum.UserInputType.Touch then return end
if aB then return end

local f=3Dmath.abs(d.Position.X-ay)
math.abs(d.Position.Y-az)

if not b and f&gt;8 then
b=3Dtrue
end

local g=3Dd.Position.X-ay
local h=3Dmath.max(2,math.min(aA+g,au-at-2))

local j=3Dmath.clamp((h-2)/(au-at-4),0,1)

local l,m,p=3Dam:GetGlassFrame(j)
aq.Frame.Bar.Highlight.Glass.Image=3Dl
aq.Frame.Bar.Highlight.Glass.ImageRectSize=3Dm
aq.Frame.Bar.Highlight.Glass.ImageRectOffset=3Dp

ad(aq.Frame,0.12,{
Position=3DUDim2.new(0,h,0.5,0)
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end)

if as then as:Disconnect()end

as=3Dae.InputEnded:Connect(function(d)
if not al.Window.IsToggleDragging then return end
if d.UserInputType~=3DEnum.UserInputType.MouseButton1 and d.UserInputType~=
=3DEnum.UserInputType.Touch then return end

al.Window.IsToggleDragging=3Dfalse

if ar then ar:Disconnect()ar=3Dnil end
if as then as:Disconnect()as=3Dnil end

if aB then return end

if not b then
ax:Set(not ax.Value,true,false)
else
local f=3Daq.Frame.Position.X.Offset
local g=3Df+at/2
local h=3Dg&gt;au/2
ax:Set(h,true,false)
end

ad(aq.Frame.Bar.UIScale,0.23,{Scale=3D1},Enum.EasingStyle.Quint,Enum.Easing=
Direction.Out):Play()
ad(aq.Frame.Bar.Highlight.BarOverlay,0.23,{ImageTransparency=3D0},Enum.Easi=
ngStyle.Quint,Enum.EasingDirection.Out):Play()
end)
end
end

return ap,am
end

return aa end function a.F()
local aa=3D{}

local ab=3Da.load'c'local ac=3D
ab.New
local ad=3Dab.Tween


function aa.New(ae,af,ag,ah,ai,aj)
local ak=3D{}

af=3Daf or"sfsymbols:checkmark"

local al=3D9

local am=3Dab.Image(
af,
af,
0,
(aj and aj.Window.Folder or"Temp"),
"Checkbox",
true,
false,
"CheckboxIcon"
)
am.Size=3DUDim2.new(1,-26+ag,1,-26+ag)
am.AnchorPoint=3DVector2.new(0.5,0.5)
am.Position=3DUDim2.new(0.5,0,0.5,0)


local an=3Dab.NewRoundFrame(al,"Squircle",{
ImageTransparency=3D.85,
ThemeTag=3D{
ImageColor3=3D"Text"
},
Parent=3Dah,
Size=3DUDim2.new(0,26,0,26),
},{
ab.NewRoundFrame(al,"Squircle",{
Size=3DUDim2.new(1,0,1,0),
Name=3D"Layer",
ThemeTag=3D{
ImageColor3=3D"Checkbox",
},
ImageTransparency=3D1,
}),
ab.NewRoundFrame(al,"Glass-1.4",{
Size=3DUDim2.new(1,0,1,0),
Name=3D"Stroke",
ThemeTag=3D{
ImageColor3=3D"CheckboxBorder",
ImageTransparency=3D"CheckboxBorderTransparency",
},
},{







}),

am,
},true)

function ak.Set(ao,ap)
if ap then
ad(an.Layer,0.06,{
ImageTransparency=3D0,
}):Play()



ad(am.ImageLabel,0.06,{
ImageTransparency=3D0,
}):Play()
else
ad(an.Layer,0.05,{
ImageTransparency=3D1,
}):Play()



ad(am.ImageLabel,0.06,{
ImageTransparency=3D1,
}):Play()
end

task.spawn(function()
if ai then
ab.SafeCallback(ai,ap)
end
end)
end

return an,ak
end


return aa end function a.G()
local aa=3Da.load'c'local ab=3D
aa.New local ac=3D
aa.Tween

local ad=3Da.load'E'.New
local ae=3Da.load'F'.New

local af=3D{}

function af.New(ag,ah)
local ai=3D{
__type=3D"Toggle",
Title=3Dah.Title or"Toggle",
Desc=3Dah.Desc or nil,
Locked=3Dah.Locked or false,
LockedTitle=3Dah.LockedTitle,
Value=3Dah.Value,
Icon=3Dah.Icon or nil,
IconSize=3Dah.IconSize or 23,
Type=3Dah.Type or"Toggle",
Callback=3Dah.Callback or function()end,
UIElements=3D{}
}
ai.ToggleFrame=3Da.load'B'{
Title=3Dai.Title,
Desc=3Dai.Desc,




Window=3Dah.Window,
Parent=3Dah.Parent,
TextOffset=3D(52),
Hover=3Dfalse,
Tab=3Dah.Tab,
Index=3Dah.Index,
ElementTable=3Dai,
ParentConfig=3Dah,
}

local aj=3Dtrue

if ai.Value=3D=3Dnil then
ai.Value=3Dfalse
end



function ai.Lock(ak)
ai.Locked=3Dtrue
aj=3Dfalse
return ai.ToggleFrame:Lock(ai.LockedTitle)
end
function ai.Unlock(ak)
ai.Locked=3Dfalse
aj=3Dtrue
return ai.ToggleFrame:Unlock()
end

if ai.Locked then
ai:Lock()
end

local ak=3Dai.Value

local al,am
if ai.Type=3D=3D"Toggle"then
al,am=3Dad(ak,ai.Icon,ai.IconSize,ai.ToggleFrame.UIElements.Main,ai.Callbac=
k,ah.Window.NewElements,ah)
elseif ai.Type=3D=3D"Checkbox"then
al,am=3Dae(ak,ai.Icon,ai.IconSize,ai.ToggleFrame.UIElements.Main,ai.Callbac=
k,ah)
else
error("Unknown Toggle Type: "..tostring(ai.Type))
end

al.AnchorPoint=3DVector2.new(1,ah.Window.NewElements and 0 or 0.5)
al.Position=3DUDim2.new(1,0,ah.Window.NewElements and 0 or 0.5,0)

function ai.Set(an,ao,ap,aq)
if aj then
am:Set(ao,ap,aq or false)
ak=3Dao
ai.Value=3Dao
end
end

ai:Set(ak,false,ah.Window.NewElements)


if ah.Window.NewElements and am.Animate then
if ai.Type=3D=3D"Toggle"then
aa.AddSignal(al.ToggleFrame.Hitbox.InputBegan,function(an)
if not ah.Window.IsToggleDragging and an.UserInputType=3D=3DEnum.UserInputT=
ype.MouseButton1 or an.UserInputType=3D=3DEnum.UserInputType.Touch then
am:Animate(an,ai)
end
end)
end





else
if ai.Type=3D=3D"Toggle"then
aa.AddSignal(al.ToggleFrame.Hitbox.MouseButton1Click,function()
ai:Set(not ai.Value,nil,ah.Window.NewElements)
end)
elseif ai.Type=3D=3D"Checkbox"then
aa.AddSignal(al.MouseButton1Click,function()
ai:Set(not ai.Value,nil,ah.Window.NewElements)
end)
end
end

return ai.__type,ai
end

return af end function a.H()
local aa=3D(cloneref or clonereference or function(aa)return aa end)


local ac=3Daa(game:GetService"UserInputService")
local ad=3Daa(game:GetService"RunService")

local ae=3Da.load'c'
local af=3Dae.New
local ag=3Dae.Tween


local ah=3D{}

local ai=3Dfalse

function ah.New(aj,ak)
local al=3D{
__type=3D"Slider",
Title=3Dak.Title or nil,
Desc=3Dak.Desc or nil,
Locked=3Dak.Locked or nil,
LockedTitle=3Dak.LockedTitle,
Value=3Dak.Value or{},
Icons=3Dak.Icons or nil,
IsTooltip=3Dak.IsTooltip or false,
IsTextbox=3Dak.IsTextbox,
Step=3Dak.Step or 1,
Callback=3Dak.Callback or function()end,
UIElements=3D{},
IsFocusing=3Dfalse,

Width=3Dak.Width or 130,
TextBoxWidth=3Dak.Window.NewElements and 40 or 30,
ThumbSize=3D13,
IconSize=3D26,
}
if al.Icons=3D=3D{}then
al.Icons=3D{
From=3D"sfsymbols:sunMinFill",
To=3D"sfsymbols:sunMaxFill",
}
end
if al.IsTextbox=3D=3Dnil and al.Title=3D=3Dnil then al.IsTextbox=3Dfalse el=
se al.IsTextbox=3Dal.IsTextbox~=3Dfalse end

local am
local an
local ao
local ap=3Dal.Value.Default or al.Value.Min or 0

local aq=3Dap
local ar=3D(ap-(al.Value.Min or 0))/((al.Value.Max or 100)-(al.Value.Min or=
 0))

local as=3Dtrue
local at=3Dal.Step%1~=3D0

local function FormatValue(au)
if at then
return tonumber(string.format("%.2f",au))
end
return math.floor(au+0.5)
end

local function CalculateValue(au)
if at then
return math.floor(au/al.Step+0.5)*al.Step
else
return math.floor(au/al.Step+0.5)*al.Step
end
end

local au,av
local aw=3D32
if al.Icons then
if al.Icons.From then
au=3Dae.Image(
al.Icons.From,
al.Icons.From,
0,
ak.Window.Folder,
"SliderIconFrom",
true,
true,
"SliderIconFrom"
)
au.Size=3DUDim2.new(0,al.IconSize,0,al.IconSize)
aw=3Daw+al.IconSize-2
end
if al.Icons.To then
av=3Dae.Image(
al.Icons.To,
al.Icons.To,
0,
ak.Window.Folder,
"SliderIconTo",
true,
true,
"SliderIconTo"
)
av.Size=3DUDim2.new(0,al.IconSize,0,al.IconSize)
aw=3Daw+al.IconSize-2
end
end
al.SliderFrame=3Da.load'B'{
Title=3Dal.Title,
Desc=3Dal.Desc,
Parent=3Dak.Parent,
TextOffset=3Dal.Width,
Hover=3Dfalse,
Tab=3Dak.Tab,
Index=3Dak.Index,
Window=3Dak.Window,
ElementTable=3Dal,
ParentConfig=3Dak,
}


al.UIElements.SliderIcon=3Dae.NewRoundFrame(99,"Squircle",{
ImageTransparency=3D.95,
Size=3DUDim2.new(1,not al.IsTextbox and-aw or(-al.TextBoxWidth-8),0,4),
AnchorPoint=3DVector2.new(0.5,0.5),
Position=3DUDim2.new(0.5,0,0.5,0),
Name=3D"Frame",
ThemeTag=3D{
ImageColor3=3D"Text",
},
},{
ae.NewRoundFrame(99,"Squircle",{
Name=3D"Frame",
Size=3DUDim2.new(ar,0,1,0),
ImageTransparency=3D.1,
ThemeTag=3D{
ImageColor3=3D"Slider",
},
},{
ae.NewRoundFrame(99,"Squircle",{
Size=3DUDim2.new(0,ak.Window.NewElements and(al.ThumbSize*2)or(al.ThumbSize=
+2),0,ak.Window.NewElements and(al.ThumbSize+4)or(al.ThumbSize+2)),
Position=3DUDim2.new(1,0,0.5,0),
AnchorPoint=3DVector2.new(0.5,0.5),
ThemeTag=3D{
ImageColor3=3D"SliderThumb",
},
Name=3D"Thumb",
},{
ae.NewRoundFrame(99,"Glass-1",{
Size=3DUDim2.new(1,0,1,0),
ImageColor3=3DColor3.new(1,1,1),
Name=3D"Highlight",
ImageTransparency=3D.6,
},{













}),
})
})
})

al.UIElements.SliderContainer=3Daf("Frame",{
Size=3DUDim2.new(al.Title=3D=3Dnil and 1 or 0,al.Title=3D=3Dnil and 0 or al=
.Width,0,0),
AutomaticSize=3D"Y",
Position=3DUDim2.new(1,al.IsTextbox and(ak.Window.NewElements and-16 or 0)o=
r 0,0.5,0),
AnchorPoint=3DVector2.new(1,0.5),
BackgroundTransparency=3D1,
Parent=3Dal.SliderFrame.UIElements.Main,
},{
af("UIListLayout",{
Padding=3DUDim.new(0,al.Title~=3Dnil and 8 or 12),
FillDirection=3D"Horizontal",
VerticalAlignment=3D"Center",
HorizontalAlignment=3Dal.Icons and(al.Icons.From and(al.Icons.To and"Center=
"or"Left")or al.Icons.To and"Right")or"Center",
}),
au,
al.UIElements.SliderIcon,
av,
af("TextBox",{
Size=3DUDim2.new(0,al.TextBoxWidth,0,0),
TextXAlignment=3D"Left",
Text=3DFormatValue(ap),
ThemeTag=3D{
TextColor3=3D"Text"
},
TextTransparency=3D.4,
AutomaticSize=3D"Y",
TextSize=3D15,
FontFace=3DFont.new(ae.Font,Enum.FontWeight.Medium),
BackgroundTransparency=3D1,
LayoutOrder=3D-1,
Visible=3Dal.IsTextbox,
})
})

local ax
if al.IsTooltip then
ax=3Da.load'A'.New(ap,al.UIElements.SliderIcon.Frame.Thumb,true,"Secondary"=
,"Small",false)
ax.Container.AnchorPoint=3DVector2.new(0.5,1)
ax.Container.Position=3DUDim2.new(0.5,0,0,-8)
end

function al.Lock(ay)
al.Locked=3Dtrue
as=3Dfalse
return al.SliderFrame:Lock(al.LockedTitle)
end
function al.Unlock(ay)
al.Locked=3Dfalse
as=3Dtrue
return al.SliderFrame:Unlock()
end

if al.Locked then
al:Lock()
end


local ay=3Dak.Tab.UIElements.ContainerFrame

function al.Set(az,aA,aB)
if as then
if not al.IsFocusing and not ai and(not aB or(aB.UserInputType=3D=3DEnum.Us=
erInputType.MouseButton1 or aB.UserInputType=3D=3DEnum.UserInputType.Touch)=
)then
if aB then
am=3D(aB.UserInputType=3D=3DEnum.UserInputType.Touch)
ay.ScrollingEnabled=3Dfalse
ai=3Dtrue

local b=3Dam and aB.Position.X or ac:GetMouseLocation().X
local d=3Dmath.clamp((b-al.UIElements.SliderIcon.AbsolutePosition.X)/al.UIE=
lements.SliderIcon.AbsoluteSize.X,0,1)
aA=3DCalculateValue(al.Value.Min+d*(al.Value.Max-al.Value.Min))
aA=3Dmath.clamp(aA,al.Value.Min or 0,al.Value.Max or 100)

if aA~=3Daq then
ag(al.UIElements.SliderIcon.Frame,0.05,{Size=3DUDim2.new(d,0,1,0)}):Play()
al.UIElements.SliderContainer.TextBox.Text=3DFormatValue(aA)
if ax then ax.TitleFrame.Text=3DFormatValue(aA)end
al.Value.Default=3DFormatValue(aA)
aq=3DaA
ae.SafeCallback(al.Callback,FormatValue(aA))
end

an=3Dad.RenderStepped:Connect(function()
local f=3Dam and aB.Position.X or ac:GetMouseLocation().X
local g=3Dmath.clamp((f-al.UIElements.SliderIcon.AbsolutePosition.X)/al.UIE=
lements.SliderIcon.AbsoluteSize.X,0,1)
aA=3DCalculateValue(al.Value.Min+g*(al.Value.Max-al.Value.Min))

if aA~=3Daq then
ag(al.UIElements.SliderIcon.Frame,0.05,{Size=3DUDim2.new(g,0,1,0)}):Play()
al.UIElements.SliderContainer.TextBox.Text=3DFormatValue(aA)
if ax then ax.TitleFrame.Text=3DFormatValue(aA)end
al.Value.Default=3DFormatValue(aA)
aq=3DaA
ae.SafeCallback(al.Callback,FormatValue(aA))
end
end)


ao=3Dac.InputEnded:Connect(function(f)
if(f.UserInputType=3D=3DEnum.UserInputType.MouseButton1 or f.UserInputType=
=3D=3DEnum.UserInputType.Touch)and aB=3D=3Df then
an:Disconnect()
ao:Disconnect()
ai=3Dfalse
ay.ScrollingEnabled=3Dtrue

if ak.Window.NewElements then
ag(al.UIElements.SliderIcon.Frame.Thumb,.2,{ImageTransparency=3D0,Size=3DUD=
im2.new(0,ak.Window.NewElements and(al.ThumbSize*2)or(al.ThumbSize+2),0,ak.=
Window.NewElements and(al.ThumbSize+4)or(al.ThumbSize+2))},Enum.EasingStyle=
.Quint,Enum.EasingDirection.InOut):Play()
end
if ax then ax:Close(false)end
end
end)
else
aA=3Dmath.clamp(aA,al.Value.Min or 0,al.Value.Max or 100)

local b=3Dmath.clamp((aA-(al.Value.Min or 0))/((al.Value.Max or 100)-(al.Va=
lue.Min or 0)),0,1)
aA=3DCalculateValue(al.Value.Min+b*(al.Value.Max-al.Value.Min))

if aA~=3Daq then
ag(al.UIElements.SliderIcon.Frame,0.05,{Size=3DUDim2.new(b,0,1,0)}):Play()
al.UIElements.SliderContainer.TextBox.Text=3DFormatValue(aA)
if ax then ax.TitleFrame.Text=3DFormatValue(aA)end
al.Value.Default=3DFormatValue(aA)
aq=3DaA
ae.SafeCallback(al.Callback,FormatValue(aA))
end
end
end
end
end

function al.SetMax(az,aA)
al.Value.Max=3DaA

local aB=3Dtonumber(al.Value.Default)or aq
if aB&gt;aA then
al:Set(aA)
else
local b=3Dmath.clamp((aB-(al.Value.Min or 0))/(aA-(al.Value.Min or 0)),0,1)
ag(al.UIElements.SliderIcon.Frame,0.1,{Size=3DUDim2.new(b,0,1,0)}):Play()
end
end

function al.SetMin(az,aA)
al.Value.Min=3DaA

local aB=3Dtonumber(al.Value.Default)or aq
if aB&lt;aA then
al:Set(aA)
else
local b=3Dmath.clamp((aB-aA)/((al.Value.Max or 100)-aA),0,1)
ag(al.UIElements.SliderIcon.Frame,0.1,{Size=3DUDim2.new(b,0,1,0)}):Play()
end
end

ae.AddSignal(al.UIElements.SliderContainer.TextBox.FocusLost,function(az)
if az then
local aA=3Dtonumber(al.UIElements.SliderContainer.TextBox.Text)
if aA then
al:Set(aA)
else
al.UIElements.SliderContainer.TextBox.Text=3DFormatValue(aq)
if ax then ax.TitleFrame.Text=3DFormatValue(aq)end
end
end
end)

ae.AddSignal(al.UIElements.SliderContainer.InputBegan,function(az)
if al.Locked or ai then
return
end

al:Set(ap,az)

if az.UserInputType=3D=3DEnum.UserInputType.MouseButton1 or az.UserInputTyp=
e=3D=3DEnum.UserInputType.Touch then

if ak.Window.NewElements then
ag(al.UIElements.SliderIcon.Frame.Thumb,.24,{ImageTransparency=3D.85,Size=
=3DUDim2.new(0,(ak.Window.NewElements and(al.ThumbSize*2)or(al.ThumbSize))+=
8,0,al.ThumbSize+8)},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play(=
)
end
if ax then ax:Open()end

end
end)

return al.__type,al
end

return ah end function a.I()
local aa=3D(cloneref or clonereference or function(aa)
return aa
end)

local ac=3Daa(game:GetService"UserInputService")

local ad=3Da.load'c'
local ae=3Dad.New local af=3D
ad.Tween

local ag=3D{
UICorner=3D6,
UIPadding=3D8,
}

local ah=3Da.load'v'.New

function ag.New(ai,aj)
local function NormalizeKeyCode(ak)
if typeof(ak)=3D=3D"EnumItem"then
return ak.Name
elseif type(ak)=3D=3D"string"then
return ak
else
return"F"
end
end

local ak=3D{
__type=3D"Keybind",
Title=3Daj.Title or"Keybind",
Desc=3Daj.Desc or nil,
Locked=3Daj.Locked or false,
LockedTitle=3Daj.LockedTitle,
Value=3DNormalizeKeyCode(aj.Value)or"F",
Callback=3Daj.Callback or function()end,
CanChange=3Daj.CanChange~=3Dfalse,
Blacklist=3Daj.Blacklist or{},
Picking=3Dfalse,
UIElements=3D{},
}

local al=3D{}

for am,an in next,ak.Blacklist do
table.insert(al,Enum.KeyCode[NormalizeKeyCode(an)])
end
table.insert(al,Enum.KeyCode[NormalizeKeyCode"Escape"])

local am=3Dtrue

ak.KeybindFrame=3Da.load'B'{
Title=3Dak.Title,
Desc=3Dak.Desc,
Parent=3Daj.Parent,
TextOffset=3D85,
Hover=3Dak.CanChange,
Tab=3Daj.Tab,
Index=3Daj.Index,
Window=3Daj.Window,
ElementTable=3Dak,
ParentConfig=3Daj,
}

ak.UIElements.Keybind=3Dah(
ak.Value,
nil,
ak.KeybindFrame.UIElements.Main,
nil,
aj.Window.NewElements and 12 or 10
)

ak.UIElements.Keybind.Size=3D
UDim2.new(0,24+ak.UIElements.Keybind.Frame.Frame.TextLabel.TextBounds.X,0,4=
2)
ak.UIElements.Keybind.AnchorPoint=3DVector2.new(1,0.5)
ak.UIElements.Keybind.Position=3DUDim2.new(1,0,0.5,0)
ak.UIElements.Keybind.Interactable=3Dfalse

ae("UIScale",{
Parent=3Dak.UIElements.Keybind,
Scale=3D0.85,
})

ad.AddSignal(
ak.UIElements.Keybind.Frame.Frame.TextLabel:GetPropertyChangedSignal"TextBo=
unds",
function()
ak.UIElements.Keybind.Size=3D
UDim2.new(0,24+ak.UIElements.Keybind.Frame.Frame.TextLabel.TextBounds.X,0,4=
2)
end
)

function ak.Lock(an)
ak.Locked=3Dtrue
am=3Dfalse
return ak.KeybindFrame:Lock(ak.LockedTitle)
end
function ak.Unlock(an)
ak.Locked=3Dfalse
am=3Dtrue
return ak.KeybindFrame:Unlock()
end

function ak.Set(an,ao)
local ap=3DNormalizeKeyCode(ao)
ak.Value=3Dap
ak.UIElements.Keybind.Frame.Frame.TextLabel.Text=3Dap
end

if ak.Locked then
ak:Lock()
end

local an

ad.AddSignal(ak.KeybindFrame.UIElements.Main.MouseButton1Click,function()
if am then
if ak.CanChange then
ak.Picking=3Dtrue
ak.UIElements.Keybind.Frame.Frame.TextLabel.Text=3D"..."



local ao
ao=3Dac.InputBegan:Connect(function(ap)
local aq

if ap.UserInputType=3D=3DEnum.UserInputType.Keyboard then
if table.find(al,ap.KeyCode)then
aq=3Dnil
return
else
aq=3Dap.KeyCode.Name
end
elseif
ap.UserInputType=3D=3DEnum.UserInputType.MouseButton1
and not table.find(al,"MouseLeftButton")
then
aq=3D"MouseLeftButton"
elseif
ap.UserInputType=3D=3DEnum.UserInputType.MouseButton2
and not table.find(al,"MouseRightButton")
then
aq=3D"MouseRightButton"
end

if an then
an:Disconnect()
end

an=3Dac.InputEnded:Connect(function(ar)
if
aq
and(
ar.KeyCode.Name=3D=3Daq
or aq=3D=3D"MouseLeft"and ar.UserInputType=3D=3DEnum.UserInputType.MouseBut=
ton1
or aq=3D=3D"MouseRight"and ar.UserInputType=3D=3DEnum.UserInputType.MouseBu=
tton2
)
then
ak.Picking=3Dfalse

ak.UIElements.Keybind.Frame.Frame.TextLabel.Text=3Daq
ak.Value=3Daq

ao:Disconnect()
an:Disconnect()
end
end)
end)
end
end
end)

ad.AddSignal(ac.InputBegan,function(ao,ap)
if ac:GetFocusedTextBox()then
return
end
if not am then
return
end
if ak.Picking then
return
end

if ao.UserInputType=3D=3DEnum.UserInputType.Keyboard then
if ao.KeyCode.Name=3D=3Dak.Value then
ad.SafeCallback(ak.Callback,ao.KeyCode.Name)
end
elseif ao.UserInputType=3D=3DEnum.UserInputType.MouseButton1 and ak.Value=
=3D=3D"MouseLeft"then
ad.SafeCallback(ak.Callback,"MouseLeft")
elseif ao.UserInputType=3D=3DEnum.UserInputType.MouseButton2 and ak.Value=
=3D=3D"MouseRight"then
ad.SafeCallback(ak.Callback,"MouseRight")
end
end)

return ak.__type,ak
end

return ag end function a.J()

local aa=3Da.load'c'
local ac=3Daa.New local ad=3D
aa.Tween

local ae=3D{
UICorner=3D8,
UIPadding=3D8,
}local af=3Da.load'l'


.New
local ag=3Da.load'm'.New

function ae.New(ah,ai)
local aj=3D{
__type=3D"Input",
Title=3Dai.Title or"Input",
Desc=3Dai.Desc or nil,
Type=3Dai.Type or"Input",
Locked=3Dai.Locked or false,
LockedTitle=3Dai.LockedTitle,
InputIcon=3Dai.InputIcon or false,
Placeholder=3Dai.Placeholder or"Enter Text...",
Value=3Dai.Value or"",
Callback=3Dai.Callback or function()end,
ClearTextOnFocus=3Dai.ClearTextOnFocus or false,
UIElements=3D{},

Width=3D150,
}

local ak=3Dtrue

aj.InputFrame=3Da.load'B'{
Title=3Daj.Title,
Desc=3Daj.Desc,
Parent=3Dai.Parent,
TextOffset=3Daj.Width,
Hover=3Dfalse,
Tab=3Dai.Tab,
Index=3Dai.Index,
Window=3Dai.Window,
ElementTable=3Daj,
ParentConfig=3Dai,
}

local al=3Dag(
aj.Placeholder,
aj.InputIcon,
aj.Type=3D=3D"Textarea"and aj.InputFrame.UIElements.Container or aj.InputFr=
ame.UIElements.Main,
aj.Type,
function(al)
aj:Set(al,true)
end,
nil,
ai.Window.NewElements and 12 or 10,
aj.ClearTextOnFocus
)

if aj.Type=3D=3D"Input"then
al.Size=3DUDim2.new(0,aj.Width,0,36)
al.Position=3DUDim2.new(1,0,ai.Window.NewElements and 0 or 0.5,0)
al.AnchorPoint=3DVector2.new(1,ai.Window.NewElements and 0 or 0.5)
else
al.Size=3DUDim2.new(1,0,0,148)
end

ac("UIScale",{
Parent=3Dal,
Scale=3D1,
})

function aj.Lock(am)
aj.Locked=3Dtrue
ak=3Dfalse
return aj.InputFrame:Lock(aj.LockedTitle)
end
function aj.Unlock(am)
aj.Locked=3Dfalse
ak=3Dtrue
return aj.InputFrame:Unlock()
end


function aj.Set(am,an,ao)
if ak then
aj.Value=3Dan
aa.SafeCallback(aj.Callback,an)

if not ao then
al.Frame.Frame.TextBox.Text=3Dan
end
end
end

function aj.SetPlaceholder(am,an)
al.Frame.Frame.TextBox.PlaceholderText=3Dan
aj.Placeholder=3Dan
end

aj:Set(aj.Value)

if aj.Locked then
aj:Lock()
end

return aj.__type,aj
end

return ae end function a.K()
local aa=3Da.load'c'
local ac=3Daa.New

local ae=3D{}

function ae.New(af,ag)
local ah=3Dac("Frame",{
Size=3Dag.ParentType~=3D"Group"and UDim2.new(1,0,0,1)or UDim2.new(0,1,1,0),
Position=3DUDim2.new(0.5,0,0.5,0),
AnchorPoint=3DVector2.new(0.5,0.5),
BackgroundTransparency=3D.9,
ThemeTag=3D{
BackgroundColor3=3D"Text"
}
})
local ai=3Dac("Frame",{
Parent=3Dag.Parent,
Size=3Dag.ParentType~=3D"Group"and UDim2.new(1,-7,0,7)or UDim2.new(0,7,1,-7=
),
BackgroundTransparency=3D1,
},{
ah
})

return"Divider",{__type=3D"Divider",ElementFrame=3Dai}
end

return ae end function a.L()
local aa=3D{}

local ac=3D(cloneref or clonereference or function(ac)
return ac
end)

local ae=3Dac(game:GetService"UserInputService")
local af=3Dac(game:GetService"Players").LocalPlayer:GetMouse()
local ag=3Dac(game:GetService"Workspace").CurrentCamera

local ah=3Dworkspace.CurrentCamera

local ai=3Da.load'm'.New

local aj=3Da.load'c'
local ak=3Daj.New
local al=3Daj.Tween

function aa.New(am,an,ao,ap,aq)
local ar=3D{}

if not an.Callback then
aq=3D"Menu"
end

an.UIElements.UIListLayout=3Dak("UIListLayout",{
Padding=3DUDim.new(0,ao.MenuPadding/1.5),
FillDirection=3D"Vertical",
HorizontalAlignment=3D"Center",
})

an.UIElements.Menu=3Daj.NewRoundFrame(ao.MenuCorner,"Squircle",{
ThemeTag=3D{
ImageColor3=3D"Background",
},
ImageTransparency=3D1,
Size=3DUDim2.new(1,0,1,0),
AnchorPoint=3DVector2.new(1,0),
Position=3DUDim2.new(1,0,0,0),
},{
ak("UIPadding",{
PaddingTop=3DUDim.new(0,ao.MenuPadding),
PaddingLeft=3DUDim.new(0,ao.MenuPadding),
PaddingRight=3DUDim.new(0,ao.MenuPadding),
PaddingBottom=3DUDim.new(0,ao.MenuPadding),
}),
ak("UIListLayout",{
FillDirection=3D"Vertical",
Padding=3DUDim.new(0,ao.MenuPadding),
}),
ak("Frame",{
BackgroundTransparency=3D1,
Size=3DUDim2.new(1,0,1,an.SearchBarEnabled and-ao.MenuPadding-ao.SearchBarH=
eight),

ClipsDescendants=3Dtrue,
LayoutOrder=3D999,
Name=3D"Frame",
},{
ak("UICorner",{
CornerRadius=3DUDim.new(0,ao.MenuCorner-ao.MenuPadding),
}),
ak("ScrollingFrame",{
Size=3DUDim2.new(1,0,1,0),
ScrollBarThickness=3D0,
ScrollingDirection=3D"Y",
AutomaticCanvasSize=3D"Y",
CanvasSize=3DUDim2.new(0,0,0,0),
BackgroundTransparency=3D1,
ScrollBarImageTransparency=3D1,
},{
an.UIElements.UIListLayout,
}),
}),
})

an.UIElements.MenuCanvas=3Dak("Frame",{
Size=3DUDim2.new(0,an.MenuWidth,0,300),
BackgroundTransparency=3D1,
Position=3DUDim2.new(-10,0,-10,0),
Visible=3Dfalse,
Active=3Dfalse,

Parent=3Dam.WindUI.DropdownGui,
AnchorPoint=3DVector2.new(1,0),
},{
an.UIElements.Menu,
ak("UISizeConstraint",{
MinSize=3DVector2.new(170,0),
MaxSize=3DVector2.new(300,400),
}),
})

local function RecalculateCanvasSize()
an.UIElements.Menu.Frame.ScrollingFrame.CanvasSize=3D
UDim2.fromOffset(0,an.UIElements.UIListLayout.AbsoluteContentSize.Y)
end

local function RecalculateListSize()
local as=3Dah.ViewportSize.Y*0.6

local at=3Dan.UIElements.UIListLayout.AbsoluteContentSize.Y
local au=3Dan.SearchBarEnabled and(ao.SearchBarHeight+(ao.MenuPadding*3))
or(ao.MenuPadding*2)
local av=3Dat+au

if av&gt;as then
an.UIElements.MenuCanvas.Size=3D
UDim2.fromOffset(an.UIElements.MenuCanvas.AbsoluteSize.X,as)
else
an.UIElements.MenuCanvas.Size=3D
UDim2.fromOffset(an.UIElements.MenuCanvas.AbsoluteSize.X,av)
end
end

function UpdatePosition()
local as=3Dan.UIElements.Dropdown or an.DropdownFrame.UIElements.Main
local at=3Dan.UIElements.MenuCanvas

local au=3Dag.ViewportSize.Y
-(as.AbsolutePosition.Y+as.AbsoluteSize.Y)
-ao.MenuPadding
-54
local av=3Dat.AbsoluteSize.Y+ao.MenuPadding

local aw=3D-54
if au&lt;av then
aw=3Dav-au-54
end

at.Position=3DUDim2.new(
0,
as.AbsolutePosition.X+as.AbsoluteSize.X,
0,
as.AbsolutePosition.Y+as.AbsoluteSize.Y-aw+(ao.MenuPadding*2)
)
end

local as

function ar.Display(at)
local au=3Dan.Values
local av=3D""

if an.Multi then
local aw=3D{}
if typeof(an.Value)=3D=3D"table"then
for ax,ay in ipairs(an.Value)do
local az=3Dtypeof(ay)=3D=3D"table"and ay.Title or ay
aw[az]=3Dtrue
end
end

for ax,ay in ipairs(au)do
local az=3Dtypeof(ay)=3D=3D"table"and ay.Title or ay
if aw[az]then
av=3Dav..az..", "
end
end

if#av&gt;0 then
av=3Dav:sub(1,#av-2)
end
else
av=3Dtypeof(an.Value)=3D=3D"table"and(an.Value.Title or an.Value[1])
or an.Value
or""
end

if an.UIElements.Dropdown then
an.UIElements.Dropdown.Frame.Frame.TextLabel.Text=3D(av=3D=3D""and"--"or av=
)
end
end

local function Callback(at)
ar:Display()
if an.Callback then
task.spawn(function()
aj.SafeCallback(an.Callback,an.Value)
end)
else
task.spawn(function()
aj.SafeCallback(at)
end)
end
end

function ar.LockValues(at,au)
if not au then
return
end

for av,aw in next,an.Tabs do
if aw and aw.UIElements and aw.UIElements.TabItem then
local ax=3Daw.Name
local ay=3Dfalse

for az,aA in next,au do
if ax=3D=3DaA then
ay=3Dtrue
break
end
end

if ay then
al(aw.UIElements.TabItem,0.1,{ImageTransparency=3D1}):Play()
al(aw.UIElements.TabItem.Highlight,0.1,{ImageTransparency=3D1}):Play()
al(aw.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=3D0.6}=
):Play()
if aw.UIElements.TabIcon then
al(aw.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=3D0.6}):Play()
end

aw.UIElements.TabItem.Active=3Dfalse
aw.Locked=3Dtrue
else
if aw.Selected then
al(aw.UIElements.TabItem,0.1,{ImageTransparency=3D0.95}):Play()
al(aw.UIElements.TabItem.Highlight,0.1,{ImageTransparency=3D0.75}):Play()
al(aw.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=3D0}):=
Play()
if aw.UIElements.TabIcon then
al(aw.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=3D0}):Play()
end
else
al(aw.UIElements.TabItem,0.1,{ImageTransparency=3D1}):Play()
al(aw.UIElements.TabItem.Highlight,0.1,{ImageTransparency=3D1}):Play()
al(
aw.UIElements.TabItem.Frame.Title.TextLabel,
0.1,
{TextTransparency=3Daq=3D=3D"Dropdown"and 0.4 or 0.05}
):Play()
if aw.UIElements.TabIcon then
al(
aw.UIElements.TabIcon.ImageLabel,
0.1,
{ImageTransparency=3Daq=3D=3D"Dropdown"and 0.2 or 0}
):Play()
end
end

aw.UIElements.TabItem.Active=3Dtrue
aw.Locked=3Dfalse
end
end
end
end

function ar.Refresh(at,au)
if am.Window.Destroyed then
return
end

for av,aw in next,an.UIElements.Menu.Frame.ScrollingFrame:GetChildren()do
if not aw:IsA"UIListLayout"then
aw:Destroy()
end
end

an.Tabs=3D{}

if an.SearchBarEnabled then
if not as then
as=3Dai("Search...","search",an.UIElements.Menu,nil,function(av)
for aw,ax in next,an.Tabs do
if string.find(string.lower(ax.Name),string.lower(av),1,true)then
ax.UIElements.TabItem.Visible=3Dtrue
else
ax.UIElements.TabItem.Visible=3Dfalse
end
RecalculateListSize()
RecalculateCanvasSize()
end
end,true)
as.Size=3DUDim2.new(1,0,0,ao.SearchBarHeight)
as.Position=3DUDim2.new(0,0,0,0)
as.Name=3D"SearchBar"
end
end

for av,aw in next,au do
if aw.Type~=3D"Divider"then
local ax=3D{
Name=3Dtypeof(aw)=3D=3D"table"and aw.Title or aw,
Desc=3Dtypeof(aw)=3D=3D"table"and aw.Desc or nil,
Icon=3Dtypeof(aw)=3D=3D"table"and aw.Icon or nil,
IconSize=3Dtypeof(aw)=3D=3D"table"and aw.IconSize or nil,
Original=3Daw,
Selected=3Dfalse,
Locked=3Dtypeof(aw)=3D=3D"table"and aw.Locked or false,
UIElements=3D{},
}
local ay
if ax.Icon then
ay=3Daj.Image(ax.Icon,ax.Icon,0,am.Window.Folder,"Dropdown",true)
ay.Size=3D
UDim2.new(0,ax.IconSize or ao.TabIcon,0,ax.IconSize or ao.TabIcon)
ay.ImageLabel.ImageTransparency=3Daq=3D=3D"Dropdown"and 0.2 or 0
ax.UIElements.TabIcon=3Day
end
ax.UIElements.TabItem=3Daj.NewRoundFrame(
ao.MenuCorner-ao.MenuPadding,
"Squircle",
{
Size=3DUDim2.new(1,0,0,36),
AutomaticSize=3Dax.Desc and"Y",
ImageTransparency=3D1,
Parent=3Dan.UIElements.Menu.Frame.ScrollingFrame,
ImageColor3=3DColor3.new(1,1,1),
Active=3Dnot ax.Locked,
},
{
aj.NewRoundFrame(ao.MenuCorner-ao.MenuPadding,"Glass-1.4",{
Size=3DUDim2.new(1,0,1,0),
ThemeTag=3D{
ImageColor3=3D"DropdownTabBorder",
},
ImageTransparency=3D1,
Name=3D"Highlight",
},{













}),
ak("Frame",{
Size=3DUDim2.new(1,0,1,0),
BackgroundTransparency=3D1,
},{
ak("UIListLayout",{
Padding=3DUDim.new(0,ao.TabPadding),
FillDirection=3D"Horizontal",
VerticalAlignment=3D"Center",
}),
ak("UIPadding",{
PaddingTop=3DUDim.new(0,ao.TabPadding),
PaddingLeft=3DUDim.new(0,ao.TabPadding),
PaddingRight=3DUDim.new(0,ao.TabPadding),
PaddingBottom=3DUDim.new(0,ao.TabPadding),
}),
ak("UICorner",{
CornerRadius=3DUDim.new(0,ao.MenuCorner-ao.MenuPadding),
}),
ay,
ak("Frame",{
Size=3DUDim2.new(1,ay and-ao.TabPadding-ao.TabIcon or 0,0,0),
BackgroundTransparency=3D1,
AutomaticSize=3D"Y",
Name=3D"Title",
},{
ak("TextLabel",{
Text=3Dax.Name,
TextXAlignment=3D"Left",
FontFace=3DFont.new(aj.Font,Enum.FontWeight.Medium),
ThemeTag=3D{
TextColor3=3D"Text",
BackgroundColor3=3D"Text",
},
TextSize=3D15,
BackgroundTransparency=3D1,
TextTransparency=3Daq=3D=3D"Dropdown"and 0.4 or 0.05,
LayoutOrder=3D999,
AutomaticSize=3D"Y",
Size=3DUDim2.new(1,0,0,0),
}),
ak("TextLabel",{
Text=3Dax.Desc or"",
TextXAlignment=3D"Left",
FontFace=3DFont.new(aj.Font,Enum.FontWeight.Regular),
ThemeTag=3D{
TextColor3=3D"Text",
BackgroundColor3=3D"Text",
},
TextSize=3D15,
BackgroundTransparency=3D1,
TextTransparency=3Daq=3D=3D"Dropdown"and 0.6 or 0.35,
LayoutOrder=3D999,
AutomaticSize=3D"Y",
TextWrapped=3Dtrue,
Size=3DUDim2.new(1,0,0,0),
Visible=3Dax.Desc and true or false,
Name=3D"Desc",
}),
ak("UIListLayout",{
Padding=3DUDim.new(0,ao.TabPadding/3),
FillDirection=3D"Vertical",
}),
}),
}),
},
true
)

if ax.Locked then
ax.UIElements.TabItem.Frame.Title.TextLabel.TextTransparency=3D0.6
if ax.UIElements.TabIcon then
ax.UIElements.TabIcon.ImageLabel.ImageTransparency=3D0.6
end
end

if an.Multi and typeof(an.Value)=3D=3D"string"then
for az,aA in next,an.Values do
if typeof(aA)=3D=3D"table"then
if aA.Title=3D=3Dan.Value then
an.Value=3D{aA}
end
else
if aA=3D=3Dan.Value then
an.Value=3D{an.Value}
end
end
end
end

if an.Multi then
local az=3Dfalse
if typeof(an.Value)=3D=3D"table"then
for aA,aB in ipairs(an.Value)do
local b=3Dtypeof(aB)=3D=3D"table"and aB.Title or aB
if b=3D=3Dax.Name then
az=3Dtrue
break
end
end
end
ax.Selected=3Daz
else
local az=3Dtypeof(an.Value)=3D=3D"table"and an.Value.Title or an.Value
ax.Selected=3Daz=3D=3Dax.Name
end

if ax.Selected and not ax.Locked then
ax.UIElements.TabItem.ImageTransparency=3D0.95
ax.UIElements.TabItem.Highlight.ImageTransparency=3D0.75
ax.UIElements.TabItem.Frame.Title.TextLabel.TextTransparency=3D0
if ax.UIElements.TabIcon then
ax.UIElements.TabIcon.ImageLabel.ImageTransparency=3D0
end
end

an.Tabs[av]=3Dax

ar:Display()

if aq=3D=3D"Dropdown"then
aj.AddSignal(ax.UIElements.TabItem.MouseButton1Click,function()
if ax.Locked then
return
end

if an.Multi then
if not ax.Selected then
ax.Selected=3Dtrue
al(ax.UIElements.TabItem,0.1,{ImageTransparency=3D0.95}):Play()
al(ax.UIElements.TabItem.Highlight,0.1,{ImageTransparency=3D0.75}):Play()
al(ax.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=3D0}):=
Play()
if ax.UIElements.TabIcon then
al(ax.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=3D0}):Play()
end
table.insert(an.Value,ax.Original)
else
if not an.AllowNone and#an.Value=3D=3D1 then
return
end
ax.Selected=3Dfalse
al(ax.UIElements.TabItem,0.1,{ImageTransparency=3D1}):Play()
al(ax.UIElements.TabItem.Highlight,0.1,{ImageTransparency=3D1}):Play()
al(ax.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=3D0.4}=
):Play()
if ax.UIElements.TabIcon then
al(ax.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=3D0.2}):Play()
end

for az,aA in next,an.Value do
if typeof(aA)=3D=3D"table"and(aA.Title=3D=3Dax.Name)or(aA=3D=3Dax.Name)then
table.remove(an.Value,az)
break
end
end
end
else
for az,aA in next,an.Tabs do
al(aA.UIElements.TabItem,0.1,{ImageTransparency=3D1}):Play()
al(aA.UIElements.TabItem.Highlight,0.1,{ImageTransparency=3D1}):Play()
al(
aA.UIElements.TabItem.Frame.Title.TextLabel,
0.1,
{TextTransparency=3D0.4}
):Play()
if aA.UIElements.TabIcon then
al(aA.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=3D0.2}):Play()
end
aA.Selected=3Dfalse
end
ax.Selected=3Dtrue
al(ax.UIElements.TabItem,0.1,{ImageTransparency=3D0.95}):Play()
al(ax.UIElements.TabItem.Highlight,0.1,{ImageTransparency=3D0.75}):Play()
al(ax.UIElements.TabItem.Frame.Title.TextLabel,0.1,{TextTransparency=3D0}):=
Play()
if ax.UIElements.TabIcon then
al(ax.UIElements.TabIcon.ImageLabel,0.1,{ImageTransparency=3D0}):Play()
end
an.Value=3Dax.Original
end
Callback()
end)
elseif aq=3D=3D"Menu"then
if not ax.Locked then
aj.AddSignal(ax.UIElements.TabItem.MouseEnter,function()
al(ax.UIElements.TabItem,0.08,{ImageTransparency=3D0.95}):Play()
end)
aj.AddSignal(ax.UIElements.TabItem.InputEnded,function()
al(ax.UIElements.TabItem,0.08,{ImageTransparency=3D1}):Play()
end)
end
aj.AddSignal(ax.UIElements.TabItem.MouseButton1Click,function()
if ax.Locked then
return
end
Callback(aw.Callback or function()end)
end)
end

RecalculateCanvasSize()
RecalculateListSize()
else a.load'K'
:New{Parent=3Dan.UIElements.Menu.Frame.ScrollingFrame}
end
end










an.UIElements.MenuCanvas.Size=3DUDim2.new(
0,
an.MenuWidth+6+6+5+5+18+6+6,
an.UIElements.MenuCanvas.Size.Y.Scale,
an.UIElements.MenuCanvas.Size.Y.Offset
)
Callback()

an.Values=3Dau
end

ar:Refresh(an.Values)

function ar.Select(at,au)
if au then
an.Value=3Dau
else
if an.Multi then
an.Value=3D{}
else
an.Value=3Dnil
end
end
ar:Refresh(an.Values)
end

RecalculateListSize()
RecalculateCanvasSize()

function ar.Open(at)
if ap then
an.UIElements.Menu.Visible=3Dtrue
an.UIElements.MenuCanvas.Visible=3Dtrue
an.UIElements.MenuCanvas.Active=3Dtrue
an.UIElements.Menu.Size=3DUDim2.new(1,0,0,0)
al(an.UIElements.Menu,0.1,{
Size=3DUDim2.new(1,0,1,0),
ImageTransparency=3D0.05,
},Enum.EasingStyle.Quart,Enum.EasingDirection.Out):Play()

task.spawn(function()
task.wait(0.1)
an.Opened=3Dtrue
end)

UpdatePosition()
end
end

function ar.Close(at)
an.Opened=3Dfalse

al(an.UIElements.Menu,0.25,{
Size=3DUDim2.new(1,0,0,0),
ImageTransparency=3D1,
},Enum.EasingStyle.Quart,Enum.EasingDirection.Out):Play()

task.spawn(function()
task.wait(0.1)
an.UIElements.Menu.Visible=3Dfalse
end)

task.spawn(function()
task.wait(0.25)
an.UIElements.MenuCanvas.Visible=3Dfalse
an.UIElements.MenuCanvas.Active=3Dfalse
end)
end

aj.AddSignal(
(
an.UIElements.Dropdown and an.UIElements.Dropdown.MouseButton1Click
or an.DropdownFrame.UIElements.Main.MouseButton1Click
),
function()
ar:Open()
end
)

aj.AddSignal(ae.InputBegan,function(at)
if
at.UserInputType=3D=3DEnum.UserInputType.MouseButton1
or at.UserInputType=3D=3DEnum.UserInputType.Touch
then
local au=3Dan.UIElements.MenuCanvas
local av,aw=3Dau.AbsolutePosition,au.AbsoluteSize

local ax=3Dan.UIElements.Dropdown or an.DropdownFrame.UIElements.Main
local ay=3Dax.AbsolutePosition
local az=3Dax.AbsoluteSize

local aA=3Daf.X&gt;=3Day.X
and af.X&lt;=3Day.X+az.X
and af.Y&gt;=3Day.Y
and af.Y&lt;=3Day.Y+az.Y

local aB=3Daf.X&gt;=3Dav.X
and af.X&lt;=3Dav.X+aw.X
and af.Y&gt;=3Dav.Y
and af.Y&lt;=3Dav.Y+aw.Y

if am.Window.CanDropdown and an.Opened and not aA and not aB then
ar:Close()
end
end
end)

aj.AddSignal(
an.UIElements.Dropdown and an.UIElements.Dropdown:GetPropertyChangedSignal"=
AbsolutePosition"
or an.DropdownFrame.UIElements.Main:GetPropertyChangedSignal"AbsolutePositi=
on",
UpdatePosition
)

return ar
end

return aa end function a.M()

local aa=3D(cloneref or clonereference or function(aa)
return aa
end)

aa(game:GetService"UserInputService")
aa(game:GetService"Players").LocalPlayer:GetMouse()local ac=3D
aa(game:GetService"Workspace").CurrentCamera

local ae=3Da.load'c'
local af=3Dae.New local ag=3D
ae.Tween

local ah=3Da.load'v'.New local ai=3Da.load'm'
.New
local aj=3Da.load'L'.New local ak=3D

workspace.CurrentCamera

local al=3D{
UICorner=3D10,
UIPadding=3D12,
MenuCorner=3D15,
MenuPadding=3D5,
TabPadding=3D10,
SearchBarHeight=3D39,
TabIcon=3D18,
}

function al.New(am,an)
local ao=3D{
__type=3D"Dropdown",
Title=3Dan.Title or"Dropdown",
Desc=3Dan.Desc or nil,
Locked=3Dan.Locked or false,
LockedTitle=3Dan.LockedTitle,
Values=3Dan.Values or{},
MenuWidth=3Dan.MenuWidth or 180,
Value=3Dan.Value,
AllowNone=3Dan.AllowNone,
SearchBarEnabled=3Dan.SearchBarEnabled or false,
Multi=3Dan.Multi,
Callback=3Dan.Callback or nil,

UIElements=3D{},

Opened=3Dfalse,
Tabs=3D{},

Width=3D150,
}

if ao.Multi and not ao.Value then
ao.Value=3D{}
end
if ao.Values and typeof(ao.Value)=3D=3D"number"then
ao.Value=3Dao.Values[ao.Value]
end

local ap=3Dtrue

ao.DropdownFrame=3Da.load'B'{
Title=3Dao.Title,
Desc=3Dao.Desc,
Parent=3Dan.Parent,
TextOffset=3Dao.Callback and ao.Width or 20,
Hover=3Dnot ao.Callback and true or false,
Tab=3Dan.Tab,
Index=3Dan.Index,
Window=3Dan.Window,
ElementTable=3Dao,
ParentConfig=3Dan,
}

if ao.Callback then
ao.UIElements.Dropdown=3D
ah("",nil,ao.DropdownFrame.UIElements.Main,nil,an.Window.NewElements and 12=
 or 10)

ao.UIElements.Dropdown.Frame.Frame.TextLabel.TextTruncate=3D"AtEnd"
ao.UIElements.Dropdown.Frame.Frame.TextLabel.Size=3D
UDim2.new(1,ao.UIElements.Dropdown.Frame.Frame.TextLabel.Size.X.Offset-18-1=
2-12,0,0)

ao.UIElements.Dropdown.Size=3DUDim2.new(0,ao.Width,0,36)
ao.UIElements.Dropdown.Position=3DUDim2.new(1,0,an.Window.NewElements and 0=
 or 0.5,0)
ao.UIElements.Dropdown.AnchorPoint=3DVector2.new(1,an.Window.NewElements an=
d 0 or 0.5)





end

ao.DropdownMenu=3Daj(an,ao,al,ap,"Dropdown")

ao.Display=3Dao.DropdownMenu.Display
ao.Refresh=3Dao.DropdownMenu.Refresh
ao.Select=3Dao.DropdownMenu.Select
ao.Open=3Dao.DropdownMenu.Open
ao.Close=3Dao.DropdownMenu.Close

af("ImageLabel",{
Image=3Dae.Icon"chevrons-up-down"[1],
ImageRectOffset=3Dae.Icon"chevrons-up-down"[2].ImageRectPosition,
ImageRectSize=3Dae.Icon"chevrons-up-down"[2].ImageRectSize,
Size=3DUDim2.new(0,18,0,18),
Position=3DUDim2.new(1,ao.UIElements.Dropdown and-12 or 0,0.5,0),
ThemeTag=3D{
ImageColor3=3D"Icon",
},
AnchorPoint=3DVector2.new(1,0.5),
Parent=3Dao.UIElements.Dropdown and ao.UIElements.Dropdown.Frame
or ao.DropdownFrame.UIElements.Main,
})

function ao.Lock(aq)
ao.Locked=3Dtrue
ap=3Dfalse
return ao.DropdownFrame:Lock(ao.LockedTitle)
end
function ao.Unlock(aq)
ao.Locked=3Dfalse
ap=3Dtrue
return ao.DropdownFrame:Unlock()
end

if ao.Locked then
ao:Lock()
end

return ao.__type,ao
end

return al end function a.N()







local aa=3D{}
local ae=3D{
lua=3D{
"and","break","or","else","elseif","if","then","until","repeat","while","do=
","for","in","end",
"local","return","function","export",
},
rbx=3D{
"game","workspace","script","math","string","table","task","wait","select",=
"next","Enum",
"tick","assert","shared","loadstring","tonumber","tostring","type",
"typeof","unpack","Instance","CFrame","Vector3","Vector2","Color3","UDim","=
UDim2","Ray","BrickColor",
"OverlapParams","RaycastParams","Axes","Random","Region3","Rect","TweenInfo=
",
"collectgarbage","not","utf8","pcall","xpcall","_G","setmetatable","getmeta=
table","os","pairs","ipairs"
},
operators=3D{
"#","+","-","*","%","/","^","=3D","~","=3D","&lt;","&gt;",
}
}

local af=3D{
numbers=3DColor3.fromHex"#FAB387",
boolean=3DColor3.fromHex"#FAB387",
operator=3DColor3.fromHex"#94E2D5",
lua=3DColor3.fromHex"#CBA6F7",
rbx=3DColor3.fromHex"#F38BA8",
str=3DColor3.fromHex"#A6E3A1",
comment=3DColor3.fromHex"#9399B2",
null=3DColor3.fromHex"#F38BA8",
call=3DColor3.fromHex"#89B4FA",
self_call=3DColor3.fromHex"#89B4FA",
local_property=3DColor3.fromHex"#CBA6F7",
}

local function createKeywordSet(ah)
local aj=3D{}
for ak,al in ipairs(ah)do
aj[al]=3Dtrue
end
return aj
end

local ah=3DcreateKeywordSet(ae.lua)
local aj=3DcreateKeywordSet(ae.rbx)
local ak=3DcreateKeywordSet(ae.operators)

local function getHighlight(al,am)
local an=3Dal[am]

if af[an.."_color"]then
return af[an.."_color"]
end

if tonumber(an)then
return af.numbers
elseif an=3D=3D"nil"then
return af.null
elseif an:sub(1,2)=3D=3D"--"then
return af.comment
elseif ak[an]then
return af.operator
elseif ah[an]then
return af.lua
elseif aj[an]then
return af.rbx
elseif an:sub(1,1)=3D=3D"\""or an:sub(1,1)=3D=3D"\'"then
return af.str
elseif an=3D=3D"true"or an=3D=3D"false"then
return af.boolean
end

if al[am+1]=3D=3D"("then
if al[am-1]=3D=3D":"then
return af.self_call
end

return af.call
end

if al[am-1]=3D=3D"."then
if al[am-2]=3D=3D"Enum"then
return af.rbx
end

return af.local_property
end
end

function aa.run(al)
local am=3D{}
local an=3D""

local ao=3Dfalse
local ap=3Dfalse
local aq=3Dfalse

for ar=3D1,#al do
local as=3Dal:sub(ar,ar)

if ap then
if as=3D=3D"\n"and not aq then
table.insert(am,an)
table.insert(am,as)
an=3D""

ap=3Dfalse
elseif al:sub(ar-1,ar)=3D=3D"]]"and aq then
an=3Dan.."]"

table.insert(am,an)
an=3D""

ap=3Dfalse
aq=3Dfalse
else
an=3Dan..as
end
elseif ao then
if as=3D=3Dao and al:sub(ar-1,ar-1)~=3D"\\"or as=3D=3D"\n"then
an=3Dan..as
ao=3Dfalse
else
an=3Dan..as
end
else
if al:sub(ar,ar+1)=3D=3D"--"then
table.insert(am,an)
an=3D"-"
ap=3Dtrue
aq=3Dal:sub(ar+2,ar+3)=3D=3D"[["
elseif as=3D=3D"\""or as=3D=3D"\'"then
table.insert(am,an)
an=3Das
ao=3Das
elseif ak[as]then
table.insert(am,an)
table.insert(am,as)
an=3D""
elseif as:match"[%w_]"then
an=3Dan..as
else
table.insert(am,an)
table.insert(am,as)
an=3D""
end
end
end

table.insert(am,an)

local ar=3D{}

for as,at in ipairs(am)do
local au=3DgetHighlight(am,as)

if au then
local av=3Dstring.format("&lt;font color =3D \"#%s\"&gt;%s&lt;/font&gt;",au=
:ToHex(),at:gsub("&lt;","&amp;lt;"):gsub("&gt;","&amp;gt;"))

table.insert(ar,av)
else
table.insert(ar,at)
end
end

return table.concat(ar)
end

return aa end function a.O()
local aa=3D{}

local ae=3Da.load'c'
local af=3Dae.New
local ah=3Dae.Tween

local aj=3Da.load'N'

function aa.New(ak,al,am,an,ao)
local ap=3D{
Radius=3D12,
Padding=3D10
}

local aq=3Daf("TextLabel",{
Text=3D"",
TextColor3=3DColor3.fromHex"#CDD6F4",
TextTransparency=3D0,
TextSize=3D14,
TextWrapped=3Dfalse,
LineHeight=3D1.15,
RichText=3Dtrue,
TextXAlignment=3D"Left",
Size=3DUDim2.new(0,0,0,0),
BackgroundTransparency=3D1,
AutomaticSize=3D"XY",
},{
af("UIPadding",{
PaddingTop=3DUDim.new(0,ap.Padding+3),
PaddingLeft=3DUDim.new(0,ap.Padding+3),
PaddingRight=3DUDim.new(0,ap.Padding+3),
PaddingBottom=3DUDim.new(0,ap.Padding+3),
})
})
aq.Font=3D"Code"

local ar=3Daf("ScrollingFrame",{
Size=3DUDim2.new(1,0,0,0),
BackgroundTransparency=3D1,
AutomaticCanvasSize=3D"X",
ScrollingDirection=3D"X",
ElasticBehavior=3D"Never",
CanvasSize=3DUDim2.new(0,0,0,0),
ScrollBarThickness=3D0,
},{
aq
})

local as=3Daf("TextButton",{
BackgroundTransparency=3D1,
Size=3DUDim2.new(0,30,0,30),
Position=3DUDim2.new(1,-ap.Padding/2,0,ap.Padding/2),
AnchorPoint=3DVector2.new(1,0),
Visible=3Dan and true or false,
},{
ae.NewRoundFrame(ap.Radius-4,"Squircle",{



ImageColor3=3DColor3.fromHex"#ffffff",
ImageTransparency=3D1,
Size=3DUDim2.new(1,0,1,0),
AnchorPoint=3DVector2.new(0.5,0.5),
Position=3DUDim2.new(0.5,0,0.5,0),
Name=3D"Button",
},{
af("UIScale",{
Scale=3D1,
}),
af("ImageLabel",{
Image=3Dae.Icon"copy"[1],
ImageRectSize=3Dae.Icon"copy"[2].ImageRectSize,
ImageRectOffset=3Dae.Icon"copy"[2].ImageRectPosition,
BackgroundTransparency=3D1,
AnchorPoint=3DVector2.new(0.5,0.5),
Position=3DUDim2.new(0.5,0,0.5,0),
Size=3DUDim2.new(0,12,0,12),



ImageColor3=3DColor3.fromHex"#ffffff",
ImageTransparency=3D.1,
})
})
})

ae.AddSignal(as.MouseEnter,function()
ah(as.Button,.05,{ImageTransparency=3D.95}):Play()
ah(as.Button.UIScale,.05,{Scale=3D.9}):Play()
end)
ae.AddSignal(as.InputEnded,function()
ah(as.Button,.08,{ImageTransparency=3D1}):Play()
ah(as.Button.UIScale,.08,{Scale=3D1}):Play()
end)

local at=3Dae.NewRoundFrame(ap.Radius,"Squircle",{



ImageColor3=3DColor3.fromHex"#212121",
ImageTransparency=3D.035,
Size=3DUDim2.new(1,0,0,20+(ap.Padding*2)),
AutomaticSize=3D"Y",
Parent=3Dam,
},{
ae.NewRoundFrame(ap.Radius,"SquircleOutline",{
Size=3DUDim2.new(1,0,1,0),



ImageColor3=3DColor3.fromHex"#ffffff",
ImageTransparency=3D.955,
}),
af("Frame",{
BackgroundTransparency=3D1,
Size=3DUDim2.new(1,0,0,0),
AutomaticSize=3D"Y",
},{
ae.NewRoundFrame(ap.Radius,"Squircle-TL-TR",{



ImageColor3=3DColor3.fromHex"#ffffff",
ImageTransparency=3D.96,
Size=3DUDim2.new(1,0,0,20+(ap.Padding*2)),
Visible=3Dal and true or false
},{
af("ImageLabel",{
Size=3DUDim2.new(0,18,0,18),
BackgroundTransparency=3D1,
Image=3D"rbxassetid://132464694294269",



ImageColor3=3DColor3.fromHex"#ffffff",
ImageTransparency=3D.2,
}),
af("TextLabel",{
Text=3Dal,



TextColor3=3DColor3.fromHex"#ffffff",
TextTransparency=3D.2,
TextSize=3D16,
AutomaticSize=3D"Y",
FontFace=3DFont.new(ae.Font,Enum.FontWeight.Medium),
TextXAlignment=3D"Left",
BackgroundTransparency=3D1,
TextTruncate=3D"AtEnd",
Size=3DUDim2.new(1,as and-20-(ap.Padding*2),0,0)
}),
af("UIPadding",{

PaddingLeft=3DUDim.new(0,ap.Padding+3),
PaddingRight=3DUDim.new(0,ap.Padding+3),

}),
af("UIListLayout",{
Padding=3DUDim.new(0,ap.Padding),
FillDirection=3D"Horizontal",
VerticalAlignment=3D"Center",
})
}),
ar,
af("UIListLayout",{
Padding=3DUDim.new(0,0),
FillDirection=3D"Vertical",
})
}),
as,
})

ap.CodeFrame=3Dat

ae.AddSignal(aq:GetPropertyChangedSignal"TextBounds",function()
ar.Size=3DUDim2.new(1,0,0,(aq.TextBounds.Y/(ao or 1))+((ap.Padding+3)*2))
end)

function ap.Set(au)
aq.Text=3Daj.run(au)
end

function ap.Destroy()
at:Destroy()
ap=3Dnil
end

ap.Set(ak)

ae.AddSignal(as.MouseButton1Click,function()
if an then
an()
local au=3Dae.Icon"check"
as.Button.ImageLabel.Image=3Dau[1]
as.Button.ImageLabel.ImageRectSize=3Dau[2].ImageRectSize
as.Button.ImageLabel.ImageRectOffset=3Dau[2].ImageRectPosition

task.wait(1)
local av=3Dae.Icon"copy"
as.Button.ImageLabel.Image=3Dav[1]
as.Button.ImageLabel.ImageRectSize=3Dav[2].ImageRectSize
as.Button.ImageLabel.ImageRectOffset=3Dav[2].ImageRectPosition
end
end)
return ap
end


return aa end function a.P()
local aa=3Da.load'c'local ae=3D
aa.New


local af=3Da.load'O'

local ah=3D{}

function ah.New(aj,ak)
local al=3D{
__type=3D"Code",
Title=3Dak.Title,
Code=3Dak.Code,
OnCopy=3Dak.OnCopy,
}

local am=3Dnot al.Locked











local an=3Daf.New(al.Code,al.Title,ak.Parent,function()
if am then
local an=3Dal.Title or"code"
local ao,ap=3Dpcall(function()
toclipboard(al.Code)

if al.OnCopy then al.OnCopy()end
end)
if not ao then
ak.WindUI:Notify{
Title=3D"Error",
Content=3D"The "..an.." is not copied. Error: "..ap,
Icon=3D"x",
Duration=3D5,
}
end
end
end,ak.WindUI.UIScale,al)

function al.SetCode(ao,ap)
an.Set(ap)
al.Code=3Dap
end

function al.Set(ao,ap)
return al.SetCode(ap)
end

function al.Destroy(ao)
an.Destroy()
al=3Dnil
end

al.ElementFrame=3Dan.CodeFrame

return al.__type,al
end

return ah end function a.Q()
local aa=3Da.load'c'
local ae=3Daa.New local af=3D
aa.Tween

local ah=3D(cloneref or clonereference or function(ah)return ah end)

local aj=3Dah(game:GetService"UserInputService")
ah(game:GetService"TouchInputService")
local ak=3Dah(game:GetService"RunService")
local al=3Dah(game:GetService"Players")

local am=3Dak.RenderStepped
local an=3Dal.LocalPlayer
local ao=3Dan:GetMouse()

local ap=3Da.load'l'.New
local aq=3Da.load'm'.New

local ar=3D{
UICorner=3D9,

}

function ar.Colorpicker(as,at,au,av,aw)
local ax=3D{
__type=3D"Colorpicker",
Title=3Dat.Title,
Desc=3Dat.Desc,
Default=3Dat.Value or at.Default,
Callback=3Dat.Callback,
Transparency=3Dat.Transparency,
UIElements=3Dat.UIElements,

TextPadding=3D10,
}

function ax.SetHSVFromRGB(ay,az)
local aA,aB,b=3DColor3.toHSV(az)
ax.Hue=3DaA
ax.Sat=3DaB
ax.Vib=3Db
end

ax:SetHSVFromRGB(ax.Default)

local ay=3Da.load'n'
local az=3Day.Create(nil,"Dialog",au,av,au.UIElements.Main.Main)

ax.ColorpickerFrame=3Daz

az.UIElements.Main.Size=3DUDim2.new(1,0,0,0)



local aA,aB,b=3Dax.Hue,ax.Sat,ax.Vib

ax.UIElements.Title=3Dae("TextLabel",{
Text=3Dax.Title,
TextSize=3D20,
FontFace=3DFont.new(aa.Font,Enum.FontWeight.SemiBold),
TextXAlignment=3D"Left",
Size=3DUDim2.new(1,0,0,0),
AutomaticSize=3D"Y",
ThemeTag=3D{
TextColor3=3D"Text"
},
BackgroundTransparency=3D1,
Parent=3Daz.UIElements.Main
},{
ae("UIPadding",{
PaddingTop=3DUDim.new(0,ax.TextPadding/2),
PaddingLeft=3DUDim.new(0,ax.TextPadding/2),
PaddingRight=3DUDim.new(0,ax.TextPadding/2),
PaddingBottom=3DUDim.new(0,ax.TextPadding/2),
})
})





local d=3Dae("Frame",{
Size=3DUDim2.new(0,14,0,14),
AnchorPoint=3DVector2.new(0.5,0.5),
Position=3DUDim2.new(0.5,0,0,0),
Parent=3DHueDragHolder,
BackgroundColor3=3Dax.Default
},{
ae("UIStroke",{
Thickness=3D2,
Transparency=3D.1,
ThemeTag=3D{
Color=3D"Text",
},
}),
ae("UICorner",{
CornerRadius=3DUDim.new(1,0),
})
})

ax.UIElements.SatVibMap=3Dae("ImageLabel",{
Size=3DUDim2.fromOffset(160,158),
Position=3DUDim2.fromOffset(0,40+ax.TextPadding),
Image=3D"rbxassetid://4155801252",
BackgroundColor3=3DColor3.fromHSV(aA,1,1),
BackgroundTransparency=3D0,
Parent=3Daz.UIElements.Main,
},{
ae("UICorner",{
CornerRadius=3DUDim.new(0,8),
}),
aa.NewRoundFrame(8,"SquircleOutline",{
ThemeTag=3D{
ImageColor3=3D"Outline",
},
Size=3DUDim2.new(1,0,1,0),
ImageTransparency=3D.85,
ZIndex=3D99999,
},{
ae("UIGradient",{
Rotation=3D45,
Color=3DColorSequence.new{
ColorSequenceKeypoint.new(0.0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1.0,Color3.fromRGB(255,255,255)),
},
Transparency=3DNumberSequence.new{
NumberSequenceKeypoint.new(0.0,0.1),
NumberSequenceKeypoint.new(0.5,1),
NumberSequenceKeypoint.new(1.0,0.1),
}
})
}),

d,
})

ax.UIElements.Inputs=3Dae("Frame",{
AutomaticSize=3D"XY",
Size=3DUDim2.new(0,0,0,0),
Position=3DUDim2.fromOffset(ax.Transparency and 240 or 210,40+ax.TextPaddin=
g),
BackgroundTransparency=3D1,
Parent=3Daz.UIElements.Main
},{
ae("UIListLayout",{
Padding=3DUDim.new(0,4),
FillDirection=3D"Vertical",
})
})





local f=3Dae("Frame",{
BackgroundColor3=3Dax.Default,
Size=3DUDim2.fromScale(1,1),
BackgroundTransparency=3Dax.Transparency,
},{
ae("UICorner",{
CornerRadius=3DUDim.new(0,8),
}),
})

ae("ImageLabel",{
Image=3D"http://www.roblox.com/asset/?id=3D14204231522",
ImageTransparency=3D0.45,
ScaleType=3DEnum.ScaleType.Tile,
TileSize=3DUDim2.fromOffset(40,40),
BackgroundTransparency=3D1,
Position=3DUDim2.fromOffset(85,208+ax.TextPadding),
Size=3DUDim2.fromOffset(75,24),
Parent=3Daz.UIElements.Main,
},{
ae("UICorner",{
CornerRadius=3DUDim.new(0,8),
}),
aa.NewRoundFrame(8,"SquircleOutline",{
ThemeTag=3D{
ImageColor3=3D"Outline",
},
Size=3DUDim2.new(1,0,1,0),
ImageTransparency=3D.85,
ZIndex=3D99999,
},{
ae("UIGradient",{
Rotation=3D60,
Color=3DColorSequence.new{
ColorSequenceKeypoint.new(0.0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1.0,Color3.fromRGB(255,255,255)),
},
Transparency=3DNumberSequence.new{
NumberSequenceKeypoint.new(0.0,0.1),
NumberSequenceKeypoint.new(0.5,1),
NumberSequenceKeypoint.new(1.0,0.1),
}
})
}),







f,
})

local g=3Dae("Frame",{
BackgroundColor3=3Dax.Default,
Size=3DUDim2.fromScale(1,1),
BackgroundTransparency=3D0,
ZIndex=3D9,
},{
ae("UICorner",{
CornerRadius=3DUDim.new(0,8),
}),
})

ae("ImageLabel",{
Image=3D"http://www.roblox.com/asset/?id=3D14204231522",
ImageTransparency=3D0.45,
ScaleType=3DEnum.ScaleType.Tile,
TileSize=3DUDim2.fromOffset(40,40),
BackgroundTransparency=3D1,
Position=3DUDim2.fromOffset(0,208+ax.TextPadding),
Size=3DUDim2.fromOffset(75,24),
Parent=3Daz.UIElements.Main,
},{
ae("UICorner",{
CornerRadius=3DUDim.new(0,8),
}),







aa.NewRoundFrame(8,"SquircleOutline",{
ThemeTag=3D{
ImageColor3=3D"Outline",
},
Size=3DUDim2.new(1,0,1,0),
ImageTransparency=3D.85,
ZIndex=3D99999,
},{
ae("UIGradient",{
Rotation=3D60,
Color=3DColorSequence.new{
ColorSequenceKeypoint.new(0.0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1.0,Color3.fromRGB(255,255,255)),
},
Transparency=3DNumberSequence.new{
NumberSequenceKeypoint.new(0.0,0.1),
NumberSequenceKeypoint.new(0.5,1),
NumberSequenceKeypoint.new(1.0,0.1),
}
})
}),
g,
})

local h=3D{}

for j=3D0,1,0.1 do
table.insert(h,ColorSequenceKeypoint.new(j,Color3.fromHSV(j,1,1)))
end

local j=3Dae("UIGradient",{
Color=3DColorSequence.new(h),
Rotation=3D90,
})

local l=3Dae("Frame",{
Size=3DUDim2.new(1,0,1,0),
Position=3DUDim2.new(0,0,0,0),
BackgroundTransparency=3D1,
})

local m=3Dae("Frame",{
Size=3DUDim2.new(0,14,0,14),
AnchorPoint=3DVector2.new(0.5,0.5),
Position=3DUDim2.new(0.5,0,0,0),
Parent=3Dl,


BackgroundColor3=3Dax.Default
},{
ae("UIStroke",{
Thickness=3D2,
Transparency=3D.1,
ThemeTag=3D{
Color=3D"Text",
},
}),
ae("UICorner",{
CornerRadius=3DUDim.new(1,0),
})
})

local p=3Dae("Frame",{
Size=3DUDim2.fromOffset(6,192),
Position=3DUDim2.fromOffset(180,40+ax.TextPadding),
Parent=3Daz.UIElements.Main,
},{
ae("UICorner",{
CornerRadius=3DUDim.new(1,0),
}),
j,
l,
})


function CreateNewInput(r,u)
local v=3Daq(r,nil,ax.UIElements.Inputs)

ae("TextLabel",{
BackgroundTransparency=3D1,
TextTransparency=3D.4,
TextSize=3D17,
FontFace=3DFont.new(aa.Font,Enum.FontWeight.Regular),
AutomaticSize=3D"XY",
ThemeTag=3D{
TextColor3=3D"Placeholder",
},
AnchorPoint=3DVector2.new(1,0.5),
Position=3DUDim2.new(1,-12,0.5,0),
Parent=3Dv.Frame,
Text=3Dr,
})

ae("UIScale",{
Parent=3Dv,
Scale=3D.85,
})

v.Frame.Frame.TextBox.Text=3Du
v.Size=3DUDim2.new(0,150,0,42)

return v
end

local function ToRGB(r)
return{
R=3Dmath.floor(r.R*255),
G=3Dmath.floor(r.G*255),
B=3Dmath.floor(r.B*255)
}
end

local r=3DCreateNewInput("Hex","#"..ax.Default:ToHex())

local u=3DCreateNewInput("Red",ToRGB(ax.Default).R)
local v=3DCreateNewInput("Green",ToRGB(ax.Default).G)
local x=3DCreateNewInput("Blue",ToRGB(ax.Default).B)
local z
if ax.Transparency then
z=3DCreateNewInput("Alpha",((1-ax.Transparency)*100).."%")
end

local A=3Dae("Frame",{
Size=3DUDim2.new(1,0,0,40),
AutomaticSize=3D"Y",
Position=3DUDim2.new(0,0,0,254+ax.TextPadding),
BackgroundTransparency=3D1,
Parent=3Daz.UIElements.Main,
LayoutOrder=3D4,
},{
ae("UIListLayout",{
Padding=3DUDim.new(0,6),
FillDirection=3D"Horizontal",
HorizontalAlignment=3D"Right",
}),






})

local B=3D{
{
Title=3D"Cancel",
Variant=3D"Secondary",
Callback=3Dfunction()end
},
{
Title=3D"Apply",
Icon=3D"chevron-right",
Variant=3D"Primary",
Callback=3Dfunction()aw(Color3.fromHSV(ax.Hue,ax.Sat,ax.Vib),ax.Transparenc=
y)end
}
}

for C,F in next,B do
local G=3Dap(F.Title,F.Icon,F.Callback,F.Variant,A,az,false)
G.Size=3DUDim2.new(0.5,-3,0,40)
G.AutomaticSize=3D"None"
end



local C,F,G
if ax.Transparency then
local H=3Dae("Frame",{
Size=3DUDim2.new(1,0,1,0),
Position=3DUDim2.fromOffset(0,0),
BackgroundTransparency=3D1,
})

F=3Dae("ImageLabel",{
Size=3DUDim2.new(0,14,0,14),
AnchorPoint=3DVector2.new(0.5,0.5),
Position=3DUDim2.new(0.5,0,0,0),
ThemeTag=3D{
BackgroundColor3=3D"Text",
},
Parent=3DH,

},{
ae("UIStroke",{
Thickness=3D2,
Transparency=3D.1,
ThemeTag=3D{
Color=3D"Text",
},
}),
ae("UICorner",{
CornerRadius=3DUDim.new(1,0),
})

})

G=3Dae("Frame",{
Size=3DUDim2.fromScale(1,1),
},{
ae("UIGradient",{
Transparency=3DNumberSequence.new{
NumberSequenceKeypoint.new(0,0),
NumberSequenceKeypoint.new(1,1),
},
Rotation=3D270,
}),
ae("UICorner",{
CornerRadius=3DUDim.new(0,6),
}),
})

C=3Dae("Frame",{
Size=3DUDim2.fromOffset(6,192),
Position=3DUDim2.fromOffset(210,40+ax.TextPadding),
Parent=3Daz.UIElements.Main,
BackgroundTransparency=3D1,
},{
ae("UICorner",{
CornerRadius=3DUDim.new(1,0),
}),
ae("ImageLabel",{
Image=3D"rbxassetid://14204231522",
ImageTransparency=3D0.45,
ScaleType=3DEnum.ScaleType.Tile,
TileSize=3DUDim2.fromOffset(40,40),
BackgroundTransparency=3D1,
Size=3DUDim2.fromScale(1,1),
},{
ae("UICorner",{
CornerRadius=3DUDim.new(1,0),
}),
}),
G,
H,
})
end

function ax.Round(H,J,L)
if L=3D=3D0 then
return math.floor(J)
end
J=3Dtostring(J)
return J:find"%."and tonumber(J:sub(1,J:find"%."+L))or J
end


function ax.Update(H,J,L)
if J then aA,aB,b=3DColor3.toHSV(J)else aA,aB,b=3Dax.Hue,ax.Sat,ax.Vib end

ax.UIElements.SatVibMap.BackgroundColor3=3DColor3.fromHSV(aA,1,1)
d.Position=3DUDim2.new(aB,0,1-b,0)
d.BackgroundColor3=3DColor3.fromHSV(aA,aB,b)
g.BackgroundColor3=3DColor3.fromHSV(aA,aB,b)
m.BackgroundColor3=3DColor3.fromHSV(aA,1,1)
m.Position=3DUDim2.new(0.5,0,aA,0)

r.Frame.Frame.TextBox.Text=3D"#"..Color3.fromHSV(aA,aB,b):ToHex()
u.Frame.Frame.TextBox.Text=3DToRGB(Color3.fromHSV(aA,aB,b)).R
v.Frame.Frame.TextBox.Text=3DToRGB(Color3.fromHSV(aA,aB,b)).G
x.Frame.Frame.TextBox.Text=3DToRGB(Color3.fromHSV(aA,aB,b)).B

if L or ax.Transparency then
g.BackgroundTransparency=3Dax.Transparency or L
G.BackgroundColor3=3DColor3.fromHSV(aA,aB,b)
F.BackgroundColor3=3DColor3.fromHSV(aA,aB,b)
F.BackgroundTransparency=3Dax.Transparency or L
F.Position=3DUDim2.new(0.5,0,1-ax.Transparency or L,0)
z.Frame.Frame.TextBox.Text=3Dax:Round((1-ax.Transparency or L)*100,0).."%"
end
end

ax:Update(ax.Default,ax.Transparency)




local function GetRGB()
local H=3DColor3.fromHSV(ax.Hue,ax.Sat,ax.Vib)
return{R=3Dmath.floor(H.r*255),G=3Dmath.floor(H.g*255),B=3Dmath.floor(H.b*2=
55)}
end



local function clamp(H,J,L)
return math.clamp(tonumber(H)or 0,J,L)
end

aa.AddSignal(r.Frame.Frame.TextBox.FocusLost,function(H)
if H then
local J=3Dr.Frame.Frame.TextBox.Text:gsub("#","")
local L,M=3Dpcall(Color3.fromHex,J)
if L and typeof(M)=3D=3D"Color3"then
ax.Hue,ax.Sat,ax.Vib=3DColor3.toHSV(M)
ax:Update()
ax.Default=3DM
end
end
end)

local function updateColorFromInput(H,J)
aa.AddSignal(H.Frame.Frame.TextBox.FocusLost,function(L)
if L then
local M=3DH.Frame.Frame.TextBox
local N=3DGetRGB()
local O=3Dclamp(M.Text,0,255)
M.Text=3Dtostring(O)

N[J]=3DO
local P=3DColor3.fromRGB(N.R,N.G,N.B)
ax.Hue,ax.Sat,ax.Vib=3DColor3.toHSV(P)
ax:Update()
end
end)
end

updateColorFromInput(u,"R")
updateColorFromInput(v,"G")
updateColorFromInput(x,"B")

if ax.Transparency then
aa.AddSignal(z.Frame.Frame.TextBox.FocusLost,function(H)
if H then
local J=3Dz.Frame.Frame.TextBox
local L=3Dclamp(J.Text,0,100)
J.Text=3Dtostring(L)

ax.Transparency=3D1-L*0.01
ax:Update(nil,ax.Transparency)
end
end)
end



local H=3Dax.UIElements.SatVibMap
aa.AddSignal(H.InputBegan,function(J)
if J.UserInputType=3D=3DEnum.UserInputType.MouseButton1 or J.UserInputType=
=3D=3DEnum.UserInputType.Touch then
while aj:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)do
local L=3DH.AbsolutePosition.X
local M=3DL+H.AbsoluteSize.X
local N=3Dmath.clamp(ao.X,L,M)

local O=3DH.AbsolutePosition.Y
local P=3DO+H.AbsoluteSize.Y
local Q=3Dmath.clamp(ao.Y,O,P)

ax.Sat=3D(N-L)/(M-L)
ax.Vib=3D1-((Q-O)/(P-O))
ax:Update()

am:Wait()
end
end
end)

aa.AddSignal(p.InputBegan,function(J)
if J.UserInputType=3D=3DEnum.UserInputType.MouseButton1 or J.UserInputType=
=3D=3DEnum.UserInputType.Touch then
while aj:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)do
local L=3Dp.AbsolutePosition.Y
local M=3DL+p.AbsoluteSize.Y
local N=3Dmath.clamp(ao.Y,L,M)

ax.Hue=3D((N-L)/(M-L))
ax:Update()

am:Wait()
end
end
end)

if ax.Transparency then
aa.AddSignal(C.InputBegan,function(J)
if J.UserInputType=3D=3DEnum.UserInputType.MouseButton1 or J.UserInputType=
=3D=3DEnum.UserInputType.Touch then
while aj:IsMouseButtonPressed(Enum.UserInputType.MouseButton1)do
local L=3DC.AbsolutePosition.Y
local M=3DL+C.AbsoluteSize.Y
local N=3Dmath.clamp(ao.Y,L,M)

ax.Transparency=3D1-((N-L)/(M-L))
ax:Update()

am:Wait()
end
end
end)
end

return ax
end

function ar.New(as,at)
local au=3D{
__type=3D"Colorpicker",
Title=3Dat.Title or"Colorpicker",
Desc=3Dat.Desc or nil,
Locked=3Dat.Locked or false,
LockedTitle=3Dat.LockedTitle,
Default=3Dat.Default or Color3.new(1,1,1),
Callback=3Dat.Callback or function()end,

UIScale=3Dat.UIScale,
Transparency=3Dat.Transparency,
UIElements=3D{}
}

local av=3Dtrue



au.ColorpickerFrame=3Da.load'B'{
Title=3Dau.Title,
Desc=3Dau.Desc,
Parent=3Dat.Parent,
TextOffset=3D40,
Hover=3Dfalse,
Tab=3Dat.Tab,
Index=3Dat.Index,
Window=3Dat.Window,
ElementTable=3Dau,
ParentConfig=3Dat,
}

au.UIElements.Colorpicker=3Daa.NewRoundFrame(ar.UICorner,"Squircle",{
ImageTransparency=3D0,
Active=3Dtrue,
ImageColor3=3Dau.Default,
Parent=3Dau.ColorpickerFrame.UIElements.Main,
Size=3DUDim2.new(0,26,0,26),
AnchorPoint=3DVector2.new(1,0),
Position=3DUDim2.new(1,0,0,0),
ZIndex=3D2
},nil,true)


function au.Lock(aw)
au.Locked=3Dtrue
av=3Dfalse
return au.ColorpickerFrame:Lock(au.LockedTitle)
end
function au.Unlock(aw)
au.Locked=3Dfalse
av=3Dtrue
return au.ColorpickerFrame:Unlock()
end

if au.Locked then
au:Lock()
end


function au.Update(aw,ax,ay)
au.UIElements.Colorpicker.ImageTransparency=3Day or 0
au.UIElements.Colorpicker.ImageColor3=3Dax
au.Default=3Dax
if ay then
au.Transparency=3Day
end
end

function au.Set(aw,ax,ay)
return au:Update(ax,ay)
end

aa.AddSignal(au.UIElements.Colorpicker.MouseButton1Click,function()
if av then
ar:Colorpicker(au,at.Window,at.WindUI,function(aw,ax)
au:Update(aw,ax)
au.Default=3Daw
au.Transparency=3Dax
aa.SafeCallback(au.Callback,aw,ax)
end).ColorpickerFrame:Open()
end
end)

return au.__type,au
end

return ar end function a.R()
local aa=3Da.load'c'
local ae=3Daa.New
local af=3Daa.Tween

local ah=3D{}

function ah.New(aj,ak)
local al=3D{
__type=3D"Section",
Title=3Dak.Title or"Section",
Desc=3Dak.Desc,
Icon=3Dak.Icon,
IconThemed=3Dak.IconThemed,
TextXAlignment=3Dak.TextXAlignment or"Left",
TextSize=3Dak.TextSize or 19,
DescTextSize=3Dak.DescTextSize or 16,
Box=3Dak.Box or false,
BoxBorder=3Dak.BoxBorder or false,
FontWeight=3Dak.FontWeight or Enum.FontWeight.SemiBold,
DescFontWeight=3Dak.DescFontWeight or Enum.FontWeight.Medium,
TextTransparency=3Dak.TextTransparency or 0.05,
DescTextTransparency=3Dak.DescTextTransparency or 0.4,
Opened=3Dak.Opened or false,
UIElements=3D{},

HeaderSize=3D42,
IconSize=3D20,
Padding=3D10,

Elements=3D{},

Expandable=3Dfalse,
}

local am


function al.SetIcon(an,ao)
al.Icon=3Dao or nil
if am then am:Destroy()end
if ao then
am=3Daa.Image(
ao,
ao..":"..al.Title,
0,
ak.Window.Folder,
al.__type,
true,
al.IconThemed,
"SectionIcon"
)
am.Size=3DUDim2.new(0,al.IconSize,0,al.IconSize)
end
end

local an=3Dae("Frame",{
Size=3DUDim2.new(0,al.IconSize,0,al.IconSize),
BackgroundTransparency=3D1,
Visible=3Dfalse
},{
ae("ImageLabel",{
Size=3DUDim2.new(1,0,1,0),
BackgroundTransparency=3D1,
Image=3Daa.Icon"chevron-down"[1],
ImageRectSize=3Daa.Icon"chevron-down"[2].ImageRectSize,
ImageRectOffset=3Daa.Icon"chevron-down"[2].ImageRectPosition,
ThemeTag=3D{
ImageTransparency=3D"SectionExpandIconTransparency",
ImageColor3=3D"SectionExpandIcon",
},
})
})


if al.Icon then
al:SetIcon(al.Icon)
end

local ao=3Dae("Frame",{
Size=3DUDim2.new(1,0,1,0),
BackgroundTransparency=3D1,
},{
ae("UIListLayout",{
FillDirection=3D"Vertical",
HorizontalAlignment=3Dal.TextXAlignment,
VerticalAlignment=3D"Center",
Padding=3DUDim.new(0,4)
})
})

local ap,aq

local function createTitle(ar,as)
return ae("TextLabel",{
BackgroundTransparency=3D1,
TextXAlignment=3Dal.TextXAlignment,
AutomaticSize=3D"Y",
TextSize=3Das=3D=3D"Title"and al.TextSize or al.DescTextSize,
TextTransparency=3Das=3D=3D"Title"and al.TextTransparency or al.DescTextTra=
nsparency,
ThemeTag=3D{
TextColor3=3D"Text",
},
FontFace=3DFont.new(aa.Font,as=3D=3D"Title"and al.FontWeight or al.DescFont=
Weight),


Text=3Dar,
Size=3DUDim2.new(
1,
0,
0,
0
),
TextWrapped=3Dtrue,
Parent=3Dao,
})
end

ap=3DcreateTitle(al.Title,"Title")
if al.Desc then
aq=3DcreateTitle(al.Desc,"Desc")
end

local function UpdateTitleSize()
local ar=3D0
if am then
ar=3Dar-(al.IconSize+8)
end
if an.Visible then
ar=3Dar-(al.IconSize+8)
end
ao.Size=3DUDim2.new(1,ar,0,0)
end


local ar=3Daa.NewRoundFrame(ak.Window.ElementConfig.UICorner,"Squircle",{
Size=3DUDim2.new(1,0,0,0),
BackgroundTransparency=3D1,
Parent=3Dak.Parent,
ClipsDescendants=3Dtrue,
AutomaticSize=3D"Y",
ThemeTag=3D{
ImageTransparency=3Dal.Box and"SectionBoxBackgroundTransparency"or nil,
ImageColor3=3D"SectionBoxBackground",
},
ImageTransparency=3Dnot al.Box and 1 or nil,
},{
aa.NewRoundFrame(ak.Window.ElementConfig.UICorner,ak.Window.NewElements and=
"Glass-1"or"SquircleOutline",{
Size=3DUDim2.new(1,0,1,0),

ThemeTag=3D{
ImageTransparency=3D"SectionBoxBorderTransparency",
ImageColor3=3D"SectionBoxBorder",
},
Visible=3Dal.Box and al.BoxBorder,
Name=3D"Outline",
}),
ae("TextButton",{
Size=3DUDim2.new(1,0,0,al.Expandable and 0 or(not aq and al.HeaderSize or 0=
)),
BackgroundTransparency=3D1,
AutomaticSize=3D(not al.Expandable or aq)and"Y"or nil,
Text=3D"",
Name=3D"Top",
},{
al.Box and ae("UIPadding",{
PaddingTop=3DUDim.new(0,ak.Window.ElementConfig.UIPadding+(ak.Window.NewEle=
ments and 4 or 0)),
PaddingLeft=3DUDim.new(0,ak.Window.ElementConfig.UIPadding+(ak.Window.NewEl=
ements and 4 or 0)),
PaddingRight=3DUDim.new(0,ak.Window.ElementConfig.UIPadding+(ak.Window.NewE=
lements and 4 or 0)),
PaddingBottom=3DUDim.new(0,ak.Window.ElementConfig.UIPadding+(ak.Window.New=
Elements and 4 or 0)),
})or nil,
am,
ao,
ae("UIListLayout",{
Padding=3DUDim.new(0,8),
FillDirection=3D"Horizontal",
VerticalAlignment=3D"Center",
HorizontalAlignment=3D"Left",
}),
an,
}),
ae("Frame",{
BackgroundTransparency=3D1,
Size=3DUDim2.new(1,0,0,0),
AutomaticSize=3D"Y",
Name=3D"Content",
Visible=3Dfalse,
Position=3DUDim2.new(0,0,0,al.HeaderSize)
},{
al.Box and ae("UIPadding",{
PaddingLeft=3DUDim.new(0,ak.Window.ElementConfig.UIPadding),
PaddingRight=3DUDim.new(0,ak.Window.ElementConfig.UIPadding),
PaddingBottom=3DUDim.new(0,ak.Window.ElementConfig.UIPadding),
})or nil,
ae("UIListLayout",{
FillDirection=3D"Vertical",
Padding=3DUDim.new(0,ak.Tab.Gap),
VerticalAlignment=3D"Top",
}),
})
})





al.ElementFrame=3Dar

if aq then
ar.Top:GetPropertyChangedSignal"AbsoluteSize":Connect(function()
ar.Content.Position=3DUDim2.new(0,0,0,ar.Top.AbsoluteSize.Y/ak.UIScale)

if al.Opened then al:Open(true)else al.Close(true)end
end)
end


local as=3Dak.ElementsModule

as.Load(al,ar.Content,as.Elements,ak.Window,ak.WindUI,function()
if not al.Expandable then
al.Expandable=3Dtrue
an.Visible=3Dtrue
UpdateTitleSize()
end
end,as,ak.UIScale,ak.Tab)


UpdateTitleSize()

function al.SetTitle(at,au)
al.Title=3Dau
ap.Text=3Dau
end

function al.SetDesc(at,au)
al.Desc=3Dau
if not aq then
aq=3DcreateTitle(au,"Desc")
end
aq.Text=3Dau
end

function al.Destroy(at)
for au,av in next,al.Elements do
av:Destroy()
end








ar:Destroy()
end

function al.Open(at,au)
if al.Expandable then
al.Opened=3Dtrue
if au then
ar.Size=3DUDim2.new(ar.Size.X.Scale,ar.Size.X.Offset,0,(ar.Top.AbsoluteSize=
.Y)/ak.UIScale+(ar.Content.AbsoluteSize.Y/ak.UIScale))
an.ImageLabel.Rotation=3D180
else
af(ar,0.33,{
Size=3DUDim2.new(ar.Size.X.Scale,ar.Size.X.Offset,0,(ar.Top.AbsoluteSize.Y)=
/ak.UIScale+(ar.Content.AbsoluteSize.Y/ak.UIScale))
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

af(an.ImageLabel,0.2,{Rotation=3D180},Enum.EasingStyle.Quint,Enum.EasingDir=
ection.Out):Play()
end
end
end
function al.Close(at,au)
if al.Expandable then
al.Opened=3Dfalse
if au then
ar.Size=3DUDim2.new(ar.Size.X.Scale,ar.Size.X.Offset,0,(ar.Top.AbsoluteSize=
.Y/ak.UIScale))
an.ImageLabel.Rotation=3D0
else
af(ar,0.26,{
Size=3DUDim2.new(ar.Size.X.Scale,ar.Size.X.Offset,0,(ar.Top.AbsoluteSize.Y/=
ak.UIScale))
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
af(an.ImageLabel,0.2,{Rotation=3D0},Enum.EasingStyle.Quint,Enum.EasingDirec=
tion.Out):Play()
end
end
end

aa.AddSignal(ar.Top.MouseButton1Click,function()
if al.Expandable then
if al.Opened then
al:Close()
else
al:Open()
end
end
end)

aa.AddSignal(ar.Content.UIListLayout:GetPropertyChangedSignal"AbsoluteConte=
ntSize",function()
if al.Opened then
al:Open(true)
end
end)

task.spawn(function()
task.wait(0.02)
if al.Expandable then








ar.Size=3DUDim2.new(ar.Size.X.Scale,ar.Size.X.Offset,0,ar.Top.AbsoluteSize.=
Y/ak.UIScale)
ar.AutomaticSize=3D"None"
ar.Top.Size=3DUDim2.new(1,0,0,(not aq and al.HeaderSize or 0))
ar.Top.AutomaticSize=3D(not al.Expandable or aq)and"Y"or"None"
ar.Content.Visible=3Dtrue
end
if al.Opened then
al:Open()
end

end)

return al.__type,al
end

return ah end function a.S()

local aa=3Da.load'c'
local ae=3Daa.New

local af=3D{}

function af.New(ah,aj)
local ak=3Dae("Frame",{
Parent=3Daj.Parent,
Size=3Dnot table.find({"Group","HStack"},aj.ParentType)and UDim2.new(1,-7,0=
,7*(aj.Columns or 1))or UDim2.new(0,7*(aj.Columns or 1),0,0),
BackgroundTransparency=3D1,
})

return"Space",{__type=3D"Space",ElementFrame=3Dak}
end

return af end function a.T()
local aa=3Da.load'c'
local ae=3Daa.New

local af=3D{}

local function ParseAspectRatio(ah)
if type(ah)=3D=3D"string"then
local aj,ak=3Dah:match"(%d+):(%d+)"
if aj and ak then
return tonumber(aj)/tonumber(ak)
end
elseif type(ah)=3D=3D"number"then
return ah
end
return nil
end

function af.New(ah,aj)
local ak=3D{
__type=3D"Image",
Image=3Daj.Image or"",
AspectRatio=3Daj.AspectRatio or"16:9",
Radius=3Daj.Radius or aj.Window.ElementConfig.UICorner,
}
local al=3Daa.Image(
ak.Image,
ak.Image,
ak.Radius,
aj.Window.Folder,
"Image",
false
)
if al and al.Parent then
al.Parent=3Daj.Parent
al.Size=3DUDim2.new(1,0,0,0)
al.BackgroundTransparency=3D1












local am=3DParseAspectRatio(ak.AspectRatio)
local an

if am then
an=3Dae("UIAspectRatioConstraint",{
Parent=3Dal,
AspectRatio=3Dam,
AspectType=3D"ScaleWithParentSize",
DominantAxis=3D"Width"
})
end

function ak.Destroy(ao)
al:Destroy()
end
end

return ak.__type,ak
end

return af end function a.U()
local aa=3Da.load'c'
local ae=3Daa.New

local af=3D{}

function af.New(ah,aj)
local ak=3D{
__type=3D"Group",
Elements=3D{},
ElementFrame=3Dnil,
}

local al=3Dae("Frame",{
Size=3DUDim2.new(1,0,0,0),
BackgroundTransparency=3D1,
AutomaticSize=3D"Y",
Parent=3Daj.Parent,
},{
ae("UIListLayout",{
FillDirection=3D"Horizontal",
HorizontalAlignment=3D"Center",

Padding=3DUDim.new(0,aj.Tab and aj.Tab.Gap or(aj.Window.NewElements and 1 o=
r 6))
}),
})

ak.ElementFrame=3Dal

local am=3Daj.ElementsModule
am.Load(
ak,
al,
am.Elements,
aj.Window,
aj.WindUI,
function(an,ao)
local ap=3Daj.Tab and aj.Tab.Gap or(aj.Window.NewElements and 1 or 6)

local aq=3D{}
local ar=3D0

for as,at in next,ao do
if at.__type=3D=3D"Space"then
ar=3Dar+(at.ElementFrame.Size.X.Offset or 6)
elseif at.__type=3D=3D"Divider"then
ar=3Dar+(at.ElementFrame.Size.X.Offset or 1)
else
table.insert(aq,at)
end
end

local as=3D#aq
if as=3D=3D0 then return end

local at=3D1/as

local au=3Dap*(as-1)

local av=3D-(au+ar)

local aw=3Dmath.floor(av/as)
local ax=3Dav-(aw*as)

for ay,az in next,aq do
local aA=3Daw
if ay&lt;=3Dmath.abs(ax)then
aA=3DaA-1
end

if az.ElementFrame then
az.ElementFrame.Size=3DUDim2.new(at,aA,1,0)
end
end
end,
am,
aj.UIScale,
aj.Tab
)



return ak.__type,ak
end

return af end function a.V()
local aa=3Da.load'c'
local ae=3Daa.New

local af=3D{}

function af.New(ah,aj)
local ak=3D{
__type=3D"HStack",
AutoSpace=3Daj.AutoSpace or false,
Elements=3D{},
ElementFrame=3Dnil,
}

local al=3Dae("Frame",{
Size=3DUDim2.new(1,0,0,0),
BackgroundTransparency=3D1,
AutomaticSize=3D"Y",
Parent=3Daj.Parent,
},{
ae("UIListLayout",{
FillDirection=3D"Horizontal",
HorizontalAlignment=3D"Center",

Padding=3DUDim.new(0,aj.Tab and aj.Tab.Gap or(aj.Window.NewElements and 1 o=
r 6))
}),
})

ak.ElementFrame=3Dal

local am=3Daj.ElementsModule
am.Load(
ak,
al,
am.Elements,
aj.Window,
aj.WindUI,
function(an,ao)
local ap=3Daj.Tab and aj.Tab.Gap or(aj.Window.NewElements and 1 or 6)

local aq=3D{}
local ar=3D0

for as,at in next,ao do
if at.__type=3D=3D"Space"then
ar=3Dar+(at.ElementFrame.Size.X.Offset or 6)
elseif at.__type=3D=3D"Divider"then
ar=3Dar+(at.ElementFrame.Size.X.Offset or 1)
else
table.insert(aq,at)
end
end

local as=3D#aq
if as=3D=3D0 then return end

local at=3D1/as

local au=3Dap*(as-1)

local av=3D-(au+ar)

local aw=3Dmath.floor(av/as)
local ax=3Dav-(aw*as)

for ay,az in next,aq do
local aA=3Daw
if ay&lt;=3Dmath.abs(ax)then
aA=3DaA-1
end

if az.ElementFrame then
az.ElementFrame.Size=3DUDim2.new(at,aA,1,0)
end
end
end,
am,
aj.UIScale,
aj.Tab
)

if ak.AutoSpace then
for an in next,am.Elements do
if an~=3D"Space"and an~=3D"Divider"then
local ao=3Dak[an]
ak[an]=3Dfunction(ap,aq)
if#ak.Elements&gt;0 then
ak:Space()
end
return ao(ap,aq)
end
end
end
end


return ak.__type,ak
end

return af end function a.W()
local aa=3Da.load'c'
local ae=3Daa.New

local af=3D{}

function af.New(ah,aj)
local ak=3D{
__type=3D"VStack",
Elements=3D{},
ElementFrame=3Dnil,
}

local al=3Dae("Frame",{
Size=3DUDim2.new(1,0,0,0),
BackgroundTransparency=3D1,
AutomaticSize=3D"Y",
Parent=3Daj.Parent,
},{
ae("UIListLayout",{
FillDirection=3D"Vertical",
HorizontalAlignment=3D"Center",

Padding=3DUDim.new(0,aj.Tab and aj.Tab.Gap or(aj.Window.NewElements and 1 o=
r 6))
}),
})

ak.ElementFrame=3Dal

local am=3Daj.ElementsModule
am.Load(
ak,
al,
am.Elements,
aj.Window,
aj.WindUI,







































nil,
am,
aj.UIScale,
aj.Tab
)



return ak.__type,ak
end

return af end function a.X()
local aa=3D(cloneref or clonereference or function(aa)
return aa
end)

local ae=3Daa(game:GetService"UserInputService")

local af=3Da.load'c'
local ah=3Daf.New

local aj=3D{}













function aj.New(ak,al:ConfigType__DARKLUA_TYPE_a)
local am=3D{
__type=3D"Viewport",
Object=3Dal.Object,
Camera=3Dal.Camera or Instance.new"Camera",
Interactive=3Dal.Interactive or false,
Height=3Dal.Height or 200,
Focused=3Dal.Focused~=3Dfalse,
}

local an=3Dfalse
local ao=3Dfalse
local ap,aq=3D0

local ar=3Daf.NewRoundFrame(al.Window.ElementConfig.UICorner,"Squircle",{
Size=3DUDim2.new(1,0,0,am.Height),
Parent=3Dal.Parent,
ThemeTag=3D{
ImageColor3=3D"ViewportBackground",
ImageTransparency=3D"ViewportBackgroundTransparency",
},
},{
ah("CanvasGroup",{
Size=3DUDim2.new(1,0,1,0),
BackgroundTransparency=3D1,
},{
ah("UICorner",{
CornerRadius=3DUDim.new(0,al.Window.ElementConfig.UICorner),
}),
ah("ViewportFrame",{
Name=3D"Viewport",
Size=3DUDim2.new(1,0,1,0),
BackgroundTransparency=3D1,
CurrentCamera=3Dam.Camera,
Active=3Dam.Interactive,
},{
am.Object,
}),
}),
})

af.AddSignal(ar.CanvasGroup.Viewport.MouseEnter,function()
if am.Interactive then
al.Tab.UIElements.ContainerFrame.ScrollingEnabled=3Dfalse
end
end)

af.AddSignal(ar.CanvasGroup.Viewport.InputEnded,function(as)
if
as.UserInputType=3D=3DEnum.UserInputType.MouseMovement
or as.UserInputType=3D=3DEnum.UserInputType.Touch
then
al.Tab.UIElements.ContainerFrame.ScrollingEnabled=3Dtrue
end
end)

af.AddSignal(ar.CanvasGroup.Viewport.InputBegan,function(as)
if am.Interactive then
if
(as.UserInputType=3D=3DEnum.UserInputType.MouseButton1)
or(as.UserInputType=3D=3DEnum.UserInputType.Touch and not ao)
then
an=3Dtrue
aq=3Das.Position
end
end
end)

af.AddSignal(ae.InputEnded,function(as)
if am.Interactive then
if
as.UserInputType=3D=3DEnum.UserInputType.MouseButton1
or as.UserInputType=3D=3DEnum.UserInputType.Touch
then
an=3Dfalse
end
end
end)

af.AddSignal(ae.InputChanged,function(as)
if am.Interactive and an and not ao then
if
as.UserInputType=3D=3DEnum.UserInputType.MouseMovement
or as.UserInputType=3D=3DEnum.UserInputType.Touch
then
local at=3Das.Position-aq
aq=3Das.Position

local au=3Dam.Object:GetPivot().Position
local av=3Dam.Camera

local aw=3DCFrame.fromAxisAngle(Vector3.new(0,1,0),-at.X*0.02)
av.CFrame=3DCFrame.new(au)*aw*CFrame.new(-au)*av.CFrame

local ax=3DCFrame.fromAxisAngle(av.CFrame.RightVector,-at.Y*0.02)
local ay=3DCFrame.new(au)*ax*CFrame.new(-au)*av.CFrame

if ay.UpVector.Y&gt;0.1 then
av.CFrame=3Day
end
end
end
end)

af.AddSignal(ar.CanvasGroup.Viewport.InputChanged,function(as)
if am.Interactive then
if as.UserInputType=3D=3DEnum.UserInputType.MouseWheel then
local at=3Das.Position.Z*2
am.Camera.CFrame+=3Dam.Camera.CFrame.LookVector*at
end
end
end)

af.AddSignal(ae.TouchPinch,function(as,at,au,av)
if am.Interactive then
if av=3D=3DEnum.UserInputState.Begin then
ao=3Dtrue
an=3Dfalse
ap=3D(as[1]-as[2]).Magnitude
elseif av=3D=3DEnum.UserInputState.Change then
local aw=3D(as[1]-as[2]).Magnitude
local ax=3D(aw-ap)*0.03
ap=3Daw
am.Camera.CFrame+=3Dam.Camera.CFrame.LookVector*ax
elseif av=3D=3DEnum.UserInputState.End or av=3D=3DEnum.UserInputState.Cance=
l then
ao=3Dfalse
end
end
end)

local function FocusCamera()
local as=3Dam.Object:IsA"BasePart"and am.Object.Size
or select(2,am.Object:GetBoundingBox(0))
local at=3Dmath.max(as.X,as.Y,as.Z)
local au=3Dat*2
local av=3Dam.Object:GetPivot().Position

am.Camera.CFrame=3D
CFrame.new(av+Vector3.new(0,at/2,au),av)
end

if am.Focused then
FocusCamera()
end

function am.SetObject(as,at,au)
if au then
at=3Dat:Clone()
end
if am.Object then
am.Object:Destroy()
end

am.Object=3Dat
am.Object.Parent=3Dar.CanvasGroup.Viewport
end

function am.SetHeight(as,at)
ar.Size=3DUDim2.new(1,0,0,at)
end

function am.Focus(as)
if am.Object then
FocusCamera()
end
end

function am.SetCamera(as,at)
am.Camera=3Dat
ar.CanvasGroup.Viewport.CurrentCamera=3Dat
end

function am.SetInteractive(as,at)
am.Interactive=3Dat
ar.CanvasGroup.Viewport.Active=3Dat
end

am.Main=3Dar

return am.__type,am
end

return aj end function a.Y()

return{
Elements=3D{
Paragraph=3Da.load'C',
Button=3Da.load'D',
Toggle=3Da.load'G',
Slider=3Da.load'H',
Keybind=3Da.load'I',
Input=3Da.load'J',
Dropdown=3Da.load'M',
Code=3Da.load'P',
Colorpicker=3Da.load'Q',
Section=3Da.load'R',
Divider=3Da.load'K',
Space=3Da.load'S',
Image=3Da.load'T',
Group=3Da.load'U',
HStack=3Da.load'V',
VStack=3Da.load'W',
Viewport=3Da.load'X',

},
Load=3Dfunction(aa,ae,af,ah,aj,ak,al,am,an)
for ao,ap in next,af do
aa[ao]=3Dfunction(aq,ar)
ar=3Dar or{}
ar.Tab=3Dan or aa
ar.ParentType=3Daa.__type
ar.ParentTable=3Daa
ar.Index=3D#aa.Elements+1
ar.GlobalIndex=3D#ah.AllElements+1
ar.Parent=3Dae
ar.Window=3Dah
ar.WindUI=3Daj
ar.UIScale=3Dam
ar.ElementsModule=3Dal local

as, at=3Dap:New(ar)

if ar.Flag and typeof(ar.Flag)=3D=3D"string"then
if ah.CurrentConfig then
ah.CurrentConfig:Register(ar.Flag,at)

if ah.PendingConfigData and ah.PendingConfigData[ar.Flag]then
local au=3Dah.PendingConfigData[ar.Flag]

local av=3Dah.ConfigManager
if av.Parser[au.__type]then
task.defer(function()
local aw,ax=3Dpcall(function()
av.Parser[au.__type].Load(at,au)
end)

if aw then
ah.PendingConfigData[ar.Flag]=3Dnil
else
warn(
"[ WindUI ] Failed to apply pending config for '"
..ar.Flag
.."': "
..tostring(ax)
)
end
end)
end
end
else
ah.PendingFlags=3Dah.PendingFlags or{}
ah.PendingFlags[ar.Flag]=3Dat
end
end

local au
for av,aw in next,at do
if typeof(aw)=3D=3D"table"and av~=3D"ElementFrame"and av:match"Frame$"then
au=3Daw
break
end
end

if au then
at.ElementFrame=3Dau.UIElements.Main
function at.SetTitle(av,aw)
return au.SetTitle and au:SetTitle(aw)
end
function at.SetDesc(av,aw)
return au.SetDesc and au:SetDesc(aw)
end
function at.SetImage(av,aw,ax)
return au.SetImage and au:SetImage(aw,ax)
end
function at.SetThumbnail(av,aw,ax)
return au.SetThumbnail and au:SetThumbnail(aw,ax)
end
function at.Highlight(av)
au:Highlight()
end
function at.Destroy(av)
au:Destroy()

table.remove(ah.AllElements,ar.GlobalIndex)
table.remove(aa.Elements,ar.Index)
table.remove(an.Elements,ar.Index)
aa:UpdateAllElementShapes(aa)
end
end

ah.AllElements[ar.Index]=3Dat
aa.Elements[ar.Index]=3Dat
if an then
an.Elements[ar.Index]=3Dat
end

if ah.NewElements then
aa:UpdateAllElementShapes(aa)
end

if ak then
ak(at,aa.Elements)
end
return at
end
end
function aa.UpdateAllElementShapes(ao,ap)
for aq,ar in next,ap.Elements do
local as
for at,au in pairs(ar)do
if typeof(au)=3D=3D"table"and at:match"Frame$"then
as=3Dau
break
end
end

if as then

as.Index=3Daq
if as.UpdateShape then

as.UpdateShape(ap)
end
end
end
end
end,
}end function a.Z()

local aa=3D(cloneref or clonereference or function(aa)
return aa
end)

local ae=3Dgame:GetService"Players"

aa(game:GetService"UserInputService")
local af=3Dae.LocalPlayer:GetMouse()

local ah=3Da.load'c'
local aj=3Dah.New

local ak=3Da.load'A'.New
local al=3Da.load'w'.New



local am=3D{


Tabs=3D{},
Containers=3D{},
SelectedTab=3Dnil,
TabCount=3D0,
ToolTipParent=3Dnil,
TabHighlight=3Dnil,

OnChangeFunc=3Dfunction(am)end,
}

function am.Init(an,ao,ap,aq)
Window=3Dan
WindUI=3Dao
am.ToolTipParent=3Dap
am.TabHighlight=3Daq
return am
end

function am.New(an,ao)
local ap=3D{
__type=3D"Tab",
Title=3Dan.Title or"Tab",
Desc=3Dan.Desc,
Icon=3Dan.Icon,
IconColor=3Dan.IconColor,
IconShape=3Dan.IconShape,
IconThemed=3Dan.IconThemed,
Locked=3Dan.Locked,
ShowTabTitle=3Dan.ShowTabTitle,
TabTitleAlign=3Dan.TabTitleAlign or"Left",
CustomEmptyPage=3D(an.CustomEmptyPage and next(an.CustomEmptyPage)~=3Dnil)a=
nd an.CustomEmptyPage
or{Icon=3D"lucide:frown",IconSize=3D48,Title=3D"This tab is Empty",Desc=3Dn=
il},
Border=3Dan.Border,
Selected=3Dfalse,
Index=3Dnil,
Parent=3Dan.Parent,
UIElements=3D{},
Elements=3D{},
ContainerFrame=3Dnil,
UICorner=3DWindow.UICorner-(Window.UIPadding/2),

Gap=3DWindow.NewElements and 1 or 6,

TabPaddingX=3D4+(Window.UIPadding/2),
TabPaddingY=3D3+(Window.UIPadding/2),
TitlePaddingY=3D0,
}









if ap.IconShape then
ap.TabPaddingX=3D2+(Window.UIPadding/4)
ap.TabPaddingY=3D2+(Window.UIPadding/4)
ap.TitlePaddingY=3D2+(Window.UIPadding/4)
end

am.TabCount=3Dam.TabCount+1

local aq=3Dam.TabCount
ap.Index=3Daq

ap.UIElements.Main=3Dah.NewRoundFrame(ap.UICorner,"Squircle",{
BackgroundTransparency=3D1,
Size=3DUDim2.new(1,-7,0,0),
AutomaticSize=3D"Y",
Parent=3Dan.Parent,
ThemeTag=3D{
ImageColor3=3D"TabBackground",
},
ImageTransparency=3D1,
},{
ah.NewRoundFrame(ap.UICorner,"Glass-1.4",{
Size=3DUDim2.new(1,0,1,0),
ThemeTag=3D{
ImageColor3=3D"TabBorder",
},
ImageTransparency=3D1,
Name=3D"Outline",
},{













}),
ah.NewRoundFrame(ap.UICorner,"Squircle",{
Size=3DUDim2.new(1,0,0,0),
AutomaticSize=3D"Y",
ThemeTag=3D{
ImageColor3=3D"Text",
},
ImageTransparency=3D1,
Name=3D"Frame",
},{
aj("UIListLayout",{
SortOrder=3D"LayoutOrder",
Padding=3DUDim.new(0,2+(Window.UIPadding/2)),
FillDirection=3D"Horizontal",
VerticalAlignment=3D"Center",
}),
aj("TextLabel",{
Text=3Dap.Title,
ThemeTag=3D{
TextColor3=3D"TabTitle",
},
TextTransparency=3Dnot ap.Locked and 0.4 or 0.7,
TextSize=3D15,
Size=3DUDim2.new(1,0,0,0),
FontFace=3DFont.new(ah.Font,Enum.FontWeight.Medium),
TextWrapped=3Dtrue,
RichText=3Dtrue,
AutomaticSize=3D"Y",
LayoutOrder=3D2,
TextXAlignment=3D"Left",
BackgroundTransparency=3D1,
},{
aj("UIPadding",{
PaddingTop=3DUDim.new(0,ap.TitlePaddingY),


PaddingBottom=3DUDim.new(0,ap.TitlePaddingY),
}),
}),
aj("UIPadding",{
PaddingTop=3DUDim.new(0,ap.TabPaddingY),
PaddingLeft=3DUDim.new(0,ap.TabPaddingX),
PaddingRight=3DUDim.new(0,ap.TabPaddingX),
PaddingBottom=3DUDim.new(0,ap.TabPaddingY),
}),
}),
},true)

local ar=3D0
local as
local at

if ap.Icon then
as=3Dah.Image(
ap.Icon,
ap.Icon..":"..ap.Title,
0,
Window.Folder,
ap.__type,
ap.IconColor and false or true,
ap.IconThemed,
"TabIcon"
)
as.Size=3DUDim2.new(0,16,0,16)
if ap.IconColor then
as.ImageLabel.ImageColor3=3Dap.IconColor
end
if not ap.IconShape then
as.Parent=3Dap.UIElements.Main.Frame
ap.UIElements.Icon=3Das
as.ImageLabel.ImageTransparency=3Dnot ap.Locked and 0 or 0.7
ar=3D-18-(Window.UIPadding/2)
ap.UIElements.Main.Frame.TextLabel.Size=3DUDim2.new(1,ar,0,0)
elseif ap.IconColor then
ah.NewRoundFrame(
ap.IconShape~=3D"Circle"and(ap.UICorner+5-(2+(Window.UIPadding/4)))or 9999,
"Squircle",
{
Size=3DUDim2.new(0,26,0,26),
ImageColor3=3Dap.IconColor,
Parent=3Dap.UIElements.Main.Frame,
},
{
as,
ah.NewRoundFrame(
ap.IconShape~=3D"Circle"and(ap.UICorner+5-(2+(Window.UIPadding/4)))or 9999,
"Glass-1.4",
{
Size=3DUDim2.new(1,0,1,0),
ThemeTag=3D{
ImageColor3=3D"White",
},
ImageTransparency=3D0,
Name=3D"Outline",
},
{













}
),
}
)
as.AnchorPoint=3DVector2.new(0.5,0.5)
as.Position=3DUDim2.new(0.5,0,0.5,0)
as.ImageLabel.ImageTransparency=3D0
as.ImageLabel.ImageColor3=3Dah.GetTextColorForHSB(ap.IconColor,0.68)
ar=3D-28-(Window.UIPadding/2)
ap.UIElements.Main.Frame.TextLabel.Size=3DUDim2.new(1,ar,0,0)
end

at=3D
ah.Image(ap.Icon,ap.Icon..":"..ap.Title,0,Window.Folder,ap.__type,true,ap.I=
conThemed)
at.Size=3DUDim2.new(0,16,0,16)
at.ImageLabel.ImageTransparency=3Dnot ap.Locked and 0 or 0.7
ar=3D-30




end

ap.UIElements.ContainerFrame=3Daj("ScrollingFrame",{
Size=3DUDim2.new(1,0,1,ap.ShowTabTitle and-((Window.UIPadding*2.4)+12)or 0)=
,
BackgroundTransparency=3D1,
ScrollBarThickness=3D0,
ElasticBehavior=3D"Never",
CanvasSize=3DUDim2.new(0,0,0,0),
AnchorPoint=3DVector2.new(0,1),
Position=3DUDim2.new(0,0,1,0),
AutomaticCanvasSize=3D"Y",

ScrollingDirection=3D"Y",
},{
aj("UIPadding",{
PaddingTop=3DUDim.new(0,not Window.HidePanelBackground and 20 or 10),
PaddingLeft=3DUDim.new(0,not Window.HidePanelBackground and 20 or 10),
PaddingRight=3DUDim.new(0,not Window.HidePanelBackground and 20 or 10),
PaddingBottom=3DUDim.new(0,not Window.HidePanelBackground and 20 or 10),
}),
aj("UIListLayout",{
SortOrder=3D"LayoutOrder",
Padding=3DUDim.new(0,ap.Gap),
HorizontalAlignment=3D"Center",
}),
})





ap.UIElements.ContainerFrameCanvas=3Daj("Frame",{
Size=3DUDim2.new(1,0,1,0),
BackgroundTransparency=3D1,
Visible=3Dfalse,
Parent=3DWindow.UIElements.MainBar,
ZIndex=3D5,
},{
ap.UIElements.ContainerFrame,
aj("Frame",{
Size=3DUDim2.new(1,0,0,((Window.UIPadding*2.4)+12)),
BackgroundTransparency=3D1,
Visible=3Dap.ShowTabTitle or false,
Name=3D"TabTitle",
},{
at,
aj("TextLabel",{
Text=3Dap.Title,
ThemeTag=3D{
TextColor3=3D"Text",
},
TextSize=3D20,
TextTransparency=3D0.1,
Size=3DUDim2.new(0,0,1,0),
FontFace=3DFont.new(ah.Font,Enum.FontWeight.SemiBold),

RichText=3Dtrue,
LayoutOrder=3D2,
TextXAlignment=3D"Left",
BackgroundTransparency=3D1,
AutomaticSize=3D"X",
}),
aj("UIPadding",{
PaddingTop=3DUDim.new(0,20),
PaddingLeft=3DUDim.new(0,20),
PaddingRight=3DUDim.new(0,20),
PaddingBottom=3DUDim.new(0,20),
}),
aj("UIListLayout",{
SortOrder=3D"LayoutOrder",
Padding=3DUDim.new(0,10),
FillDirection=3D"Horizontal",
VerticalAlignment=3D"Center",
HorizontalAlignment=3Dap.TabTitleAlign,
}),
}),
aj("Frame",{
Size=3DUDim2.new(1,0,0,1),
BackgroundTransparency=3D0.9,
ThemeTag=3D{
BackgroundColor3=3D"Text",
},
Position=3DUDim2.new(0,0,0,((Window.UIPadding*2.4)+12)),
Visible=3Dap.ShowTabTitle or false,
}),
})

am.Containers[aq]=3Dap.UIElements.ContainerFrameCanvas
am.Tabs[aq]=3Dap

ap.ContainerFrame=3Dap.UIElements.ContainerFrameCanvas

ah.AddSignal(ap.UIElements.Main.MouseButton1Click,function()
if not ap.Locked then
am:SelectTab(aq)
end
end)

if Window.ScrollBarEnabled then
al(ap.UIElements.ContainerFrame,ap.UIElements.ContainerFrameCanvas,Window,3=
)
end

local au
local av
local aw
local ax=3Dfalse


if ap.Desc then
ah.AddSignal(ap.UIElements.Main.InputBegan,function()
ax=3Dtrue
av=3Dtask.spawn(function()
task.wait(0.35)
if ax and not au then
au=3Dak(ap.Desc,am.ToolTipParent,true)
au.Container.AnchorPoint=3DVector2.new(0.5,0.5)

local function updatePosition()
if au then
au.Container.Position=3DUDim2.new(0,af.X,0,af.Y-4)
end
end

updatePosition()
aw=3Daf.Move:Connect(updatePosition)
au:Open()
end
end)
end)
end

ah.AddSignal(ap.UIElements.Main.MouseEnter,function()
if not ap.Locked then
ah.SetThemeTag(ap.UIElements.Main.Frame,{
ImageTransparency=3D"TabBackgroundHoverTransparency",
ImageColor3=3D"TabBackgroundHover",
},0.1)
end
end)
ah.AddSignal(ap.UIElements.Main.InputEnded,function()
if ap.Desc then
ax=3Dfalse
if av then
task.cancel(av)
av=3Dnil
end
if aw then
aw:Disconnect()
aw=3Dnil
end
if au then
au:Close()
au=3Dnil
end
end

if not ap.Locked then
ah.SetThemeTag(ap.UIElements.Main.Frame,{
ImageTransparency=3D"TabBorderTransparency",
},0.1)
end
end)

function ap.ScrollToTheElement(ay,az)
ap.UIElements.ContainerFrame.ScrollingEnabled=3Dfalse

ah.Tween(ap.UIElements.ContainerFrame,0.45,{
CanvasPosition=3DVector2.new(
0,
ap.Elements[az].ElementFrame.AbsolutePosition.Y
-ap.UIElements.ContainerFrame.AbsolutePosition.Y
-ap.UIElements.ContainerFrame.UIPadding.PaddingTop.Offset
),
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

task.spawn(function()
task.wait(0.48)

if ap.Elements[az].Highlight then
ap.Elements[az]:Highlight()
end
ap.UIElements.ContainerFrame.ScrollingEnabled=3Dtrue
end)

return ap
end



local ay=3Da.load'Y'

ay.Load(
ap,
ap.UIElements.ContainerFrame,
ay.Elements,
Window,
WindUI,
nil,
ay,
ao,
ap
)

function ap.LockAll(az)

for aA,aB in next,Window.AllElements do
if aB.Tab and aB.Tab.Index and aB.Tab.Index=3D=3Dap.Index and aB.Lock then
aB:Lock()
end
end
end
function ap.UnlockAll(az)
for aA,aB in next,Window.AllElements do
if aB.Tab and aB.Tab.Index and aB.Tab.Index=3D=3Dap.Index and aB.Unlock the=
n
aB:Unlock()
end
end
end
function ap.GetLocked(az)
local aA=3D{}

for aB,b in next,Window.AllElements do
if b.Tab and b.Tab.Index and b.Tab.Index=3D=3Dap.Index and b.Locked=3D=3Dtr=
ue then
table.insert(aA,b)
end
end

return aA
end
function ap.GetUnlocked(az)
local aA=3D{}

for aB,b in next,Window.AllElements do
if b.Tab and b.Tab.Index and b.Tab.Index=3D=3Dap.Index and b.Locked=3D=3Dfa=
lse then
table.insert(aA,b)
end
end

return aA
end

function ap.Select(az)
return am:SelectTab(ap.Index)
end

task.spawn(function()
local az
if ap.CustomEmptyPage.Icon then
az=3D
ah.Image(ap.CustomEmptyPage.Icon,ap.CustomEmptyPage.Icon,0,"Temp","EmptyPag=
e",true)
az.Size=3D
UDim2.fromOffset(ap.CustomEmptyPage.IconSize or 48,ap.CustomEmptyPage.IconS=
ize or 48)
end

local aA=3Daj("Frame",{
BackgroundTransparency=3D1,
Size=3DUDim2.new(1,0,1,-Window.UIElements.Main.Main.Topbar.AbsoluteSize.Y),
Parent=3Dap.UIElements.ContainerFrame,
},{
aj("UIListLayout",{
Padding=3DUDim.new(0,8),
SortOrder=3D"LayoutOrder",
VerticalAlignment=3D"Center",
HorizontalAlignment=3D"Center",
FillDirection=3D"Vertical",
}),











az,
ap.CustomEmptyPage.Title
and aj("TextLabel",{
AutomaticSize=3D"XY",
Text=3Dap.CustomEmptyPage.Title,
ThemeTag=3D{
TextColor3=3D"Text",
},
TextSize=3D18,
TextTransparency=3D0.5,
BackgroundTransparency=3D1,
FontFace=3DFont.new(ah.Font,Enum.FontWeight.Medium),
})
or nil,
ap.CustomEmptyPage.Desc
and aj("TextLabel",{
AutomaticSize=3D"XY",
Text=3Dap.CustomEmptyPage.Desc,
ThemeTag=3D{
TextColor3=3D"Text",
},
TextSize=3D15,
TextTransparency=3D0.65,
BackgroundTransparency=3D1,
FontFace=3DFont.new(ah.Font,Enum.FontWeight.Regular),
})
or nil,
})





local aB
aB=3Dah.AddSignal(ap.UIElements.ContainerFrame.ChildAdded,function()
aA.Visible=3Dfalse
aB:Disconnect()
end)
end)

return ap
end

function am.OnChange(an,ao)
am.OnChangeFunc=3Dao
end

function am.SelectTab(an,ao)
if not am.Tabs[ao].Locked then
am.SelectedTab=3Dao

for ap,aq in next,am.Tabs do
if not aq.Locked then
ah.SetThemeTag(aq.UIElements.Main,{
ImageTransparency=3D"TabBorderTransparency",
},0.15)
if aq.Border then
ah.SetThemeTag(aq.UIElements.Main.Outline,{
ImageTransparency=3D"TabBorderTransparency",
},0.15)
end
ah.SetThemeTag(aq.UIElements.Main.Frame.TextLabel,{
TextTransparency=3D"TabTextTransparency",
},0.15)
if aq.UIElements.Icon and not aq.IconColor then
ah.SetThemeTag(aq.UIElements.Icon.ImageLabel,{
ImageTransparency=3D"TabIconTransparency",
},0.15)
end
aq.Selected=3Dfalse
end
end
ah.SetThemeTag(am.Tabs[ao].UIElements.Main,{
ImageTransparency=3D"TabBackgroundActiveTransparency",
},0.15)
if am.Tabs[ao].Border then
ah.SetThemeTag(am.Tabs[ao].UIElements.Main.Outline,{
ImageTransparency=3D"TabBorderTransparencyActive",
},0.15)
end
ah.SetThemeTag(am.Tabs[ao].UIElements.Main.Frame.TextLabel,{
TextTransparency=3D"TabTextTransparencyActive",
},0.15)
if am.Tabs[ao].UIElements.Icon and not am.Tabs[ao].IconColor then
ah.SetThemeTag(am.Tabs[ao].UIElements.Icon.ImageLabel,{
ImageTransparency=3D"TabIconTransparencyActive",
},0.15)
end
am.Tabs[ao].Selected=3Dtrue

task.spawn(function()
for ap,aq in next,am.Containers do
aq.AnchorPoint=3DVector2.new(0,0.05)
aq.Visible=3Dfalse
end
am.Containers[ao].Visible=3Dtrue
local ap=3Dgame:GetService"TweenService"

local aq=3DTweenInfo.new(0.15,Enum.EasingStyle.Quart,Enum.EasingDirection.O=
ut)
local ar=3Dap:Create(am.Containers[ao],aq,{
AnchorPoint=3DVector2.new(0,0),
})
ar:Play()
end)

am.OnChangeFunc(ao)
end
end

return am end function a._()

local aa=3D{}


local ae=3Da.load'c'
local af=3Dae.New
local ah=3Dae.Tween

local aj=3Da.load'Z'

function aa.New(ak,al,am,an,ao)
local ap=3D{
Title=3Dak.Title or"Section",
Icon=3Dak.Icon,
IconThemed=3Dak.IconThemed,
Opened=3Dak.Opened or false,

HeaderSize=3D42,
IconSize=3D18,

Expandable=3Dfalse,
}

local aq
if ap.Icon then
aq=3Dae.Image(
ap.Icon,
ap.Icon,
0,
am,
"Section",
true,
ap.IconThemed,
"TabSectionIcon"
)

aq.Size=3DUDim2.new(0,ap.IconSize,0,ap.IconSize)
aq.ImageLabel.ImageTransparency=3D.25
end

local ar=3Daf("Frame",{
Size=3DUDim2.new(0,ap.IconSize,0,ap.IconSize),
BackgroundTransparency=3D1,
Visible=3Dfalse
},{
af("ImageLabel",{
Size=3DUDim2.new(1,0,1,0),
BackgroundTransparency=3D1,
Image=3Dae.Icon"chevron-down"[1],
ImageRectSize=3Dae.Icon"chevron-down"[2].ImageRectSize,
ImageRectOffset=3Dae.Icon"chevron-down"[2].ImageRectPosition,
ThemeTag=3D{
ImageColor3=3D"Icon",
},
ImageTransparency=3D.7,
})
})

local as=3Daf("Frame",{
Size=3DUDim2.new(1,0,0,ap.HeaderSize),
BackgroundTransparency=3D1,
Parent=3Dal,
ClipsDescendants=3Dtrue,
},{
af("TextButton",{
Size=3DUDim2.new(1,0,0,ap.HeaderSize),
BackgroundTransparency=3D1,
Text=3D"",
},{
aq,
af("TextLabel",{
Text=3Dap.Title,
TextXAlignment=3D"Left",
Size=3DUDim2.new(
1,
aq and(-ap.IconSize-10)*2
or(-ap.IconSize-10),

1,
0
),
ThemeTag=3D{
TextColor3=3D"Text",
},
FontFace=3DFont.new(ae.Font,Enum.FontWeight.SemiBold),
TextSize=3D14,
BackgroundTransparency=3D1,
TextTransparency=3D.7,

TextWrapped=3Dtrue
}),
af("UIListLayout",{
FillDirection=3D"Horizontal",
VerticalAlignment=3D"Center",
Padding=3DUDim.new(0,10)
}),
ar,
af("UIPadding",{
PaddingLeft=3DUDim.new(0,11),
PaddingRight=3DUDim.new(0,11),
})
}),
af("Frame",{
BackgroundTransparency=3D1,
Size=3DUDim2.new(1,0,0,0),
AutomaticSize=3D"Y",
Name=3D"Content",
Visible=3Dtrue,
Position=3DUDim2.new(0,0,0,ap.HeaderSize)
},{
af("UIListLayout",{
FillDirection=3D"Vertical",
Padding=3DUDim.new(0,ao.Gap),
VerticalAlignment=3D"Bottom",
}),
})
})


function ap.Tab(at,au)
if not ap.Expandable then
ap.Expandable=3Dtrue
ar.Visible=3Dtrue
end
au.Parent=3Das.Content
return aj.New(au,an)
end

function ap.Open(at)
if ap.Expandable then
ap.Opened=3Dtrue
ah(as,0.33,{
Size=3DUDim2.new(1,0,0,ap.HeaderSize+(as.Content.AbsoluteSize.Y/an))
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

ah(ar.ImageLabel,0.1,{Rotation=3D180},Enum.EasingStyle.Quint,Enum.EasingDir=
ection.Out):Play()
end
end
function ap.Close(at)
if ap.Expandable then
ap.Opened=3Dfalse
ah(as,0.26,{
Size=3DUDim2.new(1,0,0,ap.HeaderSize)
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
ah(ar.ImageLabel,0.1,{Rotation=3D0},Enum.EasingStyle.Quint,Enum.EasingDirec=
tion.Out):Play()
end
end

ae.AddSignal(as.TextButton.MouseButton1Click,function()
if ap.Expandable then
if ap.Opened then
ap:Close()
else
ap:Open()
end
end
end)

ae.AddSignal(as.Content.UIListLayout:GetPropertyChangedSignal"AbsoluteConte=
ntSize",function()
if ap.Opened then
ap:Open()
end
end)

if ap.Opened then
task.spawn(function()
task.wait()
ap:Open()
end)
end



return ap
end


return aa end function a.aa()
return{
Tab=3D"table-of-contents",
Paragraph=3D"type",
Button=3D"square-mouse-pointer",
Toggle=3D"toggle-right",
Slider=3D"sliders-horizontal",
Keybind=3D"command",
Input=3D"text-cursor-input",
Dropdown=3D"chevrons-up-down",
Code=3D"terminal",
Colorpicker=3D"palette",
}end function a.ab()
local aa=3D(cloneref or clonereference or function(aa)
return aa
end)

aa(game:GetService"UserInputService")

local ae=3D{
Margin=3D8,
Padding=3D9,
}

local af=3Da.load'c'
local ah=3Daf.New
local aj=3Daf.Tween

function ae.new(ak,al,am)
local an=3D{
IconSize=3D18,
Padding=3D14,
Radius=3D22,
Width=3D400,
MaxHeight=3D380,

Icons=3Da.load'aa',
}

local ao=3Dah("TextBox",{
Text=3D"",
PlaceholderText=3D"Search...",
ThemeTag=3D{
PlaceholderColor3=3D"Placeholder",
TextColor3=3D"Text",
},
Size=3DUDim2.new(1,-((an.IconSize*2)+(an.Padding*2)),0,0),
AutomaticSize=3D"Y",
ClipsDescendants=3Dtrue,
ClearTextOnFocus=3Dfalse,
BackgroundTransparency=3D1,
TextXAlignment=3D"Left",
FontFace=3DFont.new(af.Font,Enum.FontWeight.Regular),
TextSize=3D18,
})

local ap=3Dah("ImageLabel",{
Image=3Daf.Icon"x"[1],
ImageRectSize=3Daf.Icon"x"[2].ImageRectSize,
ImageRectOffset=3Daf.Icon"x"[2].ImageRectPosition,
BackgroundTransparency=3D1,
ThemeTag=3D{
ImageColor3=3D"Icon",
},
ImageTransparency=3D0.1,
Size=3DUDim2.new(0,an.IconSize,0,an.IconSize),
},{
ah("TextButton",{
Size=3DUDim2.new(1,8,1,8),
BackgroundTransparency=3D1,
Active=3Dtrue,
ZIndex=3D999999999,
AnchorPoint=3DVector2.new(0.5,0.5),
Position=3DUDim2.new(0.5,0,0.5,0),
Text=3D"",
}),
})

local aq=3Dah("ScrollingFrame",{
Size=3DUDim2.new(1,0,0,0),
AutomaticCanvasSize=3D"Y",
ScrollingDirection=3D"Y",
ElasticBehavior=3D"Never",
ScrollBarThickness=3D0,
CanvasSize=3DUDim2.new(0,0,0,0),
BackgroundTransparency=3D1,
Visible=3Dfalse,
},{
ah("UIListLayout",{
Padding=3DUDim.new(0,0),
FillDirection=3D"Vertical",
}),
ah("UIPadding",{
PaddingTop=3DUDim.new(0,an.Padding),
PaddingLeft=3DUDim.new(0,an.Padding),
PaddingRight=3DUDim.new(0,an.Padding),
PaddingBottom=3DUDim.new(0,an.Padding),
}),
})

local ar=3Daf.NewRoundFrame(an.Radius,"Squircle",{
Size=3DUDim2.new(1,0,1,0),
ThemeTag=3D{
ImageColor3=3D"WindowSearchBarBackground",
},
ImageTransparency=3D0,
},{
af.NewRoundFrame(an.Radius,"Squircle",{
Size=3DUDim2.new(1,0,1,0),
BackgroundTransparency=3D1,

Visible=3Dfalse,
ThemeTag=3D{
ImageColor3=3D"White",
},
ImageTransparency=3D1,
Name=3D"Frame",
},{
ah("Frame",{
Size=3DUDim2.new(1,0,0,46),
BackgroundTransparency=3D1,
},{








ah("Frame",{
Size=3DUDim2.new(1,0,1,0),
BackgroundTransparency=3D1,
},{
ah("ImageLabel",{
Image=3Daf.Icon"search"[1],
ImageRectSize=3Daf.Icon"search"[2].ImageRectSize,
ImageRectOffset=3Daf.Icon"search"[2].ImageRectPosition,
BackgroundTransparency=3D1,
ThemeTag=3D{
ImageColor3=3D"Icon",
},
ImageTransparency=3D0.1,
Size=3DUDim2.new(0,an.IconSize,0,an.IconSize),
}),
ao,
ap,
ah("UIListLayout",{
Padding=3DUDim.new(0,an.Padding),
FillDirection=3D"Horizontal",
VerticalAlignment=3D"Center",
}),
ah("UIPadding",{
PaddingLeft=3DUDim.new(0,an.Padding),
PaddingRight=3DUDim.new(0,an.Padding),
}),
}),
}),
ah("Frame",{
BackgroundTransparency=3D1,
AutomaticSize=3D"Y",
Size=3DUDim2.new(1,0,0,0),
Name=3D"Results",
},{
ah("Frame",{
Size=3DUDim2.new(1,0,0,1),
ThemeTag=3D{
BackgroundColor3=3D"Outline",
},
BackgroundTransparency=3D0.9,
Visible=3Dfalse,
}),
aq,
ah("UISizeConstraint",{
MaxSize=3DVector2.new(an.Width,an.MaxHeight),
}),
}),
ah("UIListLayout",{
Padding=3DUDim.new(0,0),
FillDirection=3D"Vertical",
}),
}),
})

local as=3Dah("Frame",{
Size=3DUDim2.new(0,an.Width,0,0),
AutomaticSize=3D"Y",
Parent=3Dal,
BackgroundTransparency=3D1,
Position=3DUDim2.new(0.5,0,0.5,0),
AnchorPoint=3DVector2.new(0.5,0.5),
Visible=3Dfalse,

ZIndex=3D99999999,
},{
ah("UIScale",{
Scale=3D0.9,
}),
ar,
af.NewRoundFrame(an.Radius,"Glass-0.7",{
Size=3DUDim2.new(1,0,1,0),
BackgroundTransparency=3D1,


ThemeTag=3D{
ImageColor3=3D"SearchBarBorder",
ImageTransparency=3D"SearchBarBorderTransparency",
},
Name=3D"Outline",
}),
})

local function CreateSearchTab(at,au,av,aw,ax,ay)
local az=3Dah("TextButton",{
Size=3DUDim2.new(1,0,0,0),
AutomaticSize=3D"Y",
BackgroundTransparency=3D1,
Parent=3Daw or nil,
},{
af.NewRoundFrame(an.Radius-11,"Squircle",{
Size=3DUDim2.new(1,0,0,0),
Position=3DUDim2.new(0.5,0,0.5,0),
AnchorPoint=3DVector2.new(0.5,0.5),

ThemeTag=3D{
ImageColor3=3D"Text",
},
ImageTransparency=3D1,
Name=3D"Main",
},{
af.NewRoundFrame(an.Radius-11,"Glass-1",{
Size=3DUDim2.new(1,0,1,0),
Position=3DUDim2.new(0.5,0,0.5,0),
AnchorPoint=3DVector2.new(0.5,0.5),
ThemeTag=3D{
ImageColor3=3D"White",
},
ImageTransparency=3D1,
Name=3D"Outline",
},{








ah("UIPadding",{
PaddingTop=3DUDim.new(0,an.Padding-2),
PaddingLeft=3DUDim.new(0,an.Padding),
PaddingRight=3DUDim.new(0,an.Padding),
PaddingBottom=3DUDim.new(0,an.Padding-2),
}),
ah("ImageLabel",{
Image=3Daf.Icon(av)[1],
ImageRectSize=3Daf.Icon(av)[2].ImageRectSize,
ImageRectOffset=3Daf.Icon(av)[2].ImageRectPosition,
BackgroundTransparency=3D1,
ThemeTag=3D{
ImageColor3=3D"Icon",
},
ImageTransparency=3D0.1,
Size=3DUDim2.new(0,an.IconSize,0,an.IconSize),
}),
ah("Frame",{
Size=3DUDim2.new(1,-an.IconSize-an.Padding,0,0),
BackgroundTransparency=3D1,
},{
ah("TextLabel",{
Text=3Dat,
ThemeTag=3D{
TextColor3=3D"Text",
},
TextSize=3D17,
BackgroundTransparency=3D1,
TextXAlignment=3D"Left",
FontFace=3DFont.new(af.Font,Enum.FontWeight.Medium),
Size=3DUDim2.new(1,0,0,0),
TextTruncate=3D"AtEnd",
AutomaticSize=3D"Y",
Name=3D"Title",
}),
ah("TextLabel",{
Text=3Dau or"",
Visible=3Dau and true or false,
ThemeTag=3D{
TextColor3=3D"Text",
},
TextSize=3D15,
TextTransparency=3D0.3,
BackgroundTransparency=3D1,
TextXAlignment=3D"Left",
FontFace=3DFont.new(af.Font,Enum.FontWeight.Medium),
Size=3DUDim2.new(1,0,0,0),
TextTruncate=3D"AtEnd",
AutomaticSize=3D"Y",
Name=3D"Desc",
})or nil,
ah("UIListLayout",{
Padding=3DUDim.new(0,6),
FillDirection=3D"Vertical",
}),
}),
ah("UIListLayout",{
Padding=3DUDim.new(0,an.Padding),
FillDirection=3D"Horizontal",
}),
}),
},true),
ah("Frame",{
Name=3D"ParentContainer",
Size=3DUDim2.new(1,-an.Padding,0,0),
AutomaticSize=3D"Y",
BackgroundTransparency=3D1,
Visible=3Dax,

},{
af.NewRoundFrame(99,"Squircle",{
Size=3DUDim2.new(0,2,1,0),
BackgroundTransparency=3D1,
ThemeTag=3D{
ImageColor3=3D"Text",
},
ImageTransparency=3D0.9,
}),
ah("Frame",{
Size=3DUDim2.new(1,-an.Padding-2,0,0),
Position=3DUDim2.new(0,an.Padding+2,0,0),
BackgroundTransparency=3D1,
},{
ah("UIListLayout",{
Padding=3DUDim.new(0,0),
FillDirection=3D"Vertical",
}),
}),
}),
ah("UIListLayout",{
Padding=3DUDim.new(0,0),
FillDirection=3D"Vertical",
HorizontalAlignment=3D"Right",
}),
})



az.Main.Size=3DUDim2.new(
1,
0,
0,
az.Main.Outline.Frame.Desc.Visible
and(((an.Padding-2)*2)+az.Main.Outline.Frame.Title.TextBounds.Y+6+az.Main.O=
utline.Frame.Desc.TextBounds.Y)
or(((an.Padding-2)*2)+az.Main.Outline.Frame.Title.TextBounds.Y)
)

af.AddSignal(az.Main.MouseEnter,function()
aj(az.Main,0.04,{ImageTransparency=3D0.95}):Play()
aj(az.Main.Outline,0.04,{ImageTransparency=3D0.75}):Play()
end)
af.AddSignal(az.Main.InputEnded,function()
aj(az.Main,0.08,{ImageTransparency=3D1}):Play()
aj(az.Main.Outline,0.08,{ImageTransparency=3D1}):Play()
end)
af.AddSignal(az.Main.MouseButton1Click,function()
if ay then
ay()
end
end)

return az
end

local function ContainsText(at,au)
if not au or au=3D=3D""then
return false
end

if not at or at=3D=3D""then
return false
end

local av=3Dstring.lower(at)
local aw=3Dstring.lower(au)

return string.find(av,aw,1,true)~=3Dnil
end

local function Search(at)
if not at or at=3D=3D""then
return{}
end

local au=3D{}
for av,aw in next,ak.Tabs do
local ax=3DContainsText(aw.Title or"",at)
local ay=3D{}

for az,aA in next,aw.Elements do
if aA.__type~=3D"Section"then
local aB=3DContainsText(aA.Title or"",at)
local b=3DContainsText(aA.Desc or"",at)

if aB or b then
ay[az]=3D{
Title=3DaA.Title,
Desc=3DaA.Desc,
Original=3DaA,
__type=3DaA.__type,
Index=3Daz,
}
end
end
end

if ax or next(ay)~=3Dnil then
au[av]=3D{
Tab=3Daw,
Title=3Daw.Title,
Icon=3Daw.Icon,
Elements=3Day,
}
end
end
return au
end

af.AddSignal(aq.UIListLayout:GetPropertyChangedSignal"AbsoluteContentSize",=
function()

aj(aq,0.06,{
Size=3DUDim2.new(
1,
0,
0,
math.clamp(
aq.UIListLayout.AbsoluteContentSize.Y+(an.Padding*2),
0,
an.MaxHeight
)
),
},Enum.EasingStyle.Quint,Enum.EasingDirection.InOut):Play()






end)

function an.Open(at)
task.spawn(function()
ar.Frame.Visible=3Dtrue
as.Visible=3Dtrue
aj(as.UIScale,0.12,{Scale=3D1},Enum.EasingStyle.Quint,Enum.EasingDirection.=
Out):Play()
end)
end

function an.Close(at,au)
task.spawn(function()
am()
ar.Frame.Visible=3Dfalse
aj(as.UIScale,0.12,{Scale=3D1},Enum.EasingStyle.Quint,Enum.EasingDirection.=
Out):Play()

task.wait(0.12)
as.Visible=3Dfalse
if au then
as:Destroy()
end
end)
end

af.AddSignal(ap.TextButton.MouseButton1Click,function()
an:Close(true)
end)

an:Open()

function an.Search(at,au)
au=3Dau or""

local av=3DSearch(au)

aq.Visible=3Dtrue
ar.Frame.Results.Frame.Visible=3Dtrue
for aw,ax in next,aq:GetChildren()do
if ax.ClassName~=3D"UIListLayout"and ax.ClassName~=3D"UIPadding"then
ax:Destroy()
end
end

if av and next(av)~=3Dnil then
for aw,ax in next,av do
local ay=3Dan.Icons.Tab
local az=3DCreateSearchTab(ax.Title,nil,ay,aq,true,function()
an:Close()
ak:SelectTab(aw)
end)
if ax.Elements and next(ax.Elements)~=3Dnil then
for aA,aB in next,ax.Elements do
local b=3Dan.Icons[aB.__type]
CreateSearchTab(
aB.Title,
aB.Desc,
b,
az:FindFirstChild"ParentContainer"and az.ParentContainer.Frame
or nil,
false,
function()
an:Close()
ak:SelectTab(aw)
if ax.Tab.ScrollToTheElement then

ax.Tab:ScrollToTheElement(aB.Index)
end

end
)

end
end
end
elseif au~=3D""then
ah("TextLabel",{
Size=3DUDim2.new(1,0,0,70),
Text=3D"No results found",
TextSize=3D16,
ThemeTag=3D{
TextColor3=3D"Text",
},
TextTransparency=3D0.2,
BackgroundTransparency=3D1,
FontFace=3DFont.new(af.Font,Enum.FontWeight.Medium),
Parent=3Daq,
Name=3D"NotFound",
})
else
aq.Visible=3Dfalse
ar.Frame.Results.Frame.Visible=3Dfalse
end
end

af.AddSignal(ao:GetPropertyChangedSignal"Text",function()
an:Search(ao.Text)
end)

return an
end

return ae end function a.ac()



local aa=3D(cloneref or clonereference or function(aa)
return aa
end)

local ae=3Daa(game:GetService"UserInputService")
local af=3Daa(game:GetService"RunService")
local ah=3Daa(game:GetService"Players")

local aj=3Dworkspace.CurrentCamera

local ak=3Da.load's'

local al=3Da.load'c'
local am=3Dal.New
local an=3Dal.Tween


local ao=3Da.load'v'.New
local ap=3Da.load'l'.New
local aq=3Da.load'w'.New
local ar=3Da.load'x'

local as=3Da.load'y'



return function(at)
local au=3D{
Title=3Dat.Title or"UI Library",
Author=3Dat.Author,
Icon=3Dat.Icon,
IconSize=3Dat.IconSize or 22,
IconThemed=3Dat.IconThemed,
IconRadius=3Dat.IconRadius or 0,
Folder=3Dat.Folder,
Resizable=3Dat.Resizable~=3Dfalse,
Background=3Dat.Background,
BackgroundImageTransparency=3Dat.BackgroundImageTransparency or 0,
ShadowTransparency=3Dat.ShadowTransparency or 0.6,
User=3Dat.User or{},
Footer=3Dat.Footer or{},
Topbar=3Dat.Topbar or{Height=3D52,ButtonsType=3D"Default"},

Size=3Dat.Size,

MinSize=3Dat.MinSize or Vector2.new(560,350),
MaxSize=3Dat.MaxSize or Vector2.new(850,560),

TopBarButtonIconSize=3Dat.TopBarButtonIconSize,

ToggleKey=3Dat.ToggleKey,
ElementsRadius=3Dat.ElementsRadius,
Radius=3Dat.Radius or 16,
Transparent=3Dat.Transparent or false,
HideSearchBar=3Dat.HideSearchBar~=3Dfalse,
ScrollBarEnabled=3Dat.ScrollBarEnabled or false,
SideBarWidth=3Dat.SideBarWidth or 200,
Acrylic=3Dat.Acrylic or false,
NewElements=3Dat.NewElements or false,
IgnoreAlerts=3Dat.IgnoreAlerts or false,
HidePanelBackground=3Dat.HidePanelBackground or false,
AutoScale=3Dat.AutoScale~=3Dfalse,
OpenButton=3Dat.OpenButton,
DragFrameSize=3D160,

Position=3DUDim2.new(0.5,0,0.5,0),
UICorner=3D16,
UIPadding=3D14,
UIElements=3D{},
CanDropdown=3Dtrue,
Closed=3Dfalse,
Parent=3Dat.Parent,
Destroyed=3Dfalse,
IsFullscreen=3Dfalse,
CanResize=3Dat.Resizable~=3Dfalse,
IsOpenButtonEnabled=3Dtrue,

CurrentConfig=3Dnil,
ConfigManager=3Dnil,
AcrylicPaint=3Dnil,
CurrentTab=3Dnil,
TabModule=3Dnil,

OnOpenCallback=3Dnil,
OnCloseCallback=3Dnil,
OnDestroyCallback=3Dnil,

IsPC=3Dfalse,

Gap=3D5,

TopBarButtons=3D{},
AllElements=3D{},

ElementConfig=3D{},

PendingFlags=3D{},

IsToggleDragging=3Dfalse,
}

au.UICorner=3Dau.Radius

au.TopBarButtonIconSize=3Dau.TopBarButtonIconSize or(au.Topbar.ButtonsType=
=3D=3D"Mac"and 11 or 16)

au.ElementConfig=3D{
UIPadding=3D(au.NewElements and 10 or 13),
UICorner=3Dau.ElementsRadius or(au.NewElements and 23 or 16),
}

local av=3Dau.Size or UDim2.new(0,580,0,460)
au.Size=3DUDim2.new(
av.X.Scale,
math.clamp(av.X.Offset,au.MinSize.X,au.MaxSize.X),
av.Y.Scale,
math.clamp(av.Y.Offset,au.MinSize.Y,au.MaxSize.Y)
)

if au.Topbar=3D=3D{}then
au.Topbar=3D{Height=3D52,ButtonsType=3D"Default"}
end

if not af:IsStudio()and au.Folder and writefile then
if not isfolder("WindUI/"..au.Folder)then
makefolder("WindUI/"..au.Folder)
end
if not isfolder("WindUI/"..au.Folder.."/assets")then
makefolder("WindUI/"..au.Folder.."/assets")
end
if not isfolder(au.Folder)then
makefolder(au.Folder)
end
if not isfolder(au.Folder.."/assets")then
makefolder(au.Folder.."/assets")
end
end

local aw=3Dam("UICorner",{
CornerRadius=3DUDim.new(0,au.UICorner),
})

if au.Folder then
au.ConfigManager=3Das:Init(au)
end

if au.Acrylic then local
ax=3Dak.AcrylicPaint{UseAcrylic=3Dau.Acrylic}

au.AcrylicPaint=3Dax
end

local ax=3Dam("Frame",{
Size=3DUDim2.new(0,32,0,32),
Position=3DUDim2.new(1,0,1,0),
AnchorPoint=3DVector2.new(0.5,0.5),
BackgroundTransparency=3D1,
ZIndex=3D99,
Active=3Dtrue,
},{
am("ImageLabel",{
Size=3DUDim2.new(0,96,0,96),
BackgroundTransparency=3D1,
Image=3D"rbxassetid://120997033468887",
Position=3DUDim2.new(0.5,-16,0.5,-16),
AnchorPoint=3DVector2.new(0.5,0.5),
ImageTransparency=3D1,
}),
})
local ay=3Dal.NewRoundFrame(au.UICorner,"Squircle",{
Size=3DUDim2.new(1,0,1,0),
ImageTransparency=3D1,
ImageColor3=3DColor3.new(0,0,0),
ZIndex=3D98,
Active=3Dfalse,
},{
am("ImageLabel",{
Size=3DUDim2.new(0,70,0,70),
Image=3Dal.Icon"expand"[1],
ImageRectOffset=3Dal.Icon"expand"[2].ImageRectPosition,
ImageRectSize=3Dal.Icon"expand"[2].ImageRectSize,
BackgroundTransparency=3D1,
Position=3DUDim2.new(0.5,0,0.5,0),
AnchorPoint=3DVector2.new(0.5,0.5),
ImageTransparency=3D1,
}),
})

local az=3Dal.NewRoundFrame(au.UICorner,"Squircle",{
Size=3DUDim2.new(1,0,1,0),
ImageTransparency=3D1,
ImageColor3=3DColor3.new(0,0,0),
ZIndex=3D999,
Active=3Dfalse,
})









au.UIElements.SideBar=3Dam("ScrollingFrame",{
Size=3DUDim2.new(
1,
au.ScrollBarEnabled and-3-(au.UIPadding/2)or 0,
1,
not au.HideSearchBar and-45 or 0
),
Position=3DUDim2.new(0,0,1,0),
AnchorPoint=3DVector2.new(0,1),
BackgroundTransparency=3D1,
ScrollBarThickness=3D0,
ElasticBehavior=3D"Never",
CanvasSize=3DUDim2.new(0,0,0,0),
AutomaticCanvasSize=3D"Y",
ScrollingDirection=3D"Y",
ClipsDescendants=3Dtrue,
VerticalScrollBarPosition=3D"Left",
},{
am("Frame",{
BackgroundTransparency=3D1,
AutomaticSize=3D"Y",
Size=3DUDim2.new(1,0,0,0),
Name=3D"Frame",
},{
am("UIPadding",{



PaddingBottom=3DUDim.new(0,au.UIPadding/2),
}),
am("UIListLayout",{
SortOrder=3D"LayoutOrder",
Padding=3DUDim.new(0,au.Gap),
}),
}),
am("UIPadding",{

PaddingLeft=3DUDim.new(0,au.UIPadding/2),
PaddingRight=3DUDim.new(0,au.UIPadding/2),

}),

})

au.UIElements.SideBarContainer=3Dam("Frame",{
Size=3DUDim2.new(
0,
au.SideBarWidth,
1,
au.User.Enabled and-au.Topbar.Height-42-(au.UIPadding*2)or-au.Topbar.Height
),
Position=3DUDim2.new(0,0,0,au.Topbar.Height),
BackgroundTransparency=3D1,
Visible=3Dtrue,
},{
am("Frame",{
Name=3D"Content",
BackgroundTransparency=3D1,
Size=3DUDim2.new(1,0,1,not au.HideSearchBar and-45-au.UIPadding/2 or 0),
Position=3DUDim2.new(0,0,1,0),
AnchorPoint=3DVector2.new(0,1),
}),
au.UIElements.SideBar,
})

if au.ScrollBarEnabled then
aq(au.UIElements.SideBar,au.UIElements.SideBarContainer.Content,au,3)
end

au.UIElements.MainBar=3Dam("Frame",{
Size=3DUDim2.new(1,-au.UIElements.SideBarContainer.AbsoluteSize.X,1,-au.Top=
bar.Height),
Position=3DUDim2.new(1,0,1,0),
AnchorPoint=3DVector2.new(1,1),
BackgroundTransparency=3D1,
},{
al.NewRoundFrame(au.UICorner-(au.UIPadding/2),"Squircle",{
Size=3DUDim2.new(1,0,1,0),
ThemeTag=3D{
ImageColor3=3D"PanelBackground",
ImageTransparency=3D"PanelBackgroundTransparency",
},


ZIndex=3D3,
Name=3D"Background",
Visible=3Dnot au.HidePanelBackground,
}),
am("UIPadding",{

PaddingLeft=3DUDim.new(0,au.UIPadding/2),
PaddingRight=3DUDim.new(0,au.UIPadding/2),
PaddingBottom=3DUDim.new(0,au.UIPadding/2),
}),
})

local aA=3Dam("ImageLabel",{
Image=3D"rbxassetid://8992230677",
ThemeTag=3D{
ImageColor3=3D"WindowShadow",

},
ImageTransparency=3D1,
Size=3DUDim2.new(1,100,1,100),
Position=3DUDim2.new(0,-50,0,-50),
ScaleType=3D"Slice",
SliceCenter=3DRect.new(99,99,99,99),
BackgroundTransparency=3D1,
ZIndex=3D-999999999999999,
Name=3D"Blur",
})

if ae.TouchEnabled and not ae.KeyboardEnabled then
au.IsPC=3Dfalse
elseif ae.KeyboardEnabled then
au.IsPC=3Dtrue
else
au.IsPC=3Dnil
end







local aB
if au.User then
local function GetUserThumb()local
b=3Dah:GetUserThumbnailAsync(
au.User.Anonymous and 1 or ah.LocalPlayer.UserId,
Enum.ThumbnailType.HeadShot,
Enum.ThumbnailSize.Size420x420
)
return b
end

aB=3Dam("TextButton",{
Size=3DUDim2.new(
0,
au.UIElements.SideBarContainer.AbsoluteSize.X-(au.UIPadding/2),
0,
42+au.UIPadding
),
Position=3DUDim2.new(0,au.UIPadding/2,1,-(au.UIPadding/2)),
AnchorPoint=3DVector2.new(0,1),
BackgroundTransparency=3D1,
Visible=3Dau.User.Enabled or false,
},{
al.NewRoundFrame(au.UICorner-(au.UIPadding/2),"SquircleOutline",{
Size=3DUDim2.new(1,0,1,0),
ThemeTag=3D{
ImageColor3=3D"Text",
},
ImageTransparency=3D1,
Name=3D"Outline",
},{
am("UIGradient",{
Rotation=3D78,
Color=3DColorSequence.new{
ColorSequenceKeypoint.new(0.0,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(0.5,Color3.fromRGB(255,255,255)),
ColorSequenceKeypoint.new(1.0,Color3.fromRGB(255,255,255)),
},
Transparency=3DNumberSequence.new{
NumberSequenceKeypoint.new(0.0,0.1),
NumberSequenceKeypoint.new(0.5,1),
NumberSequenceKeypoint.new(1.0,0.1),
},
}),
}),
al.NewRoundFrame(au.UICorner-(au.UIPadding/2),"Squircle",{
Size=3DUDim2.new(1,0,1,0),
ThemeTag=3D{
ImageColor3=3D"Text",
},
ImageTransparency=3D1,
Name=3D"UserIcon",
},{
am("ImageLabel",{
Image=3DGetUserThumb(),
BackgroundTransparency=3D1,
Size=3DUDim2.new(0,42,0,42),
ThemeTag=3D{
BackgroundColor3=3D"Text",
},
BackgroundTransparency=3D0.93,
},{
am("UICorner",{
CornerRadius=3DUDim.new(1,0),
}),
}),
am("Frame",{
AutomaticSize=3D"XY",
BackgroundTransparency=3D1,
},{
am("TextLabel",{
Text=3Dau.User.Anonymous and"Anonymous"or ah.LocalPlayer.DisplayName,
TextSize=3D17,
ThemeTag=3D{
TextColor3=3D"Text",
},
FontFace=3DFont.new(al.Font,Enum.FontWeight.SemiBold),
AutomaticSize=3D"Y",
BackgroundTransparency=3D1,
Size=3DUDim2.new(1,-27,0,0),
TextTruncate=3D"AtEnd",
TextXAlignment=3D"Left",
Name=3D"DisplayName",
}),
am("TextLabel",{
Text=3Dau.User.Anonymous and"anonymous"or ah.LocalPlayer.Name,
TextSize=3D15,
TextTransparency=3D0.6,
ThemeTag=3D{
TextColor3=3D"Text",
},
FontFace=3DFont.new(al.Font,Enum.FontWeight.Medium),
AutomaticSize=3D"Y",
BackgroundTransparency=3D1,
Size=3DUDim2.new(1,-27,0,0),
TextTruncate=3D"AtEnd",
TextXAlignment=3D"Left",
Name=3D"UserName",
}),
am("UIListLayout",{
Padding=3DUDim.new(0,4),
HorizontalAlignment=3D"Left",
}),
}),
am("UIListLayout",{
Padding=3DUDim.new(0,au.UIPadding),
FillDirection=3D"Horizontal",
VerticalAlignment=3D"Center",
}),
am("UIPadding",{
PaddingLeft=3DUDim.new(0,au.UIPadding/2),
PaddingRight=3DUDim.new(0,au.UIPadding/2),
}),
}),
})

function au.User.Enable(b)
au.User.Enabled=3Dtrue
an(
au.UIElements.SideBarContainer,
0.25,
{Size=3DUDim2.new(0,au.SideBarWidth,1,-au.Topbar.Height-42-(au.UIPadding*2)=
)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
aB.Visible=3Dtrue
end
function au.User.Disable(b)
au.User.Enabled=3Dfalse
an(
au.UIElements.SideBarContainer,
0.25,
{Size=3DUDim2.new(0,au.SideBarWidth,1,-au.Topbar.Height)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
aB.Visible=3Dfalse
end
function au.User.SetAnonymous(b,d)
if d~=3Dfalse then
d=3Dtrue
end
au.User.Anonymous=3Dd
aB.UserIcon.ImageLabel.Image=3DGetUserThumb()
aB.UserIcon.Frame.DisplayName.Text=3Dd and"Anonymous"or ah.LocalPlayer.Disp=
layName
aB.UserIcon.Frame.UserName.Text=3Dd and"anonymous"or ah.LocalPlayer.Name
end

if au.User.Enabled then
au.User:Enable()
else
au.User:Disable()
end

if au.User.Callback then
al.AddSignal(aB.MouseButton1Click,function()
au.User.Callback()
end)
al.AddSignal(aB.MouseEnter,function()
an(aB.UserIcon,0.04,{ImageTransparency=3D0.95}):Play()
an(aB.Outline,0.04,{ImageTransparency=3D0.85}):Play()
end)
al.AddSignal(aB.InputEnded,function()
an(aB.UserIcon,0.04,{ImageTransparency=3D1}):Play()
an(aB.Outline,0.04,{ImageTransparency=3D1}):Play()
end)
end
end

local b
local d

local f=3Dfalse
local g

local h=3Dtypeof(au.Background)=3D=3D"string"and string.match(au.Background=
,"^video:(.+)")or nil
local j=3Dtypeof(au.Background)=3D=3D"string"
and not h
and(string.match(au.Background,"^https?://.+")or string.match(au.Background=
,"^rbx%w+://.+"))
or nil

local function GetImageExtension(l)
if not l or typeof(l)~=3D"string"then
return".png"
end
local m=3Dl:match"^([^?#]+)"or l
local p=3Dm:match"%.(%w+)$"
if p then
p=3Dp:lower()
if p=3D=3D"jpg"or p=3D=3D"jpeg"or p=3D=3D"png"or p=3D=3D"webp"then
return"."..p
end
end
return".png"
end



if typeof(au.Background)=3D=3D"string"and h then
f=3Dtrue

if string.find(h,"http")then
local l=3D(au.Folder or"Temp").."/assets/."..al.SanitizeFilename(h)..".webm=
"
if not isfile(l)then
local m,p=3Dpcall(function()





local m=3Dgame.HttpGet and game:HttpGet(h)
or al.Request{
Url=3Dh,
Method=3D"GET",
Headers=3D{["User-Agent"]=3D"Roblox/Exploit"},
}.Body

writefile(l,m)
end)
if not m then
warn("[ WindUI.Window.Background ] Failed to download video: "..tostring(p)=
)
return
end
end

local m,p=3Dpcall(function()
return getcustomasset(l)
end)
if not m then
warn("[ WindUI.Window.Background ] Failed to load custom asset: "..tostring=
(p))
return
end
warn"[ WindUI.Window.Background ] VideoFrame may not work with custom video=
"
h=3Dp
end

g=3Dam("VideoFrame",{
BackgroundTransparency=3D1,
Size=3DUDim2.new(1,0,1,0),
Video=3Dh,
Looped=3Dtrue,
Volume=3D0,
},{
am("UICorner",{
CornerRadius=3DUDim.new(0,au.UICorner),
}),
})
g:Play()
elseif j then
local l=3D(au.Folder or"Temp")
.."/assets/."
..al.SanitizeFilename(j)
..GetImageExtension(j)
if isfile and not isfile(l)then
local m,p=3Dpcall(function()





local m=3Dgame.HttpGet and game:HttpGet(j)
or al.Request{
Url=3Dh,
Method=3D"GET",
Headers=3D{["User-Agent"]=3D"Roblox/Exploit"},
}.Body

writefile(l,m)
end)
if not m then
warn("[ Window.Background ] Failed to download image: "..tostring(p))
return
end
end

local m,p=3Dpcall(function()
return getcustomasset(l)
end)
if not m then
warn("[ Window.Background ] Failed to load custom asset: "..tostring(p))
return
end

g=3Dam("ImageLabel",{
BackgroundTransparency=3D1,
Size=3DUDim2.new(1,0,1,0),
Image=3Dp or j,
ImageTransparency=3D0,
ScaleType=3D"Crop",
},{
am("UICorner",{
CornerRadius=3DUDim.new(0,au.UICorner),
}),
})
elseif au.Background then
g=3Dam("ImageLabel",{
BackgroundTransparency=3D1,
Size=3DUDim2.new(1,0,1,0),
Image=3Dtypeof(au.Background)=3D=3D"string"and au.Background or"",
ImageTransparency=3D1,
ScaleType=3D"Crop",
},{
am("UICorner",{
CornerRadius=3DUDim.new(0,au.UICorner),
}),
})
end

local l=3Dal.NewRoundFrame(99,"Squircle",{
ImageTransparency=3D0.8,
ImageColor3=3DColor3.new(1,1,1),
Size=3DUDim2.new(0,0,0,4),
Position=3DUDim2.new(0.5,0,1,4),
AnchorPoint=3DVector2.new(0.5,0),
},{
am("TextButton",{
Size=3DUDim2.new(1,12,1,12),
BackgroundTransparency=3D1,
Position=3DUDim2.new(0.5,0,0.5,0),
AnchorPoint=3DVector2.new(0.5,0.5),
Active=3Dtrue,
ZIndex=3D99,
Name=3D"Frame",
}),
})

function createAuthor(m)
return am("TextLabel",{
Text=3Dm,
FontFace=3DFont.new(al.Font,Enum.FontWeight.Medium),
BackgroundTransparency=3D1,
TextTransparency=3D0.35,
AutomaticSize=3D"XY",
Parent=3Dau.UIElements.Main and au.UIElements.Main.Main.Topbar.Left.Title,
TextXAlignment=3D"Left",
TextSize=3D13,
LayoutOrder=3D2,
ThemeTag=3D{
TextColor3=3D"WindowTopbarAuthor",
},
Name=3D"Author",
})
end

local m
local p

if au.Author then
m=3DcreateAuthor(au.Author)
end

local r=3Dam("TextLabel",{
Text=3Dau.Title,
FontFace=3DFont.new(al.Font,Enum.FontWeight.SemiBold),
BackgroundTransparency=3D1,
AutomaticSize=3D"XY",
Name=3D"Title",
TextXAlignment=3D"Left",
TextSize=3D16,
ThemeTag=3D{
TextColor3=3D"WindowTopbarTitle",
},
})

au.UIElements.Main=3Dam("Frame",{
Size=3Dau.Size,
Position=3Dau.Position,
BackgroundTransparency=3D1,
Parent=3Dat.Parent,
AnchorPoint=3DVector2.new(0.5,0.5),
Active=3Dtrue,
},{
at.WindUI.UIScaleObj,
au.AcrylicPaint and au.AcrylicPaint.Frame or nil,
aA,
al.NewRoundFrame(au.UICorner,"Squircle",{
ImageTransparency=3D1,
Size=3DUDim2.new(1,0,1,-240),
AnchorPoint=3DVector2.new(0.5,0.5),
Position=3DUDim2.new(0.5,0,0.5,0),
Name=3D"Background",
ThemeTag=3D{
ImageColor3=3D"WindowBackground",
},

},{
g,
l,
ax,
}),




aw,
ay,
az,
am("Frame",{
Size=3DUDim2.new(1,0,1,0),
BackgroundTransparency=3D1,
Name=3D"Main",

Visible=3Dfalse,
ZIndex=3D97,
},{
am("UICorner",{
CornerRadius=3DUDim.new(0,au.UICorner),
}),
au.UIElements.SideBarContainer,
au.UIElements.MainBar,

aB,

d,
am("Frame",{
Size=3DUDim2.new(1,0,0,au.Topbar.Height),
BackgroundTransparency=3D1,
BackgroundColor3=3DColor3.fromRGB(50,50,50),
Name=3D"Topbar",
},{
b,






am("Frame",{
AutomaticSize=3D"X",
Size=3DUDim2.new(0,0,1,0),
BackgroundTransparency=3D1,
Name=3D"Left",
},{
am("UIListLayout",{
Padding=3DUDim.new(0,au.UIPadding+4),
SortOrder=3D"LayoutOrder",
FillDirection=3D"Horizontal",
VerticalAlignment=3D"Center",
}),
am("Frame",{
AutomaticSize=3D"XY",
BackgroundTransparency=3D1,
Name=3D"Title",
Size=3DUDim2.new(0,0,1,0),
LayoutOrder=3D2,
},{
am("UIListLayout",{
Padding=3DUDim.new(0,0),
SortOrder=3D"LayoutOrder",
FillDirection=3D"Vertical",
VerticalAlignment=3D"Center",
}),
r,
m,
}),
am("UIPadding",{
PaddingLeft=3DUDim.new(0,4),
}),
}),
am("ScrollingFrame",{
Name=3D"Center",
BackgroundTransparency=3D1,
AutomaticSize=3D"Y",
ScrollBarThickness=3D0,
ScrollingDirection=3D"X",
AutomaticCanvasSize=3D"X",
CanvasSize=3DUDim2.new(0,0,0,0),
Size=3DUDim2.new(0,0,1,0),
AnchorPoint=3DVector2.new(0,0.5),
Position=3DUDim2.new(0,0,0.5,0),
Visible=3Dfalse,
},{
am("UIListLayout",{
FillDirection=3D"Horizontal",
VerticalAlignment=3D"Center",
HorizontalAlignment=3D"Left",
Padding=3DUDim.new(0,au.UIPadding/2),
}),
}),
am("Frame",{
AutomaticSize=3D"XY",
BackgroundTransparency=3D1,
Position=3DUDim2.new(au.Topbar.ButtonsType=3D=3D"Default"and 1 or 0,0,0.5,0=
),
AnchorPoint=3DVector2.new(au.Topbar.ButtonsType=3D=3D"Default"and 1 or 0,0.=
5),
Name=3D"Right",
},{
am("UIListLayout",{
Padding=3DUDim.new(0,au.Topbar.ButtonsType=3D=3D"Default"and 9 or 0),
FillDirection=3D"Horizontal",
SortOrder=3D"LayoutOrder",
}),
}),
am("UIPadding",{
PaddingTop=3DUDim.new(0,au.UIPadding),
PaddingLeft=3DUDim.new(
0,
au.Topbar.ButtonsType=3D=3D"Default"and au.UIPadding or au.UIPadding-2
),
PaddingRight=3DUDim.new(0,8),
PaddingBottom=3DUDim.new(0,au.UIPadding),
}),
}),
}),
})

al.AddSignal(au.UIElements.Main.Main.Topbar.Left:GetPropertyChangedSignal"A=
bsoluteSize",function()
local u=3D0
local v=3Dau.UIElements.Main.Main.Topbar.Right.UIListLayout.AbsoluteContent=
Size.X
/at.WindUI.UIScale





u=3Dau.UIElements.Main.Main.Topbar.Left.AbsoluteSize.X/at.WindUI.UIScale
if au.Topbar.ButtonsType~=3D"Default"then
u=3Du+v+au.UIPadding-4
end



au.UIElements.Main.Main.Topbar.Center.Position=3D
UDim2.new(0,u+(au.UIPadding/at.WindUI.UIScale),0.5,0)
au.UIElements.Main.Main.Topbar.Center.Size=3D
UDim2.new(1,-u-v-((au.UIPadding*2)/at.WindUI.UIScale),1,0)
end)

if au.Topbar.ButtonsType~=3D"Default"then
al.AddSignal(au.UIElements.Main.Main.Topbar.Right:GetPropertyChangedSignal"=
AbsoluteSize",function()
au.UIElements.Main.Main.Topbar.Left.Position=3DUDim2.new(
0,
(au.UIElements.Main.Main.Topbar.Right.AbsoluteSize.X/at.WindUI.UIScale)+au.=
UIPadding-4,
0,
0
)
end)
end

function au.CreateTopbarButton(u,v,x,z,A,B,C,F)
local G=3Dal.Image(
x,
x,
0,
au.Folder,
"WindowTopbarIcon",
au.Topbar.ButtonsType=3D=3D"Default"and true or false,
B,
"WindowTopbarButtonIcon"
)
G.Size=3Dau.Topbar.ButtonsType=3D=3D"Default"
and UDim2.new(0,F or au.TopBarButtonIconSize,0,F or au.TopBarButtonIconSize=
)
or UDim2.new(0,0,0,0)
G.AnchorPoint=3DVector2.new(0.5,0.5)
G.Position=3DUDim2.new(0.5,0,0.5,0)
G.ImageLabel.ImageTransparency=3Dau.Topbar.ButtonsType=3D=3D"Default"and 0 =
or 1

if au.Topbar.ButtonsType~=3D"Default"then
G.ImageLabel.ImageColor3=3Dal.GetTextColorForHSB(C)
end

local H=3Dal.NewRoundFrame(
au.Topbar.ButtonsType=3D=3D"Default"and au.UICorner-(au.UIPadding/2)or 999,
"Squircle",
{
Size=3Dau.Topbar.ButtonsType=3D=3D"Default"
and UDim2.new(0,au.Topbar.Height-16,0,au.Topbar.Height-16)
or UDim2.new(0,14,0,14),
LayoutOrder=3DA or 999,


ZIndex=3D9999,
AnchorPoint=3DVector2.new(0.5,0.5),
Position=3DUDim2.new(0.5,0,0.5,0),
ImageColor3=3Dau.Topbar.ButtonsType~=3D"Default"and(C or Color3.fromHex"#ff=
3030")or nil,
ThemeTag=3Dau.Topbar.ButtonsType=3D=3D"Default"and{
ImageColor3=3D"Text",
}or nil,
ImageTransparency=3Dau.Topbar.ButtonsType=3D=3D"Default"and 1 or 0,
},
{
al.NewRoundFrame(
au.Topbar.ButtonsType=3D=3D"Default"and au.UICorner-(au.UIPadding/2)or 999,
"Glass-1",
{
Size=3DUDim2.new(1,0,1,0),
ThemeTag=3D{
ImageColor3=3D"Outline",
},
ImageTransparency=3Dau.Topbar.ButtonsType=3D=3D"Default"and 1 or 0.5,
Name=3D"Outline",
}
),
G,
am("UIScale",{
Scale=3D1,
}),
},
true
)

am("Frame",{
Size=3Dau.Topbar.ButtonsType~=3D"Default"and UDim2.new(0,24,0,24)
or UDim2.new(0,au.Topbar.Height-16,0,au.Topbar.Height-16),
BackgroundTransparency=3D1,
Parent=3Dau.UIElements.Main.Main.Topbar.Right,
LayoutOrder=3DA or 999,
},{
H,
})



au.TopBarButtons[100-A]=3D{
Name=3Dv,
Object=3DH,
}

al.AddSignal(H.MouseButton1Click,function()
if z then
z()
end
end)
al.AddSignal(H.MouseEnter,function()
if au.Topbar.ButtonsType=3D=3D"Default"then
an(H,0.15,{ImageTransparency=3D0.93}):Play()
an(H.Outline,0.15,{ImageTransparency=3D0.75}):Play()

else

an(
G.ImageLabel,
0.1,
{ImageTransparency=3D0},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
an(G,0.1,{
Size=3DUDim2.new(
0,
F or au.TopBarButtonIconSize,
0,
F or au.TopBarButtonIconSize
),
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end)

al.AddSignal(H.MouseButton1Down,function()
an(H.UIScale,0.2,{Scale=3D0.9},Enum.EasingStyle.Quint,Enum.EasingDirection.=
Out):Play()
end)

al.AddSignal(H.MouseLeave,function()
if au.Topbar.ButtonsType=3D=3D"Default"then
an(H,0.1,{ImageTransparency=3D1}):Play()
an(H.Outline,0.1,{ImageTransparency=3D1}):Play()

else

an(
G.ImageLabel,
0.1,
{ImageTransparency=3D1},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
an(
G,
0.1,
{Size=3DUDim2.new(0,0,0,0)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
end
end)

al.AddSignal(H.InputEnded,function()
an(H.UIScale,0.2,{Scale=3D1},Enum.EasingStyle.Quint,Enum.EasingDirection.In=
Out):Play()
end)

return H
end

function au.Topbar.Button(u,v:{
Name:string,
Icon:string,
Callback:any,
LayoutOrder:number,
IconThemed:boolean,
Color:Color3,
IconSize:number,
})
return au:CreateTopbarButton(
v.Name,
v.Icon,
v.Callback,
v.LayoutOrder or 0,
v.IconThemed,
v.Color,
v.IconSize
)
end



local u=3Dal.Drag(
au.UIElements.Main,
{au.UIElements.Main.Main.Topbar,l.Frame},
function(u,v)
if not au.Closed then
if u and v=3D=3Dl.Frame then
an(l,0.1,{ImageTransparency=3D0.35}):Play()
else
an(l,0.2,{ImageTransparency=3D0.8}):Play()
end
au.Position=3Dau.UIElements.Main.Position
au.Dragging=3Du
end
end
)

if not f and au.Background and typeof(au.Background)=3D=3D"table"then
local v=3Dam"UIGradient"
for x,z in next,au.Background do
v[x]=3Dz
end

au.UIElements.BackgroundGradient=3Dal.NewRoundFrame(au.UICorner,"Squircle",=
{
Size=3DUDim2.new(1,0,1,0),
Parent=3Dau.UIElements.Main.Background,
ImageTransparency=3Dau.Transparent and at.WindUI.TransparencyValue or 0,
},{
v,
})
end














au.OpenButtonMain=3Da.load'z'.New(au)

task.spawn(function()
if au.Icon then
local v=3Dam("Frame",{
Size=3DUDim2.new(0,22,0,22),
BackgroundTransparency=3D1,
Parent=3Dau.UIElements.Main.Main.Topbar.Left,
})

p=3Dal.Image(
au.Icon,
au.Title,
au.IconRadius,
au.Folder,
"Window",
true,
au.IconThemed,
"WindowTopbarIcon"
)
p.Parent=3Dv
p.Size=3DUDim2.new(0,au.IconSize,0,au.IconSize)
p.Position=3DUDim2.new(0.5,0,0.5,0)
p.AnchorPoint=3DVector2.new(0.5,0.5)

au.OpenButtonMain:SetIcon(au.Icon)











else
au.OpenButtonMain:SetIcon(au.Icon)

end
end)

function au.SetToggleKey(v,x)
au.ToggleKey=3Dx
end

function au.SetTitle(v,x)
au.Title=3Dx
r.Text=3Dx
end

function au.SetAuthor(v,x)
au.Author=3Dx
if not m then
m=3DcreateAuthor(au.Author)
end

m.Text=3Dx
end

function au.SetSize(v,x)
if typeof(x)=3D=3D"UDim2"then
au.Size=3Dx

an(au.UIElements.Main,0.08,{Size=3Dx},Enum.EasingStyle.Quint,Enum.EasingDir=
ection.Out):Play()
end
end

function au.SetBackgroundImage(v,x)
au.UIElements.Main.Background.ImageLabel.Image=3Dx
end
function au.SetBackgroundImageTransparency(v,x)
if g and g:IsA"ImageLabel"then
g.ImageTransparency=3Dmath.floor(x*10+0.5)/10
end
au.BackgroundImageTransparency=3Dmath.floor(x*10+0.5)/10
end

function au.SetBackgroundTransparency(v,x)
local z=3Dmath.floor(tonumber(x)*10+0.5)/10
at.WindUI.TransparencyValue=3Dz
au:ToggleTransparency(z&gt;0)
end

local v
local x
al.Icon"minimize"
al.Icon"maximize"

au:CreateTopbarButton(
"Fullscreen",
au.Topbar.ButtonsType=3D=3D"Mac"and"rbxassetid://127426072704909"or"maximiz=
e",
function()
au:ToggleFullscreen()
end,
(au.Topbar.ButtonsType=3D=3D"Default"and 998 or 999),
true,
Color3.fromHex"#60C762",
au.Topbar.ButtonsType=3D=3D"Mac"and 9 or nil
)

function au.ToggleFullscreen(z)
local A=3Dau.IsFullscreen

u:Set(A)

if not A then
v=3Dau.UIElements.Main.Position
x=3Dau.UIElements.Main.Size

au.CanResize=3Dfalse
else
if au.Resizable then
au.CanResize=3Dtrue
end
end

an(
au.UIElements.Main,
0.45,
{Size=3DA and x or UDim2.new(1,-20,1,-72)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()

an(
au.UIElements.Main,
0.45,
{Position=3DA and v or UDim2.new(0.5,0,0.5,26)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()



au.IsFullscreen=3Dnot A
end

au:CreateTopbarButton("Minimize","minus",function()
au:Close()






















end,(au.Topbar.ButtonsType=3D=3D"Default"and 997 or 998),nil,Color3.fromHex=
"#F4C948")

function au.OnOpen(z,A)
au.OnOpenCallback=3DA
end
function au.OnClose(z,A)
au.OnCloseCallback=3DA
end
function au.OnDestroy(z,A)
au.OnDestroyCallback=3DA
end

if at.WindUI.UseAcrylic then
au.AcrylicPaint.AddParent(au.UIElements.Main)
end

function au.SetIconSize(z,A)
local B
if typeof(A)=3D=3D"number"then
B=3DUDim2.new(0,A,0,A)
au.IconSize=3DA
elseif typeof(A)=3D=3D"UDim2"then
B=3DA
au.IconSize=3DA.X.Offset
end

if p then
p.Size=3DB
end
end

function au.Open(z)
task.spawn(function()
if au.OnOpenCallback then
task.spawn(function()
al.SafeCallback(au.OnOpenCallback)
end)
end

task.wait(0.06)
au.Closed=3Dfalse

an(au.UIElements.Main.Background,0.2,{
ImageTransparency=3Dau.Transparent and at.WindUI.TransparencyValue or 0,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()

if au.UIElements.BackgroundGradient then
an(au.UIElements.BackgroundGradient,0.2,{
ImageTransparency=3D0,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end

an(au.UIElements.Main.Background,0.4,{
Size=3DUDim2.new(1,0,1,0),
},Enum.EasingStyle.Exponential,Enum.EasingDirection.Out):Play()

if g then
if g:IsA"VideoFrame"then
g.Visible=3Dtrue
else
an(g,0.2,{
ImageTransparency=3Dau.BackgroundImageTransparency,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end

if au.OpenButtonMain and au.IsOpenButtonEnabled then
au.OpenButtonMain:Visible(false)
end

at.WindUI.UIScaleObj.Scale-=3D0.15000000000000002
an(
at.WindUI.UIScaleObj,
0.33,
{Scale=3Dat.WindUI.UIScale},
Enum.EasingStyle.Back,
Enum.EasingDirection.Out
):Play()
an(
aA,
0.25,
{ImageTransparency=3Dau.ShadowTransparency},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
if UIStroke then
an(UIStroke,0.25,{Transparency=3D0.8},Enum.EasingStyle.Quint,Enum.EasingDir=
ection.Out):Play()
end

task.spawn(function()
task.wait(0.3)
an(
l,
0.45,
{Size=3DUDim2.new(0,au.DragFrameSize,0,4),ImageTransparency=3D0.8},
Enum.EasingStyle.Exponential,
Enum.EasingDirection.Out
):Play()
u:Set(true)
task.wait(0.45)
if au.Resizable then
an(
ax.ImageLabel,
0.45,
{ImageTransparency=3D0.8},
Enum.EasingStyle.Exponential,
Enum.EasingDirection.Out
):Play()
au.CanResize=3Dtrue
end
end)

au.CanDropdown=3Dtrue
au.UIElements.Main.Visible=3Dtrue
task.spawn(function()
task.wait(0.05)
au.UIElements.Main:WaitForChild"Main".Visible=3Dtrue

at.WindUI:ToggleAcrylic(true)
end)
end)
end
function au.Close(z)
local A=3D{}

if au.OnCloseCallback then
task.spawn(function()
al.SafeCallback(au.OnCloseCallback)
end)
end

at.WindUI:ToggleAcrylic(false)

if au.UIElements.Main and au.UIElements.Main:WaitForChild"Main"then
au.UIElements.Main.Main.Visible=3Dfalse
end

au.CanDropdown=3Dfalse
au.Closed=3Dtrue

an(au.UIElements.Main.Background,0.32,{
ImageTransparency=3D1,
},Enum.EasingStyle.Quint,Enum.EasingDirection.InOut):Play()
if au.UIElements.BackgroundGradient then
an(au.UIElements.BackgroundGradient,0.32,{
ImageTransparency=3D1,
},Enum.EasingStyle.Quint,Enum.EasingDirection.InOut):Play()
end

an(au.UIElements.Main.Background,0.4,{
Size=3DUDim2.new(1,0,1,-240),
},Enum.EasingStyle.Exponential,Enum.EasingDirection.InOut):Play()

an(
at.WindUI.UIScaleObj,
0.28,
{Scale=3Dat.WindUI.UIScale-(0.15000000000000002)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
if g then
if g:IsA"VideoFrame"then
g.Visible=3Dfalse
else
an(g,0.3,{
ImageTransparency=3D1,
},Enum.EasingStyle.Quint,Enum.EasingDirection.Out):Play()
end
end
an(aA,0.25,{ImageTransparency=3D1},Enum.EasingStyle.Quint,Enum.EasingDirect=
ion.Out):Play()
if UIStroke then
an(UIStroke,0.25,{Transparency=3D1},Enum.EasingStyle.Quint,Enum.EasingDirec=
tion.Out):Play()
end

an(
l,
0.3,
{Size=3DUDim2.new(0,0,0,4),ImageTransparency=3D1},
Enum.EasingStyle.Exponential,
Enum.EasingDirection.InOut
):Play()
an(
ax.ImageLabel,
0.3,
{ImageTransparency=3D1},
Enum.EasingStyle.Exponential,
Enum.EasingDirection.Out
):Play()
u:Set(false)
au.CanResize=3Dfalse

task.spawn(function()
task.wait(0.4)
au.UIElements.Main.Visible=3Dfalse

if au.OpenButtonMain and not au.Destroyed and not au.IsPC and au.IsOpenButt=
onEnabled then
au.OpenButtonMain:Visible(true)
end
end)

function A.Destroy(B)
task.spawn(function()
if au.OnDestroyCallback then
task.spawn(function()
al.SafeCallback(au.OnDestroyCallback)
end)
end
if au.AcrylicPaint and au.AcrylicPaint.Model then
au.AcrylicPaint.Model:Destroy()
end
au.Destroyed=3Dtrue
task.wait(0.4)
at.WindUI.ScreenGui:Destroy()
at.WindUI.NotificationGui:Destroy()
at.WindUI.DropdownGui:Destroy()
at.WindUI.TooltipGui:Destroy()

al.DisconnectAll()

return
end)
end

return A
end
function au.Destroy(z)
return au:Close():Destroy()
end
function au.Toggle(z)
if au.Closed then
au:Open()
else
au:Close()
end
end

function au.ToggleTransparency(z,A)

au.Transparent=3DA
at.WindUI.Transparent=3DA

au.UIElements.Main.Background.ImageTransparency=3DA and at.WindUI.Transpare=
ncyValue or 0


end

function au.LockAll(z)
for A,B in next,au.AllElements do
if B.Lock then
B:Lock()
end
end
end
function au.UnlockAll(z)
for A,B in next,au.AllElements do
if B.Unlock then
B:Unlock()
end
end
end
function au.GetLocked(z)
local A=3D{}

for B,C in next,au.AllElements do
if C.Locked then
table.insert(A,C)
end
end

return A
end
function au.GetUnlocked(z)
local A=3D{}

for B,C in next,au.AllElements do
if C.Locked=3D=3Dfalse then
table.insert(A,C)
end
end

return A
end

function au.GetUIScale(z,A)
return at.WindUI.UIScale
end

function au.SetUIScale(z,A)
at.WindUI.UIScale=3DA
an(at.WindUI.UIScaleObj,0.2,{Scale=3DA},Enum.EasingStyle.Quint,Enum.EasingD=
irection.Out):Play()
return au
end

function au.SetToTheCenter(z)
an(
au.UIElements.Main,
0.45,
{Position=3DUDim2.new(0.5,0,0.5,0)},
Enum.EasingStyle.Quint,
Enum.EasingDirection.Out
):Play()
return au
end

function au.SetCurrentConfig(z,A)
au.CurrentConfig=3DA
end

do
local z=3D40
local A=3Daj.ViewportSize
local B=3Dau.UIElements.Main.AbsoluteSize

if not au.IsFullscreen and au.AutoScale then
local C=3DA.X-(z*2)
local F=3DA.Y-(z*2)

local G=3DC/B.X
local H=3DF/B.Y

local J=3Dmath.min(G,H)

local L=3D0.3
local M=3D1.0

local N=3Dmath.clamp(J,L,M)

local O=3Dau:GetUIScale()or 1
local P=3D0.05

if math.abs(N-O)&gt;P then
au:SetUIScale(N)
end
end
end

if au.OpenButtonMain and au.OpenButtonMain.Button then
al.AddSignal(au.OpenButtonMain.Button.TextButton.MouseButton1Click,function=
()


au:Open()
end)
end

al.AddSignal(ae.InputBegan,function(z,A)
if A then
return
end

if au.ToggleKey then
if z.KeyCode=3D=3Dau.ToggleKey then
au:Toggle()
end
end
end)

task.spawn(function()

au:Open()
end)

function au.EditOpenButton(z,A)
return au.OpenButtonMain:Edit(A)
end

if au.OpenButton and typeof(au.OpenButton)=3D=3D"table"then
au:EditOpenButton(au.OpenButton)
end

local z=3Da.load'Z'
local A=3Da.load'_'
local B=3Dz.Init(au,at.WindUI,at.WindUI.TooltipGui)
B:OnChange(function(C)
au.CurrentTab=3DC
end)

au.TabModule=3DB

function au.Tab(C,F)
F.Parent=3Dau.UIElements.SideBar.Frame
return B.New(F,at.WindUI.UIScale)
end

function au.SelectTab(C,F)
B:SelectTab(F)
end

function au.Section(C,F)
return A.New(
F,
au.UIElements.SideBar.Frame,
au.Folder,
at.WindUI.UIScale,
au
)
end

function au.IsResizable(C,F)
au.Resizable=3DF
au.CanResize=3DF
end

function au.SetPanelBackground(C,F)
if typeof(F)=3D=3D"boolean"then
au.HidePanelBackground=3DF

au.UIElements.MainBar.Background.Visible=3DF

if B then
for G,H in next,B.Containers do
H.ScrollingFrame.UIPadding.PaddingTop=3DUDim.new(0,au.HidePanelBackground a=
nd 20 or 10)
H.ScrollingFrame.UIPadding.PaddingLeft=3D
UDim.new(0,au.HidePanelBackground and 20 or 10)
H.ScrollingFrame.UIPadding.PaddingRight=3D
UDim.new(0,au.HidePanelBackground and 20 or 10)
H.ScrollingFrame.UIPadding.PaddingBottom=3D
UDim.new(0,au.HidePanelBackground and 20 or 10)
end
end
end
end

function au.Divider(C)
local F=3Dam("Frame",{
Size=3DUDim2.new(1,0,0,1),
Position=3DUDim2.new(0.5,0,0,0),
AnchorPoint=3DVector2.new(0.5,0),
BackgroundTransparency=3D0.9,
ThemeTag=3D{
BackgroundColor3=3D"Text",
},
})
local G=3Dam("Frame",{
Parent=3Dau.UIElements.SideBar.Frame,

Size=3DUDim2.new(1,-7,0,5),
BackgroundTransparency=3D1,
},{
F,
})

return G
end

local C=3Da.load'n'
function au.Dialog(F,G)
local H=3D{
Title=3DG.Title or"Dialog",
Width=3DG.Width or 320,
Content=3DG.Content,
Buttons=3DG.Buttons or{},

TextPadding=3D14,
}
local J=3DC.Create(false,"Dialog",au,at.WindUI,au.UIElements.Main.Main)

J.UIElements.Main.Size=3DUDim2.new(0,H.Width,0,0)

local L=3Dam("Frame",{
Size=3DUDim2.new(1,0,1,0),
AutomaticSize=3D"Y",
BackgroundTransparency=3D1,
Parent=3DJ.UIElements.Main,
},{
am("UIListLayout",{
FillDirection=3D"Vertical",

Padding=3DUDim.new(0,J.UIPadding),
}),
})

local M=3Dam("Frame",{
Size=3DUDim2.new(1,0,0,0),
AutomaticSize=3D"Y",
BackgroundTransparency=3D1,
Parent=3DL,
},{
am("UIListLayout",{
FillDirection=3D"Horizontal",
Padding=3DUDim.new(0,J.UIPadding),
VerticalAlignment=3D"Center",
}),
am("UIPadding",{
PaddingTop=3DUDim.new(0,H.TextPadding/2),
PaddingLeft=3DUDim.new(0,H.TextPadding/2),
PaddingRight=3DUDim.new(0,H.TextPadding/2),
}),
})

local N
if G.Icon then
N=3Dal.Image(
G.Icon,
H.Title..":"..G.Icon,
0,
au,
"Dialog",
true,
G.IconThemed
)
N.Size=3DUDim2.new(0,22,0,22)
N.Parent=3DM
end

J.UIElements.UIListLayout=3Dam("UIListLayout",{
Padding=3DUDim.new(0,12),
FillDirection=3D"Vertical",
HorizontalAlignment=3D"Left",
VerticalFlex=3D"SpaceBetween",
Parent=3DJ.UIElements.Main,
})

am("UISizeConstraint",{
MinSize=3DVector2.new(180,20),
MaxSize=3DVector2.new(400,math.huge),
Parent=3DJ.UIElements.Main,
})

J.UIElements.Title=3Dam("TextLabel",{
Text=3DH.Title,
TextSize=3D20,
FontFace=3DFont.new(al.Font,Enum.FontWeight.SemiBold),
TextXAlignment=3D"Left",
TextWrapped=3Dtrue,
RichText=3Dtrue,
Size=3DUDim2.new(1,N and-26-J.UIPadding or 0,0,0),
AutomaticSize=3D"Y",
ThemeTag=3D{
TextColor3=3D"Text",
},
BackgroundTransparency=3D1,
Parent=3DM,
})
if H.Content then
am("TextLabel",{
Text=3DH.Content,
TextSize=3D18,
TextTransparency=3D0.4,
TextWrapped=3Dtrue,
RichText=3Dtrue,
FontFace=3DFont.new(al.Font,Enum.FontWeight.Medium),
TextXAlignment=3D"Left",
Size=3DUDim2.new(1,0,0,0),
AutomaticSize=3D"Y",
LayoutOrder=3D2,
ThemeTag=3D{
TextColor3=3D"Text",
},
BackgroundTransparency=3D1,
Parent=3DL,
},{
am("UIPadding",{
PaddingLeft=3DUDim.new(0,H.TextPadding/2),
PaddingRight=3DUDim.new(0,H.TextPadding/2),
PaddingBottom=3DUDim.new(0,H.TextPadding/2),
}),
})
end

local O=3Dam("UIListLayout",{
Padding=3DUDim.new(0,6),
FillDirection=3D"Horizontal",
HorizontalAlignment=3D"Center",
HorizontalFlex=3D"Fill",
})

local P=3Dam("Frame",{
Size=3DUDim2.new(1,0,0,40),
AutomaticSize=3D"None",
BackgroundTransparency=3D1,
Parent=3DJ.UIElements.Main,
LayoutOrder=3D4,
},{
O,






})

local Q=3D{}

for R,S in next,H.Buttons do
local T=3D
ap(S.Title,S.Icon,S.Callback,S.Variant,P,J,true)
table.insert(Q,T)
T.Size=3DUDim2.new(1,0,1,0)
end





















































J:Open()

return J
end

local F=3Dfalse

au:CreateTopbarButton("Close","x",function()
if not F then
if not au.IgnoreAlerts then
F=3Dtrue

au:Dialog{

Title=3D"Close Window",
Content=3D"Do you want to close this window? You will not be able to open i=
t again.",
Buttons=3D{
{
Title=3D"Cancel",

Callback=3Dfunction()
F=3Dfalse
end,
Variant=3D"Secondary",
},
{
Title=3D"Close Window",

Callback=3Dfunction()
F=3Dfalse
au:Destroy()
end,
Variant=3D"Primary",
},
},
}
else
au:Destroy()
end
end
end,(au.Topbar.ButtonsType=3D=3D"Default"and 999 or 997),nil,Color3.fromHex=
"#F4695F")

function au.Tag(G,H)
if au.UIElements.Main.Main.Topbar.Center.Visible=3D=3Dfalse then
au.UIElements.Main.Main.Topbar.Center.Visible=3Dtrue
end
H.Window=3Dau
return ar:New(H,au.UIElements.Main.Main.Topbar.Center)
end

local function startResizing(G)
if au.CanResize then
isResizing=3Dtrue
ay.Active=3Dtrue
initialSize=3Dau.UIElements.Main.Size
initialInputPosition=3DG.Position


an(ax.ImageLabel,0.1,{ImageTransparency=3D0.35}):Play()

al.AddSignal(G.Changed,function()
if G.UserInputState=3D=3DEnum.UserInputState.End then
isResizing=3Dfalse
ay.Active=3Dfalse


an(ax.ImageLabel,0.17,{ImageTransparency=3D0.8}):Play()
end
end)
end
end

al.AddSignal(ax.InputBegan,function(G)
if
G.UserInputType=3D=3DEnum.UserInputType.MouseButton1
or G.UserInputType=3D=3DEnum.UserInputType.Touch
then
if au.CanResize then
startResizing(G)
end
end
end)

al.AddSignal(ae.InputChanged,function(G)
if
G.UserInputType=3D=3DEnum.UserInputType.MouseMovement
or G.UserInputType=3D=3DEnum.UserInputType.Touch
then
if isResizing and au.CanResize then
local H=3DG.Position-initialInputPosition
local J=3DUDim2.new(0,initialSize.X.Offset+H.X*2,0,initialSize.Y.Offset+H.Y=
*2)

J=3DUDim2.new(
J.X.Scale,
math.clamp(J.X.Offset,au.MinSize.X,au.MaxSize.X),
J.Y.Scale,
math.clamp(J.Y.Offset,au.MinSize.Y,au.MaxSize.Y)
)

an(au.UIElements.Main,0.08,{
Size=3DJ,
},Enum.EasingStyle.Quad,Enum.EasingDirection.Out):Play()

au.Size=3DJ
end
end
end)

al.AddSignal(ax.MouseEnter,function()
if not isResizing then
an(ax.ImageLabel,0.1,{ImageTransparency=3D0.35}):Play()
end
end)
al.AddSignal(ax.MouseLeave,function()
if not isResizing then
an(ax.ImageLabel,0.17,{ImageTransparency=3D0.8}):Play()
end
end)



local G=3D0
local H=3D0.4
local J
local L=3D0

function onDoubleClick()
au:SetToTheCenter()
end

al.AddSignal(l.Frame.MouseButton1Up,function()
local M=3Dtick()
local N=3Dau.Position

L=3DL+1

if L=3D=3D1 then
G=3DM
J=3DN

task.spawn(function()
task.wait(H)
if L=3D=3D1 then
L=3D0
J=3Dnil
end
end)
elseif L=3D=3D2 then
if M-G&lt;=3DH and N=3D=3DJ then
onDoubleClick()
end

L=3D0
J=3Dnil
G=3D0
else
L=3D1
G=3DM
J=3DN
end
end)



if not au.HideSearchBar then
local M=3Da.load'ab'
local N=3Dfalse





















local O=3Dao("Search","search",au.UIElements.SideBarContainer,true)
O.Size=3DUDim2.new(1,-au.UIPadding/2,0,39)
O.Position=3DUDim2.new(0,au.UIPadding/2,0,0)

al.AddSignal(O.MouseButton1Click,function()
if N then
return
end

M.new(au.TabModule,au.UIElements.Main,function()

N=3Dfalse
if au.Resizable then
au.CanResize=3Dtrue
end

an(az,0.1,{ImageTransparency=3D1}):Play()
az.Active=3Dfalse
end)
an(az,0.1,{ImageTransparency=3D0.65}):Play()
az.Active=3Dtrue

N=3Dtrue
au.CanResize=3Dfalse
end)
end



function au.DisableTopbarButtons(M,N)
for O,P in next,N do
for Q,R in next,au.TopBarButtons do
if R.Name=3D=3DP then
R.Object.Visible=3Dfalse
end
end
end
end



























return au
end end end

local aa=3D{
Window=3Dnil,
Theme=3Dnil,
Creator=3Da.load'c',
LocalizationModule=3Da.load'd',
NotificationModule=3Da.load'e',
Themes=3Dnil,
Transparent=3Dfalse,

TransparencyValue=3D0.15,

UIScale=3D1,

ConfigManager=3Dnil,
Version=3D"0.0.0",

Services=3Da.load'j',

OnThemeChangeFunction=3Dnil,

cloneref=3Dnil,
UIScaleObj=3Dnil,
}

local ae=3D(cloneref or clonereference or function(ae)
return ae
end)

aa.cloneref=3Dae

local af=3Dae(game:GetService"HttpService")
local ah=3Dae(game:GetService"Players")
local aj=3Dae(game:GetService"CoreGui")
local ak=3Dae(game:GetService"RunService")

local al=3Dah.LocalPlayer or nil

local am=3Daf:JSONDecode(a.load'k')
if am then
aa.Version=3Dam.version
end

local an=3Da.load'o'

local ao=3Daa.Creator

local ap=3Dao.New




local aq=3Da.load's'

local ar=3Dprotectgui or(syn and syn.protect_gui)or function()end

local as=3Dgethui and gethui()or(aj or al:WaitForChild"PlayerGui")

local at=3Dap("UIScale",{
Scale=3Daa.UIScale,
})

aa.UIScaleObj=3Dat

aa.ScreenGui=3Dap("ScreenGui",{
Name=3D"WindUI",
Parent=3Das,
IgnoreGuiInset=3Dtrue,
ScreenInsets=3D"None",
DisplayOrder=3D-99999,
},{

ap("Folder",{
Name=3D"Window",
}),






ap("Folder",{
Name=3D"KeySystem",
}),
ap("Folder",{
Name=3D"Popups",
}),
ap("Folder",{
Name=3D"ToolTips",
}),
})

aa.NotificationGui=3Dap("ScreenGui",{
Name=3D"WindUI/Notifications",
Parent=3Das,
IgnoreGuiInset=3Dtrue,
})
aa.DropdownGui=3Dap("ScreenGui",{
Name=3D"WindUI/Dropdowns",
Parent=3Das,
IgnoreGuiInset=3Dtrue,
})
aa.TooltipGui=3Dap("ScreenGui",{
Name=3D"WindUI/Tooltips",
Parent=3Das,
IgnoreGuiInset=3Dtrue,
})
ar(aa.ScreenGui)
ar(aa.NotificationGui)
ar(aa.DropdownGui)
ar(aa.TooltipGui)

ao.Init(aa)

function aa.SetParent(au,av)
if aa.ScreenGui then
aa.ScreenGui.Parent=3Dav
end
if aa.NotificationGui then
aa.NotificationGui.Parent=3Dav
end
if aa.DropdownGui then
aa.DropdownGui.Parent=3Dav
end
if aa.TooltipGui then
aa.TooltipGui.Parent=3Dav
end
end
math.clamp(aa.TransparencyValue,0,1)

local au=3Daa.NotificationModule.Init(aa.NotificationGui)

function aa.Notify(av,aw)
aw.Holder=3Dau.Frame
aw.Window=3Daa.Window

return aa.NotificationModule.New(aw)
end

function aa.SetNotificationLower(av,aw)
au.SetLower(aw)
end

function aa.SetFont(av,aw)
ao.UpdateFont(aw)
end

function aa.OnThemeChange(av,aw)
aa.OnThemeChangeFunction=3Daw
end

function aa.AddTheme(av,aw)
aa.Themes[aw.Name]=3Daw
return aw
end

function aa.SetTheme(av,aw)
if aa.Themes[aw]then
aa.Theme=3Daa.Themes[aw]
ao.SetTheme(aa.Themes[aw])

if aa.OnThemeChangeFunction then
aa.OnThemeChangeFunction(aw)
end

return aa.Themes[aw]
end
return nil
end

function aa.GetThemes(av)
return aa.Themes
end
function aa.GetCurrentTheme(av)
return aa.Theme.Name
end
function aa.GetTransparency(av)
return aa.Transparent or false
end
function aa.GetWindowSize(av)
return aa.Window.UIElements.Main.Size
end
function aa.Localization(av,aw)
return aa.LocalizationModule:New(aw,ao)
end

function aa.SetLanguage(av,aw)
if ao.Localization then
return ao.SetLanguage(aw)
end
return false
end

function aa.ToggleAcrylic(av,aw)
if aa.Window and aa.Window.AcrylicPaint and aa.Window.AcrylicPaint.Model th=
en
aa.Window.Acrylic=3Daw
aa.Window.AcrylicPaint.Model.Transparency=3Daw and 0.98 or 1
if aw then
aq.Enable()
else
aq.Disable()
end
end
end

function aa.Gradient(av,aw,ax)
local ay=3D{}
local az=3D{}

for aA,aB in next,aw do
local b=3Dtonumber(aA)
if b then
b=3Dmath.clamp(b/100,0,1)

local d=3DaB.Color
if typeof(d)=3D=3D"string"and string.sub(d,1,1)=3D=3D"#"then
d=3DColor3.fromHex(d)
end

local f=3DaB.Transparency or 0

table.insert(ay,ColorSequenceKeypoint.new(b,d))
table.insert(az,NumberSequenceKeypoint.new(b,f))
end
end

table.sort(ay,function(aA,aB)
return aA.Time&lt;aB.Time
end)
table.sort(az,function(aA,aB)
return aA.Time&lt;aB.Time
end)

if#ay&lt;2 then
table.insert(ay,ColorSequenceKeypoint.new(1,ay[1].Value))
table.insert(az,NumberSequenceKeypoint.new(1,az[1].Value))
end

local aA=3D{
Color=3DColorSequence.new(ay),
Transparency=3DNumberSequence.new(az),
}

if ax then
for aB,b in pairs(ax)do
aA[aB]=3Db
end
end

return aA
end

function aa.Popup(av,aw)
aw.WindUI=3Daa
return a.load't'.new(aw,aa.ScreenGui.Popups)
end

aa.Themes=3Da.load'u'(aa,ao)

ao.Themes=3Daa.Themes

aa:SetTheme"Dark"
aa:SetLanguage(ao.Language)

function aa.CreateWindow(av,aw)
local ax=3Da.load'ac'

if not ak:IsStudio()and writefile then
if not isfolder"WindUI"then
makefolder"WindUI"
end
if aw.Folder then
makefolder(aw.Folder)
else
makefolder(aw.Title)
end
end

aw.WindUI=3Daa
aw.Window=3Daa.Window
aw.Parent=3Daa.ScreenGui.Window

if aa.Window then
warn"You cannot create more than one window"
return
end

local ay=3Dtrue

local az=3Daa.Themes[aw.Theme or"Dark"]


ao.SetTheme(az)

local aA=3Dgethwid or function()
return ah.LocalPlayer.UserId
end

local aB=3DaA()

if aw.KeySystem then
ay=3Dfalse

local function loadKeysystem()
an.new(aw,aB,function(b)
ay=3Db
end)
end

local b=3D(aw.Folder or"Temp").."/"..aB..".key"

if aw.KeySystem.KeyValidator then
if aw.KeySystem.SaveKey and isfile(b)then
local d=3Dreadfile(b)
local f=3Daw.KeySystem.KeyValidator(d)

if f then
ay=3Dtrue
else
loadKeysystem()
end
else
loadKeysystem()
end
elseif not aw.KeySystem.API then
if aw.KeySystem.SaveKey and isfile(b)then
local d=3Dreadfile(b)
local f=3D(type(aw.KeySystem.Key)=3D=3D"table")and table.find(aw.KeySystem.=
Key,d)
or tostring(aw.KeySystem.Key)=3D=3Dtostring(d)

if f then
ay=3Dtrue
else
loadKeysystem()
end
else
loadKeysystem()
end
else
if isfile(b)then
local d=3Dreadfile(b)
local f=3Dfalse

for g,h in next,aw.KeySystem.API do
local j=3Daa.Services[h.Type]
if j then
local l=3D{}
for m,p in next,j.Args do
table.insert(l,h[p])
end

local m=3Dj.New(table.unpack(l))
local p=3Dm.Verify(d)
if p then
f=3Dtrue
break
end
end
end

ay=3Df
if not f then
loadKeysystem()
end
else
loadKeysystem()
end
end

repeat
task.wait()
until ay
end

local b=3Dax(aw)

aa.Transparent=3Daw.Transparent
aa.Window=3Db

if aw.Acrylic then
aq.init()
end













return b
end

return aa
