/* A table header component. */
component Ui.Table.Header {
  /* The handler for the order change event. */
  property onOrderChange : Function(Tuple(String, String), Promise(Void)) = Promise.never1

  /* The order direction either "asc" or "desc". */
  property orderDirection : String = ""

  /* The `sortKey` of the column which the content is ordered by. */
  property orderBy : String = ""

  /* The data for the header. */
  property data : Ui.Table.Header

  /* Style for the base. */
  style base {
    if data.shrink {
      white-space: nowrap;
      width: 1%;
    } else {
      white-space: initial;
      width: initial;
    }
  }

  /* Style for a header. */
  style wrap {
    grid-template-columns: 1fr min-content;
    align-items: center;
    grid-gap: 0.5em;
    display: grid;
  }

  /* Style for the icon. */
  style icon {
    line-height: 0;

    if orderBy == data.sortKey {
      opacity: 1;
    } else {
      opacity: 0.5;
    }

    &:hover {
      color: var(--primary-s500-color);
      cursor: pointer;
      opacity: 1;
    }
  }

  /* The handler for the icon. */
  fun handleSort : Promise(Void) {
    let nextOrderDirection =
      if orderBy == data.sortKey {
        if orderDirection == "asc" {
          "desc"
        } else {
          "asc"
        }
      } else {
        "asc"
      }

    onOrderChange({data.sortKey, nextOrderDirection})
  }

  /* Renders the header. */
  fun render : Html {
    <th::base>
      <div::wrap>
        <span>
          data.label
        </span>

        if data.sortable {
          <div::icon onClick={handleSort}>
            if orderBy == data.sortKey {
              if orderDirection == "desc" {
                <Ui.Icon icon={Ui.Icons.TRIANGLE_DOWN}/>
              } else {
                <Ui.Icon icon={Ui.Icons.TRIANGLE_UP}/>
              }
            } else {
              <Ui.Icon icon={Ui.Icons.TRIANGLE_UP_DOWN}/>
            }
          </div>
        }
      </div>
    </th>
  }
}
