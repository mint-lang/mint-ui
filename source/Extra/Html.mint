module Html {
  fun flatten (children : Array(Html)) : Array(Html) {
    `
    (() => {
      if (#{children} == null || typeof #{children} == 'boolean') {
        return []
      } else if (Array.isArray(#{children})) {
        return #{children}.reduce((memo, child) => {
          return memo.concat(#{flatten(`child`)})
        }, [])
      } else {
        return [#{children}]
      }
    })()
    `
  }
}
