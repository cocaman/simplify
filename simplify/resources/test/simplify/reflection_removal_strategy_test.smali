.class Lreflection_removal_strategy_test;
.super Ljava/lang/Object;

.field private someInt:I
.field private someInt:I
.field private static someStaticObject:Ljava/lang/Object;

.method public static MethodInvokeWith3LocalsAnd0Available()V
  .locals 3

  nop # hack, need a parent op
  invoke-virtual {v0, v1, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
  invoke-static {v0, v1, v2}, Li_need/these/registers;->mine(Ljava/lang/Object;Ljava/lang/Object;Ljava/lang/Object;)V

  return-void
.end method

.method public static MethodInvokeWith10LocalsAnd7ContiguousAvailable()V
  .locals 10

  nop # hack, need a parent op
  # v2 is not available because it's needed for array element lookups
  # contiguous available: v3, v4, v5, v6, v7, v8
  invoke-virtual {v0, v1, v2}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
  move-result-object v0

  return-void
.end method

.method public static MethodInvokeForKnownMethodAndTargetAndParameters()Ljava/lang/String;
  .locals 5

  # Build parameter values
  const/4 v0, 0x1
  new-array v0, v0, [Ljava/lang/Object;
  const/4 v1, 0x0
  const-string v2, "hello,world!"
  aput-object v2, v0, v1 # Object[] v0[v1] = "hello,world!"

  # Build parameter types
  const/4 v3, 0x1
  new-array v3, v3, [Ljava/lang/Class;
  const-class v4, Ljava/lang/String;
  aput-object v4, v3, v1 # Class[] v3[v1] = java.lang.String.class

  # Get method
  const-class v4, Ljava/lang/StringBuilder;
  const-string v2, "append"
  invoke-virtual {v4, v2, v3}, Ljava/lang/Class;->getMethod(Ljava/lang/String;[Ljava/lang/Class;)Ljava/lang/reflect/Method;
  move-result-object v3

  # StringBuilder v4 = new StringBuilder();
  new-instance v4, Ljava/lang/StringBuilder;
  invoke-direct {v4}, Ljava/lang/StringBuilder;-><init>()V

  # v3 = v4.append("hello,world!")
  # v3 = method, v4 = target, v0 = parameters
  invoke-virtual {v3, v4, v0}, Ljava/lang/reflect/Method;->invoke(Ljava/lang/Object;[Ljava/lang/Object;)Ljava/lang/Object;
  move-result-object v3

  check-cast v3, Ljava/lang/StringBuilder;
  invoke-virtual {v3}, Ljava/lang/StringBuilder;->toString()Ljava/lang/String;
  move-result-object v3

  return-object v3
.end method

.method public static FieldLookupWithMoveResult()V
  .locals 3

  invoke-virtual {v0, v1}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;
  move-result-object v0

  invoke-virtual {v0, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;
  move-result-object v0

  return-void
.end method

.method public static FieldLookupWithoutMoveResultWithOneAvailableRegister()V
  .locals 3

  invoke-virtual {v0, v1}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;
  move-result-object v0

  invoke-virtual {v0, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

  invoke-static {v0, v1}, Llolmoney/moneylol;->lol(II)V

  return-void
.end method

.method public static FieldLookupWithoutMoveResultWithNoAvailableRegisters()V
  .locals 3

  invoke-virtual {v0, v1}, Ljava/lang/Class;->getField(Ljava/lang/String;)Ljava/lang/reflect/Field;
  move-result-object v0

  invoke-virtual {v0, v2}, Ljava/lang/reflect/Field;->get(Ljava/lang/Object;)Ljava/lang/Object;

  invoke-static {v0, v1, v2}, Llolmoney/moneylol;->lol(III)V

  return-void
.end method

.method public SixParameterMethod(IIIIII)V
  .locals 0

  return-void
.end method

.method private PrivateVirtualMethod()V
  .locals 0

  return-void
.end method

.method private static FourParameterMethod(IIII)V
  .locals 0

  return-void
.end method
