You'll probably need to change the paths under these elements before importing:

```
  <Triggers>
    <EventTrigger>
      <Enabled>true</Enabled>
      <Subscription>
          ... and (Data='CHANGE THIS PATH')]]
      </Subscription>
    </EventTrigger>
  </Triggers>
```
```
  <Actions Context="Author">
    <Exec>
      <Command>"CHANGE THIS PATH"</Command>
    </Exec>
  </Actions>
```
To import, open task scheduler and select Import Task on the right side.
