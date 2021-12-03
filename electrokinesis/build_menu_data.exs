Mix.install([:jason])

# Keyboard:
# E   A   I   N   U   G
# R   O   S   D   B   V
# T   L   P   F   X   esc
# C   M   Y   Z   tab fk
# H   W   J   ret har sym
# K   Q   spc nav num pop
#
# Key:
# e      E      _      _      _      _      _
# c-e    o-e    a-e    co-e   cs-e   ca-e   os-e
# oa-e   sa-e   cos-e  coa-e  csa-e  osa-e  cosa-e
# _      _      _      _      _      _      _
# _      _      _      _      _      _      _
# _      _      _      _      _      _      _
# _      _      _      _      _      _      _
#
# Symbols:
# Leading:  ( "
# Trailing:  ! @ % ) - — : ; " ' ret , . … ? spc
# Neutral:  ` ~ # $ ^ & * _ + = [ { ] }  \ | ' < > /
#
# Counts:
# Letters: 26
# Numbers: 10
# Symbols: 32
# Navigation: 17
# F-keys: 20
# Hardware: 20

keyboard = [
  ["E", "A", "I", "N", "U", "G"],
  ["R", "O", "S", "D", "B", "V"],
  ["T", "L", "P", "F", "X", {"␛", "Escape"}],
  ["C", "M", "Y", "Z", {"⇥", "Tab"}, "Fks"],
  ["H", "W", "J", {"↩", "Return"}, "Key", "Sym"],
  ["K", "Q", {"⎵", "Space"}, "Nav", "Num", {"↶", :back}]
]

menus = %{
  Top: %{
    buttons: [
      %{
        name: "Keyboard",
        action: "PushMenu",
        menu: "Keyboard"
      }
    ],
    buttonSize: "Medium"
  },
  Keyboard: %{
    buttons:
      Enum.map(keyboard, fn row ->
        Enum.map(row, fn button ->
          case button do
            {glyph, :back} ->
              %{
                name: glyph,
                action: "PopMenu"
              }

            {glyph, to} ->
              %{
                name: glyph,
                action: "PushMenu",
                menu: "Keyboard::#{to}"
              }

            name ->
              %{
                name: name,
                action: "PushMenu",
                menu: "Keyboard::#{name}"
              }
          end
        end)
      end),
    buttonSize: "Small"
  }
}

menus =
  keyboard
  |> List.flatten()
  |> Enum.reduce(menus, fn
    letter, menus when is_binary(letter) and byte_size(letter) == 1 ->
      menus

    _button, menus ->
      menus
  end)

osascript = System.find_executable("osascript")

port =
  Port.open(
    {:spawn_executable, osascript},
    [:binary, args: ["-l", "JavaScript"]]
  )

true =
  Port.command(
    port,
    """
    var kme = Application("Keyboard Maestro Engine");
    kme.setvariable(
      "ElectrokinesisMenus",
      {to: JSON.stringify(#{Jason.encode!(menus)})}
    );
    """
  )

true = Port.close(port)
