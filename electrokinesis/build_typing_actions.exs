defmodule ActionsXML do
  def build do
    case_start_xml <> actions_xml <> case_end_xml
  end

  defp case_start_xml do
    """
    <array>
      <dict>
        <key>CaseEntries</key>
        <array>
    """
  end

  defp actions_xml do
    Enum.reduce(10..35, xml, fn key_code, acc ->
      acc <>
        """
        <dict>
          <key>Actions</key>
          <array>
            <dict>
              <key>KeyCode</key>
          <integer>#{key_code}</integer>
          <key>MacroActionType</key>
          <string>SimulateKeystroke</string>
          <key>Modifiers</key>
          <integer>0</integer>
          <key>ReleaseAll</key>
          <false/>
          <key>TargetApplication</key>
          <dict/>
          <key>TargetingType</key>
          <string>Front</string>
          </dict>
          </array>
          <key>ConditionType</key>
          <string>Is</string>
          <key>TestValue</key>
          <string>#{<<key_code - 10 + 97>>}</string>
        </dict>
        """
    end)
  end

  defp case_end_xml do
    """
        </array>
        <key>MacroActionType</key>
        <string>Switch</string>
        <key>Source</key>
        <string>Text</string>
        <key>Text</key>
        <string>%TriggerValue%</string>
      </dict>
    </array>
    """
  end
end

xml =
  Enum.reduce(10..35, xml, fn key_code, acc ->
    acc <>
      """
            <dict>
              <key>Actions</key>
              <array>
                <dict>
                  <key>KeyCode</key>
                  <integer>#{key_code}</integer>
                  <key>MacroActionType</key>
                  <string>SimulateKeystroke</string>
                  <key>Modifiers</key>
                  <integer>0</integer>
                  <key>ReleaseAll</key>
                  <false/>
                  <key>TargetApplication</key>
                  <dict/>
                  <key>TargetingType</key>
                  <string>Front</string>
                </dict>
              </array>
              <key>ConditionType</key>
              <string>Is</string>
              <key>TestValue</key>
              <string>#{<<key_code - 10 + 97>>}</string>
            </dict>
      """
  end)

xml =
  xml <>
    """
        </array>
        <key>MacroActionType</key>
        <string>Switch</string>
        <key>Source</key>
        <string>Text</string>
        <key>Text</key>
        <string>%TriggerValue%</string>
      </dict>
    </array>
    """

IO.puts(xml)

# <array>
# 	<dict>
# 		<key>ActionUID</key>
# 		<integer>2656</integer>
# 		<key>CaseEntries</key>
# 		<array>
# 			<dict>
# 				<key>Actions</key>
# 				<array>
# 					<dict>
# 						<key>ActionUID</key>
# 						<integer>2659</integer>
# 						<key>KeyCode</key>
# 						<integer>14</integer>
# 						<key>MacroActionType</key>
# 						<string>SimulateKeystroke</string>
# 						<key>Modifiers</key>
# 						<integer>0</integer>
# 						<key>ReleaseAll</key>
# 						<false/>
# 						<key>TargetApplication</key>
# 						<dict/>
# 						<key>TargetingType</key>
# 						<string>Front</string>
# 					</dict>
# 				</array>
# 				<key>ConditionType</key>
# 				<string>Is</string>
# 				<key>TestValue</key>
# 				<string>e</string>
# 			</dict>
# 			<dict>
# 				<key>Actions</key>
# 				<array>
# 					<dict>
# 						<key>ActionUID</key>
# 						<integer>2663</integer>
# 						<key>KeyCode</key>
# 						<integer>14</integer>
# 						<key>MacroActionType</key>
# 						<string>SimulateKeystroke</string>
# 						<key>Modifiers</key>
# 						<integer>4096</integer>
# 						<key>ReleaseAll</key>
# 						<false/>
# 						<key>TargetApplication</key>
# 						<dict/>
# 						<key>TargetingType</key>
# 						<string>Front</string>
# 					</dict>
# 				</array>
# 				<key>ConditionType</key>
# 				<string>Is</string>
# 				<key>TestValue</key>
# 				<string>control-e</string>
# 			</dict>
# 			<dict>
# 				<key>Actions</key>
# 				<array>
# 					<dict>
# 						<key>ActionUID</key>
# 						<integer>2666</integer>
# 						<key>KeyCode</key>
# 						<integer>14</integer>
# 						<key>MacroActionType</key>
# 						<string>SimulateKeystroke</string>
# 						<key>Modifiers</key>
# 						<integer>2048</integer>
# 						<key>ReleaseAll</key>
# 						<false/>
# 						<key>TargetApplication</key>
# 						<dict/>
# 						<key>TargetingType</key>
# 						<string>Front</string>
# 					</dict>
# 				</array>
# 				<key>ConditionType</key>
# 				<string>Is</string>
# 				<key>TestValue</key>
# 				<string>option-e</string>
# 			</dict>
# 			<dict>
# 				<key>Actions</key>
# 				<array>
# 					<dict>
# 						<key>ActionUID</key>
# 						<integer>2660</integer>
# 						<key>KeyCode</key>
# 						<integer>14</integer>
# 						<key>MacroActionType</key>
# 						<string>SimulateKeystroke</string>
# 						<key>Modifiers</key>
# 						<integer>512</integer>
# 						<key>ReleaseAll</key>
# 						<false/>
# 						<key>TargetApplication</key>
# 						<dict/>
# 						<key>TargetingType</key>
# 						<string>Front</string>
# 					</dict>
# 				</array>
# 				<key>ConditionType</key>
# 				<string>Is</string>
# 				<key>TestValue</key>
# 				<string>shift-e</string>
# 			</dict>
# 			<dict>
# 				<key>Actions</key>
# 				<array>
# 					<dict>
# 						<key>ActionUID</key>
# 						<integer>2669</integer>
# 						<key>KeyCode</key>
# 						<integer>14</integer>
# 						<key>MacroActionType</key>
# 						<string>SimulateKeystroke</string>
# 						<key>Modifiers</key>
# 						<integer>256</integer>
# 						<key>ReleaseAll</key>
# 						<false/>
# 						<key>TargetApplication</key>
# 						<dict/>
# 						<key>TargetingType</key>
# 						<string>Front</string>
# 					</dict>
# 				</array>
# 				<key>ConditionType</key>
# 				<string>Is</string>
# 				<key>TestValue</key>
# 				<string>command-e</string>
# 			</dict>
# 		</array>
# 		<key>MacroActionType</key>
# 		<string>Switch</string>
# 		<key>Source</key>
# 		<string>Text</string>
# 		<key>Text</key>
# 		<string>%TriggerValue%</string>
# 	</dict>
# </array>
# </plist>
