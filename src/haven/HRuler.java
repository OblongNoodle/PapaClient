package haven;

import java.awt.Color;

public class HRuler extends Widget {
    public static final Color defcol = new Color(192, 192, 192, 128);
    public final Coord marg;
    public final Color color;

    public HRuler(int w, Coord marg, Color color) {
        super(Coord.of(w, (marg.y * 2) + 1));
        this.marg = marg;
        this.color = color;
    }

    public HRuler(int w, Coord marg) {
        this(w, marg, defcol);
    }

    private static Coord defmarg(int w) {
        return (Coord.of(w / 10, UI.scale(2)));
    }

    public HRuler(int w, Color color) {
        this(w, defmarg(w), color);
    }

    public HRuler(int w) {
        this(w, defmarg(w));
    }

    @RName("hr")
    public static class $_ implements Factory {
        @Override
        public Widget create(UI ui, Object[] args) {
            int w = UI.scale(Utils.iv(args[0]));
            Color col = defcol;
            if (args.length > 1)
                col = (Color) args[1];
            return (new HRuler(w, col));
        }
    }

    @Override
    public void draw(GOut g) {
        g.chcolor(color);
        g.line(marg, Coord.of(sz.x - 1 - marg.x, marg.y), 1);
    }
}
