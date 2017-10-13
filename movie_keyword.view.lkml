view: movie_keyword {
  derived_table: {
    persist_for: "100 hours"
    indexes: ["movie_id"]
    sql: SELECT
        movie_id
        , keyword
        , ROW_NUMBER() OVER (order by movie_id) as id
      FROM movie_keyword AS mk
      JOIN keyword AS k ON mk.keyword_id = k.id
       ;;
  }

  dimension: id {
    primary_key: yes
    hidden: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: keyword {}

  dimension: movie_id {
    type: number
    hidden: yes
    sql: ${TABLE}.movie_id ;;
  }

  measure: keyword_count {
    type: count_distinct
    drill_fields: [id, keyword, title.count]
  }
}
