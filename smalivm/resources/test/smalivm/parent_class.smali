.class Lparent_class;
.super Lgrandparent_class;

.field public static parentField:I

# direct methods
.method public constructor <init>()V
    .locals 0

    #@0
    .prologue
    .line 3
    invoke-direct {p0}, Ljava/lang/Object;-><init>()V

    #@3
    return-void
.end method


# virtual methods
.method public someString()Ljava/lang/String;
    .locals 1

    #@0
    .prologue
    .line 6
    const-string v0, "parent"

    #@2
    return-object v0
.end method

.method public abstract abstractMethod()Ljava/lang/String;
.end method

.method public parentMethod()Ljava/lang/String;
    .locals 1

    #@0
    .prologue
    .line 6
    const-string v0, "parentMethod"

    #@2
    return-object v0
.end method
