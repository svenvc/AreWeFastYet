as yet unclassified
isInVoxel: voxel motion: motion

    | init fin v_s r v_x x0 xv v_y y0 yv low_x high_x low_y high_y |
    (voxel x > Constants MaxX or: [
     voxel x < Constants MinX or: [
     voxel y > Constants MaxY or: [
     voxel y < Constants MinY ]]]) ifTrue: [ ^ false ].

    init := motion posOne.
    fin  := motion posTwo.

    v_s := Constants GoodVoxelSize.
    r   := Constants ProximityRadius / 2.0.

    v_x := voxel x.
    x0  := init x.
    xv  := fin x - init x.

    v_y := voxel y.
    y0  := init y.
    yv  := fin y - init y.

    xv = 0.0 "follow IEEE floating point semantics"
      ifTrue:  [
        low_x  := Float infinity.
        high_x := Float infinity ]
      ifFalse: [
        low_x := (v_x - r - x0) / xv.
        high_x := (v_x + v_s + r - x0) / xv ].

    xv < 0.0 ifTrue: [
      | tmp |
      tmp    := low_x.
      low_x  := high_x.
      high_x := tmp ].

    yv = 0.0 "follow IEEE floating point semantics"
      ifTrue: [
        low_y  := Float infinity.
        high_y := Float infinity ]
      ifFalse: [
        low_y  := (v_y - r - y0) / yv.
        high_y := (v_y + v_s + r - y0) / yv ].

    yv < 0.0 ifTrue: [
      | tmp |
      tmp    := low_y.
      low_y  := high_y.
      high_y := tmp ].

    ^ (((xv = 0.0 and: [v_x <= (x0 + r) and: [(x0 - r) <= (v_x + v_s)]]) or: [ "no motion in x"
        (low_x <= 1.0 and: [1.0 <= high_x]) or: [
        (low_x <= 0.0 and: [0.0 <= high_x]) or: [
        (0.0 <= low_x and: [high_x <= 1.0])]]]) and: [
          
        (yv = 0.0 and: [v_y <= (y0 + r) and: [(y0 - r) <= (v_y + v_s)]]) or: [ "no motion in y"
          (low_y <= 1.0 and: [1.0 <= high_y]) or: [
          (low_y <= 0.0 and: [0.0 <= high_y]) or: [
          (0.0   <= low_y and: [high_y <= 1.0])]]]]) and: [

         xv = 0.0 or: [
         yv = 0.0 or: [ "no motion in x or y or both"
         (low_y <= high_x and: [high_x <= high_y]) or: [
         (low_y <= low_x  and: [low_x <= high_y]) or: [
         (low_x <= low_y  and: [high_y <= high_x]) ]]]]]
