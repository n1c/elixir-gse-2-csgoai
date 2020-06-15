defmodule Gsi2csgoai.Transcoder do
  def gsi2csgoai(json) do
    %{
      map: json["map"]["name"],
      current_score: [
        json["map"]["team_ct"]["score"],
        json["map"]["team_t"]["score"]
      ],
      round_status: json["phase_countdowns"]["phase"],
      round_status_time_left: json["phase_countdowns"]["phase_ends_in"],
      alive_players: parse_alive_players(json["allplayers"]),
      # @TODO
      # "active_smokes": [],
      # "active_molotovs": [],
      # "previous_kills": [],
      # "round_winner": "CT",
      # "planted_bomb": null
    }
  end

  defp parse_alive_players(players) do
    Enum.map(players, fn {_, player} ->
      %{
        health: player["state"]["health"],
        armor: player["state"]["armor"],
        has_helmet: player["state"]["helmet"],
        # @TODO: has_defuser: boolean,
        money: player["state"]["money"],
        team: player["team"],
        position_history: [
          str2vec(player["position"]),
        ],
        inventory: [
          weapons2inventory(player["weapons"]),
        ],
      }
    end)
  end

  defp str2vec(str) do
    points = Enum.map(String.split(str, ","), fn s -> String.trim(s) end)

    %{
      x: Enum.at(points, 0),
      y: Enum.at(points, 1),
      z: Enum.at(points, 2),
    }
  end

  defp weapons2inventory(weapons) do
    # originally thought it was only active weapons
    # active = Enum.filter(weapons, fn {_, w} -> w["state"] == "active" end)
    # |> Enum.at(0)

    # @TODO: just hard assuming here that the names match
    # csgoai seem to filter out knives?

    Enum.map(weapons, fn {_, weapon} ->
      %{
        item_type: weapon["name"],
        clip_ammo: weapon["ammo_clip"],
        reserve_ammo: weapon["ammo_reserve"],
      }
    end)
  end
end
