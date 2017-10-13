view: movie_language {
  derived_table: {
    persist_for: "100 hours"
    indexes: ["movie_id"]
    sql: SELECT
        movie_id
        , movie_info.info AS language
      FROM movie_info
      WHERE movie_info.info_type_id = 4
       ;;
  }

  measure: language_count {
    type: count
  }

  dimension: movie_id {
    hidden: yes
  }

  dimension: language {}
}
