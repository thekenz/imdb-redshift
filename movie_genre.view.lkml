view: movie_genre {
  derived_table: {
    persist_for: "100 hours"
    indexes: ["movie_id"]
    sql: SELECT
        movie_id
        , info AS genre
      FROM movie_info
      WHERE info_type_id = 3
       ;;
  }

  dimension: movie_id {
    hidden: yes
  }

  dimension: genre {}
}

#   - measure: genre_list
#     type: list
#     list_field: genre
