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
      width: cacl(100vw - 1em);
      left: 1em;
    }
  }

  /* Shows the given content as a notification with default duration. */
  fun notifyDefault (content : Html) : Promise(Never, Void) {
    notify(content, 7000)
  }

  /* Shows the given content as a notification with the given duration. */
  fun notify (content : Html, duration : Number) : Promise(Never, Void) {
    sequence {
      id =
        Uid.generate()

      notification =
        {content, duration}

      next { notifications = Map.set(id, notification, notifications) }

      Timer.timeout(duration + 520, "")

      next { notifications = Map.delete(id, notifications) }
    }
  }

  /* Renders the notifications. */
  fun render : Html {
    <div::base>
      for (id, notification of notifications) {
        try {
          {content, duration} =
            notification

          <Ui.Notification
            duration={duration}
            content={content}
            key={id}/>
        }
      }
    </div>
  }
}
