You'll probably need to change the paths under these elements before importing:

  <Triggers>
    <EventTrigger>
      <Enabled>true</Enabled>
      <Subscription>&lt;QueryList&gt;&lt;Query Id="0" Path="Security"&gt;&lt;Select Path="Security"&gt;
*[System[Provider[@Name='Microsoft-Windows-Security-Auditing'] and Task = 13312 and (band(Keywords,9007199254740992)) and (EventID=4688)]]
and 
*[EventData[Data[@Name='NewProcessName'] and (Data='CHANGE THIS PATH')]]
    &lt;/Select&gt;&lt;/Query&gt;&lt;/QueryList&gt;</Subscription>
    </EventTrigger>
  </Triggers>

  <Actions Context="Author">
    <Exec>
      <Command>"CHANGE THIS PATH"</Command>
    </Exec>
  </Actions>

To import, open task scheduler and select Import Task on the right side.