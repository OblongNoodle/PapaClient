package haven.res.gfx.hud.rosters.goat;

import haven.Resource;
import haven.UI;
import haven.res.ui.croster.CattleRoster;
import haven.res.ui.croster.Column;
import haven.res.ui.croster.Entry;
import haven.res.ui.croster.TypeButton;
import java.util.Comparator;
import java.util.List;

public class GoatRoster extends CattleRoster<Goat> {
    public static List<Column> cols = initcols(
            new Column<>("Name", Comparator.comparing((Entry e) -> e.name), 200),

            new Column<>(Resource.local().load("gfx/hud/rosters/sex"), Comparator.comparing((Goat e) -> e.billy).reversed(), 20).runon(),
            new Column<>(Resource.local().load("gfx/hud/rosters/growth"), Comparator.comparing((Goat e) -> e.kid).reversed(), 20).runon(),
            new Column<>(Resource.local().load("gfx/hud/rosters/deadp"), Comparator.comparing((Goat e) -> e.dead).reversed(), 20).runon(),
            new Column<>(Resource.local().load("gfx/hud/rosters/pregnant"), Comparator.comparing((Goat e) -> e.pregnant).reversed(), 20).runon(),
            new Column<>(Resource.local().load("gfx/hud/rosters/lactate"), Comparator.comparing((Goat e) -> e.lactate).reversed(), 20).runon(),
            new Column<>(Resource.local().load("gfx/hud/rosters/owned"), Comparator.comparing((Goat e) -> ((e.owned ? 1 : 0) | (e.mine ? 2 : 0))).reversed(), 20),


            new Column<>(Resource.local().load("gfx/hud/rosters/quality"), Comparator.comparing((Goat e) -> e.q).reversed()),

            new Column<>(Resource.local().load("gfx/hud/rosters/meatquantity"), Comparator.comparing((Goat e) -> e.meat).reversed()),
            new Column<>(Resource.local().load("gfx/hud/rosters/milkquantity"), Comparator.comparing((Goat e) -> e.milk).reversed()),
            new Column<>(Resource.local().load("gfx/hud/rosters/woolquantity"), Comparator.comparing((Goat e) -> e.wool).reversed()),

            new Column<>(Resource.local().load("gfx/hud/rosters/meatquality"), Comparator.comparing((Goat e) -> e.meatq).reversed()),
            new Column<>(Resource.local().load("gfx/hud/rosters/meatquality"), Comparator.comparing((Goat e) -> e.tmeatq).reversed()),

            new Column<>(Resource.local().load("gfx/hud/rosters/milkquality"), Comparator.comparing((Goat e) -> e.milkq).reversed()),
            new Column<>(Resource.local().load("gfx/hud/rosters/milkquality"), Comparator.comparing((Goat e) -> e.tmilkq).reversed()),

            new Column<>(Resource.local().load("gfx/hud/rosters/woolquality"), Comparator.comparing((Goat e) -> e.woolq).reversed()),
            new Column<>(Resource.local().load("gfx/hud/rosters/woolquality"), Comparator.comparing((Goat e) -> e.twoolq).reversed()),

            new Column<>(Resource.local().load("gfx/hud/rosters/hidequality"), Comparator.comparing((Goat e) -> e.hideq).reversed()),
            new Column<>(Resource.local().load("gfx/hud/rosters/hidequality"), Comparator.comparing((Goat e) -> e.thideq).reversed()),

            new Column<>(Resource.local().load("gfx/hud/rosters/breedingquality"), Comparator.comparing((Goat e) -> e.seedq).reversed())
    );

    protected List<Column> cols() {
        return (cols);
    }

    public static CattleRoster mkwidget(UI ui, Object... args) {
        return (new GoatRoster());
    }

    public Goat parse(Object... args) {
        int n = 0;
        long id = ((Number) args[n++]).longValue();
        String name = (String) args[n++];
        Goat ret = new Goat(id, name);
        ret.grp = (Integer) args[n++];
        int fl = (Integer) args[n++];
        ret.billy = (fl & 1) != 0;
        ret.kid = (fl & 2) != 0;
        ret.dead = (fl & 4) != 0;
        ret.pregnant = (fl & 8) != 0;
        ret.lactate = (fl & 16) != 0;
        ret.owned = (fl & 32) != 0;
        ret.mine = (fl & 64) != 0;
        ret.q = ((Number) args[n++]).doubleValue();
        ret.meat = (Integer) args[n++];
        ret.milk = (Integer) args[n++];
        ret.wool = (Integer) args[n++];
        ret.meatq = (Integer) args[n++];
        ret.milkq = (Integer) args[n++];
        ret.woolq = (Integer) args[n++];
        ret.hideq = (Integer) args[n++];
        ret.tmeatq = ret.meatq * ret.q / 100;
        ret.tmilkq = ret.milkq * ret.q / 100;
        ret.twoolq = ret.woolq * ret.q / 100;
        ret.thideq = ret.hideq * ret.q / 100;
        ret.seedq = (Integer) args[n++];
        return (ret);
    }

    public TypeButton button() {
        return (typebtn(Resource.local().load("gfx/hud/rosters/btn-goat"),
                Resource.local().load("gfx/hud/rosters/btn-goat-d")));
    }
}
