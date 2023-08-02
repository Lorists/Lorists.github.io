---
team:
  file: team.csv
  fields:
    name: true
    slogan:
      type: textarea
    preferred_race:
      type: ref
      csv: race
      property: name
    color_1:
      type: color
    color_2:
      type: color
race:
  file: race.csv
  fields:
    name: true
    image: true
player:
  file: players.csv
  fields:
    name: true
    born:
      type: number
    race:
      type: ref
      csv: race
      property: name
    ma:
      type: number
    st:
      type: number
    ag:
      type: number
    skills:
      type: select
      multiple: true
      default: [Block, Catch, Dodge, Pass, Sure Hands]
    stars:
      type: number
---
{% include widgets/form.html form=page.team %}
{% include widgets/table.html file=team.csv %}
{% include widgets/form.html form=page.race class="admin unforked" %}
{% include widgets/table.html file=race.csv %}
