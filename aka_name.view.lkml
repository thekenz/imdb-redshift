view: aka_name {
  dimension: id {
    primary_key: yes
    type: number
    sql: ${TABLE}.id ;;
  }

  dimension: imdb_index {
    sql: ${TABLE}.imdb_index ;;
  }

  dimension: md5sum {
    sql: ${TABLE}.md5sum ;;
  }

  dimension: name {
    sql: ${TABLE}.name ;;
  }

  dimension: name_pcode_cf {
    sql: ${TABLE}.name_pcode_cf ;;
  }

  dimension: name_pcode_nf {
    sql: ${TABLE}.name_pcode_nf ;;
  }

  dimension: person_id {
    type: number
    sql: ${TABLE}.person_id ;;
  }

  dimension: surname_pcode {
    sql: ${TABLE}.surname_pcode ;;
  }

  measure: count {
    type: count
    drill_fields: [id, name]
  }
}
