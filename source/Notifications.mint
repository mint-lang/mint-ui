/* A component to display notifications. */
global component Ui.Notifications {
  /* A variable to track the notifications which are displayed. */
  state notifications : Map(String, Tuple(Html, Number)) = Map.empty()

  /* The style for the base element. */
  style base {
    position: fixed;
    z-index: 1100;
    right: 1em;
    top: 1em;

    flex-direction: column;
    align-items: flex-end;
    display: flex;

    @media (max-width: 900px) {
      width: calc(100vw - 1em);
      left: 1em;
    }
  }

  /* Shows the given content as a notification with default duration. */
  fun notifyDefault (content : Html) : Promise(Void) {
    notify(content, 7000)
  }

  /* Shows the given content as a notification with the given duration. */
  fun notify (content : Html, duration : Number) : Promise(Void) {
    let id =
      Uid.generate()

    let notification =
      {content, duration}

    await next { notifications: Map.set(notifications, id, notification) }
    await Timer.timeout(duration + 520)

    next { notifications: Map.delete(notifications, id) }
  }

  /* Renders the notifications. */
  fun render : Html {
    <div::base>
      for (id, notification of notifications) {
        let {content, duration} =
          notification

        <Ui.Notification
          duration={duration}
          content={content}
          key={id}/>
      }
    </div>
  }
}
