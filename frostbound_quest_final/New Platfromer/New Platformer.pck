GDPC                0                                                                      &   T   res://.godot/exported/133200997/export-114308d02b75537e640a04e378442042-level_00.scnP�      �      z��K���Z�^��߾    T   res://.godot/exported/133200997/export-26e24d1e90269def944321d57dab8ad8-actor.scn               h�������b��    P   res://.godot/exported/133200997/export-4d35b6806538f9d7f1eabac087f24885-door.scnp3     Q      ��jt��Y#@.�l $    X   res://.godot/exported/133200997/export-91b05a10019765108193bb2afad7b3d9-base_level.scn  @<      �      V_|Zŉ�w�`;
e�    P   res://.godot/exported/133200997/export-95f0d95b3a03d7f40146d4fc05617007-coin.scn�     3      �;�m!�oo}�c    T   res://.godot/exported/133200997/export-a970615d582ebd1bf0e5b7e66283dc1a-level_02.scn��      �      N ny�w�>�#����0    T   res://.godot/exported/133200997/export-c4c54ecad530fec2f43d88be46836b98-level_01.scn �      t'      (j���Da<}�U���    T   res://.godot/exported/133200997/export-c9ee0d8e46a01f657f98a2c67970a9a1-object.scn  �8     �      �F"�*%�e0;�TXJ    T   res://.godot/exported/133200997/export-d7a2ad92a25ae9bae9307a8ee3f82bda-spike.scn   @<     S      T���{Psp_�    T   res://.godot/exported/133200997/export-e86f95e5088e93066d258d9192ab0748-player.scn  0	      �      6��>5�5K����2'    ,   res://.godot/global_script_class_cache.cfg  �S     �       B*ȉ�U�	\��l�qD    D   res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex�A           ：Qt�E�cO���    \   res://.godot/imported/tilemap-backgrounds_packed.png-298c677e284cb5b7dddc2f74ad26daa2.ctex  0      �      �G�6��+m�0�"    \   res://.godot/imported/tilemap-characters_packed.png-fff178445ce04c8ba8bf95566ac0088f.ctex   �      �      Df�w��?�}�$3qk    P   res://.godot/imported/tilemap_packed.png-da35b29d46cb5a65ce166244b08e5449.ctex  �"      >      bM|m>[�yUJ�i�       res://.godot/uid_cache.bin  PX     �      �!J("p�ri1$�K�p       res://actors/actor.gd                 'j��a�E�S�'�        res://actors/actor.tscn.remap   �O     b       �|��P���%!��7       res://actors/player.gd               ������Y�|���        res://actors/player.tscn.remap   P     c       ���uuS�6U�Q��    T   res://common/kenney_pixel-platformer/tilemaps/tilemap-backgrounds_packed.png.import       �       �I�9Kg�:�՛�    T   res://common/kenney_pixel-platformer/tilemaps/tilemap-characters_packed.png.import  �!      �       Ǘ�Hȍ����    H   res://common/kenney_pixel-platformer/tilemaps/tilemap_packed.png.import �:      �       ψ�Ab��9�!飾�\�       res://icon.svg  �T     �      k����X3Y���f       res://icon.svg.import   �N     �       ��]j��#'��Ip�P       res://levels/base_level.gd  �;      |       6%�5sX^�3�-A�    $   res://levels/base_level.tscn.remap  pP     g       �_�C�*'���ҿ��'        res://levels/level_00.tscn.remap�P     e       ݖW b>�OI�����        res://levels/level_01.tscn.remapPQ     e       ��7s����}Wf�w��V        res://levels/level_02.tscn.remap�Q     e       �xf&�m�<��E�       res://objects/coin.gd   @     g       ����#�_���bTB        res://objects/coin.tscn.remap   0R     a       ����f�L.�FE�y>       res://objects/door.gd   �2     {       &Ʉ~���R�pO���>        res://objects/door.tscn.remap   �R     a       ꋿ2;}7��P1���        res://objects/object.tscn.remap S     c       �u@g��(D�ӡ��9�       res://objects/spike.gd  �;     g       �����t;�ңkXj�        res://objects/spike.tscn.remap  �S     b       V��Q-I��F0_Xc       res://project.binary�Z           /��u�9w���>C�    class_name Actor
extends CharacterBody2D
 
 
@export var max_speed: float
@export var jump_velocity: float
 
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity: int = ProjectSettings.get_setting("physics/2d/default_gravity")
 
 
   RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name 	   _bundled    script       Script    res://actors/actor.gd ��������      local://PackedScene_nsj8b          PackedScene          	         names "         Actor    script    CharacterBody2D 	   Sprite2D    CollisionShape2D    AnimationPlayer    	   variants                       node_count             nodes        ��������       ����                            ����                      ����                      ����              conn_count              conns               node_paths              editable_instances              version             RSRC             extends Actor
 
@export var acceleration: float
@export var ground_friction: float
@export var air_friction: float
 
var can_double_jump := true
 
 
func _physics_process(delta: float) -> void:
	# Status
	if not is_on_floor():
		velocity.y += gravity * delta
	else:
		can_double_jump = true
 
	# Handle Jump.
	if Input.is_action_just_pressed("jump"):
		
		# Ground jump
		if is_on_floor():
			velocity.y = -abs(jump_velocity)
		else:
			if can_double_jump:
				velocity.y = -abs(jump_velocity)
				can_double_jump = false
 
	# Jump cancel
	if Input.is_action_just_released("jump") and not is_on_floor() and velocity.y < 0:
		velocity.y *= 0.25
 
	# Input direction
	var direction := Input.get_axis("left", "right")
	if direction:
		velocity.x = lerp(velocity.x, direction * max_speed, acceleration)
		if direction > 0:
			$Sprite2D.flip_h = true
		elif direction < 0:
			$Sprite2D.flip_h = false
	else:
		if is_on_floor():
			velocity.x = lerp(velocity.x, 0.0, ground_friction)
		else:
			velocity.x = lerp(velocity.x, 0.0, air_friction)
 
	# Animation
	if is_on_floor():
		if direction:
			$AnimationPlayer.play("walk")
		else:
			$AnimationPlayer.play("idle")
	else:
		$AnimationPlayer.play("aerial")
 
	move_and_slide()
 
 
func die() -> void:
	get_tree().reload_current_scene()
              RSRC                    PackedScene            ��������                                               	   Sprite2D    frame    resource_local_to_scene    resource_name    custom_solver_bias    size    script    length 
   loop_mode    step    tracks/0/type    tracks/0/imported    tracks/0/enabled    tracks/0/path    tracks/0/interp    tracks/0/loop_wrap    tracks/0/keys    _data 	   _bundled       PackedScene    res://actors/actor.tscn ����b:   Script    res://actors/player.gd ��������
   Texture2D L   res://common/kenney_pixel-platformer/tilemaps/tilemap-characters_packed.png f��YJB.i      local://RectangleShape2D_ytylj }         local://Animation_1aof2 �         local://Animation_511nw �         local://Animation_dejmn �         local://Animation_2bbb3 �         local://AnimationLibrary_mj7op �         local://PackedScene_ghsik s         RectangleShape2D       
     �A  �A      
   Animation 	         o�:
         value                                                                    times !                transitions !        �?      values                   update             
   Animation 
            aerial       ���=
         value                                                                    times !                transitions !        �?      values                   update             
   Animation 
            idle       ���=
         value                                                                    times !                transitions !        �?      values                   update             
   Animation             walk       ���>         
         value                                                                    times !          ��L>      transitions !        �?  �?      values                         update                AnimationLibrary                   RESET                aerial                idle                walk                   PackedScene          
         names "         Player    collision_layer    collision_mask    script    acceleration    ground_friction    air_friction 	   Camera2D    limit_left 
   limit_top    limit_right    limit_bottom    position_smoothing_enabled 	   Sprite2D 	   position    texture    flip_h    hframes    vframes    frame    CollisionShape2D    shape    AnimationPlayer 
   libraries    	   variants                                           �?                 �     D        
         @�            	         
         �                                      node_count             nodes     K   �����������    ����                                                        ����         	      
               	               ���  ����      
            	                                 ���  ����                           ���  ����                   conn_count              conns               node_paths              editable_instances              base_scene              version             RSRC             GST2   �   H      ����               � H        �  RIFF�  WEBPVP8L�  /�� G�$ &�I��+W�H $���@���Ф� H� �C	jp�/�?�����
��ę��ڞl�7�6ଂ6�
�@h�j˞͉?=�gඑ�t�2�8,�5�c8Rإ��ý���p.'�w@��q�V�(���4����8���8J�#�tX�pm7�ޮ�ñ��s9�;����8ܵ��w8k����S�y
}6y��F*_>f~��E��w�i[s�BCe�@��+���at=�߽@�B���XF��P��J�Y[
�<0D�Yo�w���[��_G`�3A����j�8�G&r
�d"|��u�!'s���q��	a�A4yr<�� �s���"}"̦.s`�j 6�׭3
b���=?�l�-��H8��       [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://ip6l8auexdjv"
path="res://.godot/imported/tilemap-backgrounds_packed.png-298c677e284cb5b7dddc2f74ad26daa2.ctex"
metadata={
"vram_texture": false
}
           GST2   �   H      ����               � H        �  RIFF�  WEBPVP8L�  /���6�l5Z1��L1(�_2���cN�im�jt��c��&*�q*`;�j�V���_�Ѐ�$!���>�?Z ����I�T\~��V��"�6+�i/]��p��a�I� �<+ Q�vs��� �iXrU �࢑�1IRY<>��G3Q� �Y1Q� �f�Vp�ZC�{��P�8��$�n���6� �C9 �H]������k����J���(ɶMg�)I�q��/<Of�yy�z)���)��mj��������L"� ���G�<KR�5A����{�E�g��ڮ'�#b's]S�)��鹗��=�k���]�:+s]P�$��u�Q�P��9�LS�����u���&8ɴ>qo�g"�'�Mp�i}����fEf$������BQo./)�ެ�OJ+���:?(�P�������7��
�����{x�:�Pܛ懈�xxs�CiD����zs�DiD����vR �����	Pk��7��d������^���V���	x�O� ��g�u@��:0��o�܃Z����^`�V ��A3#3��6i��&�ԃIϟ������mܘ��n�c�d��?���4��r��欷ih���7�Sz6�|��v�����Mf����7�'?��3����?��3���I��SO��=WX��!�[�so�[�g�[�g�[��vg�
�������N���o���&��I����=Ϻ�G�U�\�lW|*ER�nnN��(�O������a����j�?��no�篟(_���۰7bY���{��u]#�����M�m���&�M�o��áa!�Z!kB��)����a!_[!k�޼?�,ئa![!kb�A��	���m7��@o&��+<�{
��L�ׯxh��)z3a?�y�m�ǰ=	m�<��ՠ
��yLA�VC7(m�<��g���6pSг����V/�<�����,�`�¾�W�m0��/���>��8k�M���s�I�_5H݋6�#��,l��g� ���#w�^)!o��y��Xr�S�S2Dv����K��$B�*���u �h."����}Jh�H�����B��D���v��L(ڴŖx��č��xzSEޞc�'(��p�D�8�]a^�z������.�)��l�x&|������{L��7�o��N�x�B�~и��:K�ۻw�H�{��@�7�o"�+s��>EL!� }��7�����H��=\���Js��O��;~�,�]��@T�qE�O��N@=�7�b]m<��}�͈xsx��V�z��-����Mq��x���Fu�6i�8�o�P�ta��g�� ��F�$�Q�ט7o�P���1� �J����JH��z5mL�Ơ����ao��X��[fm���)��}"޲$n@�[�s���C��CB[�*�}6#Q4�-�����jt�.�;�G-�� �s�d.ρN)��j!�h��7b��Ȓ&捸��\�Q�/��;[{~?�Y�,��7�FG��7 �����4�#��& .�f�Ŀ߹}<؍�٢�CE��	�����,���M�x���yLA�V�l��hb*R�x�6F�(�B�_)w����r�B�舽�}�@��ǳ��tx�)�>�BJ�H��#�ç��`�RR��w��j0[P��$�Y�/�~��|�����b�/#�+Ly0ĽY*��?US��\�3+Cԛ����?��@����C�_PGy��aQ1���"5�:���o$�Q��'@%��2P�>0US��F%�uB�0�#z�
Y�\��\�y�B��qZ!�3��izT�F���u����7�52IƛW����BZ�*z��+�2ZϜ7��k�eG�����J�����K�V�V�V��:\��l休$z��ZS�3�F��0.bx�Cg��䵲7��qeV{^��<`zr�����n����O��xz}j�5�Q�`U��|oyR���r�����Y�*��闔:�"s�Я��̡����9벊,z���{0�v�0��cZg>�.�Ӌ�*�~��H*\�:y�g;�k�AZ<*Dw�x������mY��,��X��72�ؿ�֧������۲�D�F�J�����3�RC���e92}b�[[Τ	H�zی�q�{D�a Y���dH�B���%ԧ5	�Op�5`�d��JG��Kڸ���Y��7�P��Z         [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://df8me58ybr0qk"
path="res://.godot/imported/tilemap-characters_packed.png-fff178445ce04c8ba8bf95566ac0088f.ctex"
metadata={
"vram_texture": false
}
           GST2   h  �      ����               h�          RIFF�  WEBPVP8L�  /gA(_�6�m%�[?FB��
b2w��i�im�M^
��Fq#�0�IP�x���]G��D�;�.!��J0$�	��+ (�� ���}������p������Г��˷Ā�y�@es ��
�&`/�!��x5. ���^h@~���L���qޮm��F�6��Ul�y6��+-W�2��`�q�'N�5�1��%I
b�|��^��P��Z��-E�WW{D�&׊�6���}I���ƺ7�H������r�p���H��χї���l�:���2A&Y��U�:R8�𳣿�q�5E�?��{k��Kd׌�$d�H�ŬA���!w\�q/���A'�(�D�.�:�	��l���y]������/r����3���B�t�-k������5LN�b��h�L��["���,9ą������: e����Y�lOO��I�A:�xP4���6�S� �r�nB��`�:f ;I�O����R�_^�,<5I'p�����8a�����7@vd�oȐĚ�;ɽ/�AF��
����	<��#XS�!�K�����MPʼ}���.�<%�}d#ܸ�4w<QH>�x1���塿F茨�q>�$^��f��G��I��U�*ĺ l���_=J�,
����]��t8%�|I����Y�i����S�/�� f���[���5:����� ;�x�1E�Z�%K+L�N=�a`��$�0��A9�0,��i���#8>�=�
YN^]�z���p�8�}�[~9�~����;�$����D���Y��S�j$G��sR���L�׉��h��F���c���y������}��;��ҭ3��)\�)�ʓT��4G�e��٫bu�gG��q�6�R���ŜԻ�r�i�v�e9<b�9��6�GS���q��푒�^z�}o�F�/&23���8����>j<:����Y��;���DNx��V4���G/mN�uo�U��������ۃ����q읝4o����%�X�Y� �V.����`�4//u�Cޅ:'�k�*�)�u� v�x�6��U�#�P� ǉu'�fQ�w����>������|�&���Nr��'T`��V���VP#Z@��.Y��9��%�{��~*`�}�0�*���_�cN2�0�c��h.G�r�ֱ�d��l=P�yy!�k"���@���������A%� ��Ϻƾ���9���Ũ�1r2#BJ���$��/�t��,��T#P�a&\�-��>�e`�e�x�m�Y�eI�qˠ��n�;Z�!χ޿:�z/��GSzބ��N�c3x< o),�e(d>�쑜��9	<h
Ǻ�W��)��9ʉ�NQl���?J��9��SB:p:���.��y�ס�i����������+;����ꩳ���]בF�)i#`l����������#ݿb'��s�"�I��5������r��)�Ӽ+���1��OG�NP�S�2���/P��-HR�ݪ���q��H�CӃ��k��WJ�:ey�D���!m����&�#@�0��|h�6�}y�{�!&¹���0	zd���v�FO*E;I3`��ku i(��"5m�X���CA$��-$_���?Cl �(d�-��!���q�u(�~�iv���Z=�ј�X�xi�����	�ѷ5Tv8T�I̮[uZ����=���"Xg�8��$�H���L`�4��na�H��">p�s�'\E� 0�(���IY�CvRw"���@NN�������f>fĠ��	�I��ԝ:�HV���<������,i��b�(��9`�쥖��P!��q^^2xd��p��dc��a.�UC@G0V����_�E��,f����`	#N������t�r� J8���x#X�p�g��H�&e�S�Gw�K�B��\rn]3��1��H�T��d)O�����\
:����|��q(�*�q�ɢz��������Tq��:?8��0A�:�>��c�����<�ˋ��1~�qf,����p��l�� :Y4�zx�@gL����"���;\.�Ѕ<h'��c�{Cܤ��!CNv��i�뵛%H�{�+��B6���,�:���������}�l�Z�F�%���Cr��r�	�E�Y&�o�!N6[�����A^��1e}��"/t���0��I�h'i��7�"����9������d������1F�_���N�H;H</�L�(h�c���s��I,�G��Q�U0f��@Y�|�w=�+��B�x[4�zJ`V!e�p9��}1�snǊcP$7c=zRl�)���K��	�@��c��9X|���օ�2��;~�Uw��#��F�i�H$�^�ڏ�d߈����6������m�;om���N��N2;kL�"d��#��0P���(�ʘ9!h�E�J�u�%ݭ��	��0�G&z�+��A�q��H5� ޥ>kSgm�;T�}��ҹ�Cn�������c�E����d#�D�EPV7�av����Iq�RU;g�&rmzA^���2�Fxv�	���s�#N��V�y�1�H'ǉ� v����?Pl�����@��h�p�<k?6�A�$�'��%�H6�:�KϜ^&B�~��׉�1�d��Uk�)�1xm����������}j�>>�ju�Z̾c5��_��'R��.��8�5<���K@��0���P9���վg8Qg8҉�f�&!��׷����Ad��AW�R�u�&��+���'=+�[�����PD��>N�N�F���F4`�!4q���kkZq��3NM(��?V(�1J��F9���
�{���\.���M�"r�P�����Tҷ�on�dR�c�	|�'���4��y}4&�6G�r
]/M����?������8w8�D)
�t�an SS���0�aƘ�xd�L
�C��s��TK�\�qkP`8tde�gY �v��b�Q,R����`�,`a�	��H'��٘�F�lӘ��uʻ��cZ��.�l�G���8�\�Ň����M�Q�&���0�y�=����$�� ���f8�z������d<'-rЂ8�#f|��[X��FY�+�Yu:�p��(�}X�M�K ��pv'��{���pX�!'���g8I��<hO=huGx�������[��������d�	��7�C��$y�)����)�F��r1!�>��$Q4��91SpkwDPҜ��³\{>�zߋ�P�aA����B�A�����Q9a�����wBB�_�P�+r�b�	��ґ�c���4�qkݏ�>��#�a:-�8�14hF5)C@�W�Q8��L|#A��� HŒ���{:���l�?���qr:��Xx>����,��"q2'���~	�5�>k*��8)T8�!� '�_I	;���V&�,�y�1��Qr���'G��	��'����è%�4}���Ā���\5�bsٹy��"g� �X�{5ѐ	+)����ׯ�Y�of��~��G�W��z��Q�c}�;���hD?�l�|���	������O|���&��k�kd�s\z{t��*��Y|H���E�������`%V 6$P���Ɓp5�#��7��AD�?Lg�i>��zՀ��%�g������)��a���x2��^��-fԜВȻ9�X�בN@�1'y�������Qo�?(�p ԁc&�t+���0G��,"#���6%��QL�D�a��(�WqԷ(Jdt*�3����@�R�k��q���3�@7�`�c9X�����Y1�OA7j�=vpf��x�F4kR��*ȕ��\V��އ��[ݏ�z��	2��c�j�+&�|��Xz�Ÿv"NNN�Td�\�¨�y��,�C6��t(���ǽ�/�M¢J�T����S������b�&n�D�ʉ����Av�E��*9��5��σD[��=PV7javU��H�P�9ʙ /=�R�FG�*�K�Q�2^gp�V�y9�E�w^�-D���Ĭ�"T���V�3Y��,�� �&��ܚ$|����t�� MC�=���xH�ޛ�tr�.n�6�AU����O�vЧO�Vl]#�VVTd�'2܄�c\�#N/�d�(5̭	�w����Xl.l2?Lȡ���I�пl�������;��'�n]��S7�.�������n2���|~z��.�����L�B�i�(�����;�Ϗ���� �/�(�)���!0F�s�s�{�i|�����)�X2TA����ӝ�x\�0����}�و�i��F?c9�\]8Nf��j3!"yY���k�KpY�{�A��4gHoi�^�PeK������t�d${7��htX��!�x�| Z,�k Z��ϔ�.�K]�QJ� zpE2� ���G�d�b���h��"�$ֈ��0Щ��_A-M/M�+#u8�v��V'ԇ*�����P�3�A��#��xD��.�"Y�� o������'��χ��w���a�0�.�dƾ��a$8�	pW�� 緷7;wt[��t4<G�."v���B�eu�v	�Sb��P�p^p�,�':|`p2{M������@ �p��դ����#���%@/��7e�Y�lk��D��b	�vg59�����{��G1���Ă�7/���F:��q�hN\��ڔ34�_�=TX�I�B����0'� p&t;9rL4�b�m���X.l�����C�߿"��t�L�f�n�r9о7s�����D8�; S0� �{�T���Cf������q(R�V/��p���}U�*+�g�O��뙓��@uu(�~�Γ���*���O?�JN�I�Z?}�_ԸA��p����׿^I��NB#\�G%�8qO��.$ 3�R�#���/�ʎ�*�תn�MG�;��K��4A�I���0+�
� b�.���8]39Յ���s)h"
���T�������w���D
�}\��w���z+ hA2��yf;`�m�ش*�;=�JP�<3ҷ��;�Lc�'H&�"(�$�>�1�2'�zb��u<'V*���5��e�R�;
�^��(�?7��g��H������S��Q,�kl���%wtJ���3���tE���;��S�K�(�5��*��j�����ԫ�N)���p�E?G6yO�t���E&�Mf@���	EA�Iz�M��"F��������az%Dsuo��x��)���
���S��-�U�o�h�:{"�������Ì�����3�U(��^�p��hxt@�V�J))��`��'���9�N�ù]�!a�F��ux�Y�]�`��{x�(��3�n��|:A�e��i; �u���,��3�������Z�'��z�v��iVH^�X�#�A0�<������k��oM�"��ut�劣]�cc�ya�ur�}����y�Jaby��J�D�bH�sĸ�KY1�|�_�z06�4�!~G&�)!W�����X��0���QA����������X�#t�﯎"A�B��;���C�w�y���#!e4��e�3�3���܎� �.`�&9ɨP)�N����_k��".qk���6��|�̖i$��o_�+��y"'�բ��s�ļ�un�'�����������7t2�X��u�9	�����x:9NƢ���<�!Z�'�� �7	i�'���h+a��u�Q�&9�3��S�a"5�䈔⡚j��_bN�jT�n�ԨLgJԉnM	�M��>������2JI�V&�V��!o~��(��S�q&�I����R����0�m5<��Fz���B����xM&8����}�y��ˠLJ&��#���$�?�
{s�8J�Q�l-c��R�ۓ�
�5�u�J�BM�&���W��@�"��(>Qo~C�a�JA�DM!�,�)�m�F����@c�������`�N��\�9'QS��q��8�V�1Ȩ��Ac�6�jt
���R)D�����A  [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://05c13lwflcka"
path="res://.godot/imported/tilemap_packed.png-da35b29d46cb5a65ce166244b08e5449.ctex"
metadata={
"vram_texture": false
}
       extends Node2D
 
@export_file var next_level
 
 
func level_clear() -> void:
	get_tree().change_scene_to_file(next_level)
 
    RSRC                    PackedScene            ��������                                            
     Player    resource_local_to_scene    resource_name    texture    margins    separation    texture_region_size    use_texture_padding    0:0/0    0:0/0/script    1:0/0    1:0/0/script    2:0/0    2:0/0/script    3:0/0    3:0/0/script    4:0/0    4:0/0/script    5:0/0    5:0/0/script    6:0/0    6:0/0/script    7:0/0    7:0/0/script    0:1/0    0:1/0/script    1:1/0    1:1/0/script    2:1/0    2:1/0/script    3:1/0    3:1/0/script    4:1/0    4:1/0/script    5:1/0    5:1/0/script    6:1/0    6:1/0/script    7:1/0    7:1/0/script    0:2/0    0:2/0/script    1:2/0    1:2/0/script    2:2/0    2:2/0/script    3:2/0    3:2/0/script    4:2/0    4:2/0/script    5:2/0    5:2/0/script    6:2/0    6:2/0/script    7:2/0    7:2/0/script    script    tile_shape    tile_layout    tile_offset_axis 
   tile_size    uv_clipping 
   sources/0    tile_proxies/source_level    tile_proxies/coords_level    tile_proxies/alternative_level    1:4/0    1:4/0/terrain_set    1:4/0/terrain &   1:4/0/physics_layer_0/linear_velocity '   1:4/0/physics_layer_0/angular_velocity '   1:4/0/physics_layer_0/polygon_0/points &   1:4/0/terrains_peering_bit/right_side    1:4/0/script    2:4/0    2:4/0/terrain_set    2:4/0/terrain &   2:4/0/physics_layer_0/linear_velocity '   2:4/0/physics_layer_0/angular_velocity '   2:4/0/physics_layer_0/polygon_0/points &   2:4/0/terrains_peering_bit/right_side %   2:4/0/terrains_peering_bit/left_side    2:4/0/script    3:4/0    3:4/0/terrain_set    3:4/0/terrain &   3:4/0/physics_layer_0/linear_velocity '   3:4/0/physics_layer_0/angular_velocity '   3:4/0/physics_layer_0/polygon_0/points %   3:4/0/terrains_peering_bit/left_side    3:4/0/script    0:4/0    0:4/0/terrain_set    0:4/0/terrain &   0:4/0/physics_layer_0/linear_velocity '   0:4/0/physics_layer_0/angular_velocity '   0:4/0/physics_layer_0/polygon_0/points    0:4/0/script    3:5/0    3:5/0/terrain_set    3:5/0/terrain &   3:5/0/physics_layer_0/linear_velocity '   3:5/0/physics_layer_0/angular_velocity '   3:5/0/physics_layer_0/polygon_0/points '   3:5/0/terrains_peering_bit/bottom_side .   3:5/0/terrains_peering_bit/bottom_left_corner %   3:5/0/terrains_peering_bit/left_side    3:5/0/script    2:5/0    2:5/0/terrain_set    2:5/0/terrain &   2:5/0/physics_layer_0/linear_velocity '   2:5/0/physics_layer_0/angular_velocity '   2:5/0/physics_layer_0/polygon_0/points &   2:5/0/terrains_peering_bit/right_side /   2:5/0/terrains_peering_bit/bottom_right_corner '   2:5/0/terrains_peering_bit/bottom_side .   2:5/0/terrains_peering_bit/bottom_left_corner %   2:5/0/terrains_peering_bit/left_side    2:5/0/script    1:5/0    1:5/0/terrain_set    1:5/0/terrain &   1:5/0/physics_layer_0/linear_velocity '   1:5/0/physics_layer_0/angular_velocity '   1:5/0/physics_layer_0/polygon_0/points &   1:5/0/terrains_peering_bit/right_side /   1:5/0/terrains_peering_bit/bottom_right_corner '   1:5/0/terrains_peering_bit/bottom_side    1:5/0/script    0:5/0    0:5/0/terrain_set    0:5/0/terrain &   0:5/0/physics_layer_0/linear_velocity '   0:5/0/physics_layer_0/angular_velocity '   0:5/0/physics_layer_0/polygon_0/points '   0:5/0/terrains_peering_bit/bottom_side    0:5/0/script    0:6/0    0:6/0/terrain_set    0:6/0/terrain &   0:6/0/physics_layer_0/linear_velocity '   0:6/0/physics_layer_0/angular_velocity '   0:6/0/physics_layer_0/polygon_0/points '   0:6/0/terrains_peering_bit/bottom_side $   0:6/0/terrains_peering_bit/top_side    0:6/0/script    1:6/0    1:6/0/terrain_set    1:6/0/terrain &   1:6/0/physics_layer_0/linear_velocity '   1:6/0/physics_layer_0/angular_velocity '   1:6/0/physics_layer_0/polygon_0/points &   1:6/0/terrains_peering_bit/right_side /   1:6/0/terrains_peering_bit/bottom_right_corner '   1:6/0/terrains_peering_bit/bottom_side $   1:6/0/terrains_peering_bit/top_side ,   1:6/0/terrains_peering_bit/top_right_corner    1:6/0/script    2:6/0    2:6/0/terrain_set    2:6/0/terrain &   2:6/0/physics_layer_0/linear_velocity '   2:6/0/physics_layer_0/angular_velocity '   2:6/0/physics_layer_0/polygon_0/points &   2:6/0/terrains_peering_bit/right_side /   2:6/0/terrains_peering_bit/bottom_right_corner '   2:6/0/terrains_peering_bit/bottom_side .   2:6/0/terrains_peering_bit/bottom_left_corner %   2:6/0/terrains_peering_bit/left_side +   2:6/0/terrains_peering_bit/top_left_corner $   2:6/0/terrains_peering_bit/top_side ,   2:6/0/terrains_peering_bit/top_right_corner    2:6/0/script    3:6/0    3:6/0/terrain_set    3:6/0/terrain &   3:6/0/physics_layer_0/linear_velocity '   3:6/0/physics_layer_0/angular_velocity '   3:6/0/physics_layer_0/polygon_0/points '   3:6/0/terrains_peering_bit/bottom_side .   3:6/0/terrains_peering_bit/bottom_left_corner %   3:6/0/terrains_peering_bit/left_side +   3:6/0/terrains_peering_bit/top_left_corner $   3:6/0/terrains_peering_bit/top_side    3:6/0/script    3:7/0    3:7/0/terrain_set    3:7/0/terrain &   3:7/0/physics_layer_0/linear_velocity '   3:7/0/physics_layer_0/angular_velocity '   3:7/0/physics_layer_0/polygon_0/points %   3:7/0/terrains_peering_bit/left_side +   3:7/0/terrains_peering_bit/top_left_corner $   3:7/0/terrains_peering_bit/top_side    3:7/0/script    2:7/0    2:7/0/terrain_set    2:7/0/terrain &   2:7/0/physics_layer_0/linear_velocity '   2:7/0/physics_layer_0/angular_velocity '   2:7/0/physics_layer_0/polygon_0/points &   2:7/0/terrains_peering_bit/right_side %   2:7/0/terrains_peering_bit/left_side +   2:7/0/terrains_peering_bit/top_left_corner $   2:7/0/terrains_peering_bit/top_side ,   2:7/0/terrains_peering_bit/top_right_corner    2:7/0/script    1:7/0    1:7/0/terrain_set    1:7/0/terrain &   1:7/0/physics_layer_0/linear_velocity '   1:7/0/physics_layer_0/angular_velocity '   1:7/0/physics_layer_0/polygon_0/points &   1:7/0/terrains_peering_bit/right_side $   1:7/0/terrains_peering_bit/top_side ,   1:7/0/terrains_peering_bit/top_right_corner    1:7/0/script    0:7/0    0:7/0/terrain_set    0:7/0/terrain &   0:7/0/physics_layer_0/linear_velocity '   0:7/0/physics_layer_0/angular_velocity '   0:7/0/physics_layer_0/polygon_0/points '   0:7/0/terrains_peering_bit/bottom_side $   0:7/0/terrains_peering_bit/top_side    0:7/0/script    4:0/0/terrain_set    4:0/0/terrain &   4:0/0/physics_layer_0/linear_velocity '   4:0/0/physics_layer_0/angular_velocity '   4:0/0/physics_layer_0/polygon_0/points &   4:0/0/terrains_peering_bit/right_side '   4:0/0/terrains_peering_bit/bottom_side .   4:0/0/terrains_peering_bit/bottom_left_corner %   4:0/0/terrains_peering_bit/left_side +   4:0/0/terrains_peering_bit/top_left_corner $   4:0/0/terrains_peering_bit/top_side ,   4:0/0/terrains_peering_bit/top_right_corner    5:0/0/terrain_set    5:0/0/terrain &   5:0/0/physics_layer_0/linear_velocity '   5:0/0/physics_layer_0/angular_velocity '   5:0/0/physics_layer_0/polygon_0/points &   5:0/0/terrains_peering_bit/right_side /   5:0/0/terrains_peering_bit/bottom_right_corner '   5:0/0/terrains_peering_bit/bottom_side %   5:0/0/terrains_peering_bit/left_side +   5:0/0/terrains_peering_bit/top_left_corner $   5:0/0/terrains_peering_bit/top_side ,   5:0/0/terrains_peering_bit/top_right_corner    5:1/0/terrain_set    5:1/0/terrain &   5:1/0/physics_layer_0/linear_velocity '   5:1/0/physics_layer_0/angular_velocity '   5:1/0/physics_layer_0/polygon_0/points &   5:1/0/terrains_peering_bit/right_side /   5:1/0/terrains_peering_bit/bottom_right_corner '   5:1/0/terrains_peering_bit/bottom_side .   5:1/0/terrains_peering_bit/bottom_left_corner %   5:1/0/terrains_peering_bit/left_side $   5:1/0/terrains_peering_bit/top_side ,   5:1/0/terrains_peering_bit/top_right_corner    4:1/0/terrain_set    4:1/0/terrain &   4:1/0/physics_layer_0/linear_velocity '   4:1/0/physics_layer_0/angular_velocity '   4:1/0/physics_layer_0/polygon_0/points &   4:1/0/terrains_peering_bit/right_side /   4:1/0/terrains_peering_bit/bottom_right_corner '   4:1/0/terrains_peering_bit/bottom_side .   4:1/0/terrains_peering_bit/bottom_left_corner %   4:1/0/terrains_peering_bit/left_side +   4:1/0/terrains_peering_bit/top_left_corner $   4:1/0/terrains_peering_bit/top_side    5:7/0 &   5:7/0/physics_layer_0/linear_velocity '   5:7/0/physics_layer_0/angular_velocity    5:7/0/script    4:7/0 &   4:7/0/physics_layer_0/linear_velocity '   4:7/0/physics_layer_0/angular_velocity    4:7/0/script    13:7/0    13:7/0/terrain_set    13:7/0/terrain '   13:7/0/physics_layer_0/linear_velocity (   13:7/0/physics_layer_0/angular_velocity (   13:7/0/physics_layer_0/polygon_0/points '   13:7/0/terrains_peering_bit/right_side 0   13:7/0/terrains_peering_bit/bottom_right_corner (   13:7/0/terrains_peering_bit/bottom_side &   13:7/0/terrains_peering_bit/left_side ,   13:7/0/terrains_peering_bit/top_left_corner %   13:7/0/terrains_peering_bit/top_side -   13:7/0/terrains_peering_bit/top_right_corner    13:7/0/script    14:7/0    14:7/0/terrain_set    14:7/0/terrain '   14:7/0/physics_layer_0/linear_velocity (   14:7/0/physics_layer_0/angular_velocity (   14:7/0/physics_layer_0/polygon_0/points '   14:7/0/terrains_peering_bit/right_side (   14:7/0/terrains_peering_bit/bottom_side /   14:7/0/terrains_peering_bit/bottom_left_corner &   14:7/0/terrains_peering_bit/left_side ,   14:7/0/terrains_peering_bit/top_left_corner %   14:7/0/terrains_peering_bit/top_side -   14:7/0/terrains_peering_bit/top_right_corner    14:7/0/script    15:7/0 '   15:7/0/physics_layer_0/linear_velocity (   15:7/0/physics_layer_0/angular_velocity (   15:7/0/physics_layer_0/polygon_0/points    15:7/0/script    16:7/0 '   16:7/0/physics_layer_0/linear_velocity (   16:7/0/physics_layer_0/angular_velocity (   16:7/0/physics_layer_0/polygon_0/points    16:7/0/script    8:4/0 &   8:4/0/physics_layer_0/linear_velocity '   8:4/0/physics_layer_0/angular_velocity    8:4/0/script    7:4/0 &   7:4/0/physics_layer_0/linear_velocity '   7:4/0/physics_layer_0/angular_velocity    7:4/0/script    8:6/0 &   8:6/0/physics_layer_0/linear_velocity '   8:6/0/physics_layer_0/angular_velocity    8:6/0/script    8:7/0 &   8:7/0/physics_layer_0/linear_velocity '   8:7/0/physics_layer_0/angular_velocity    8:7/0/script    9:7/0 &   9:7/0/physics_layer_0/linear_velocity '   9:7/0/physics_layer_0/angular_velocity    9:7/0/script    9:6/0 &   9:6/0/physics_layer_0/linear_velocity '   9:6/0/physics_layer_0/angular_velocity    9:6/0/script    16:4/0 '   16:4/0/physics_layer_0/linear_velocity (   16:4/0/physics_layer_0/angular_velocity    16:4/0/script    16:5/0 '   16:5/0/physics_layer_0/linear_velocity (   16:5/0/physics_layer_0/angular_velocity    16:5/0/script    16:6/0 '   16:6/0/physics_layer_0/linear_velocity (   16:6/0/physics_layer_0/angular_velocity    16:6/0/script    17:6/0 '   17:6/0/physics_layer_0/linear_velocity (   17:6/0/physics_layer_0/angular_velocity    17:6/0/script    17:5/0 '   17:5/0/physics_layer_0/linear_velocity (   17:5/0/physics_layer_0/angular_velocity    17:5/0/script    17:4/0 '   17:4/0/physics_layer_0/linear_velocity (   17:4/0/physics_layer_0/angular_velocity    17:4/0/script    18:4/0 '   18:4/0/physics_layer_0/linear_velocity (   18:4/0/physics_layer_0/angular_velocity    18:4/0/script    19:4/0 '   19:4/0/physics_layer_0/linear_velocity (   19:4/0/physics_layer_0/angular_velocity    19:4/0/script    19:5/0 '   19:5/0/physics_layer_0/linear_velocity (   19:5/0/physics_layer_0/angular_velocity    19:5/0/script    19:6/0 '   19:6/0/physics_layer_0/linear_velocity (   19:6/0/physics_layer_0/angular_velocity    19:6/0/script    18:6/0 '   18:6/0/physics_layer_0/linear_velocity (   18:6/0/physics_layer_0/angular_velocity    18:6/0/script    18:5/0 '   18:5/0/physics_layer_0/linear_velocity (   18:5/0/physics_layer_0/angular_velocity    18:5/0/script    19:3/0 '   19:3/0/physics_layer_0/linear_velocity (   19:3/0/physics_layer_0/angular_velocity    19:3/0/script    18:3/0 '   18:3/0/physics_layer_0/linear_velocity (   18:3/0/physics_layer_0/angular_velocity    18:3/0/script    17:3/0 '   17:3/0/physics_layer_0/linear_velocity (   17:3/0/physics_layer_0/angular_velocity    17:3/0/script    16:3/0 '   16:3/0/physics_layer_0/linear_velocity (   16:3/0/physics_layer_0/angular_velocity    16:3/0/script    15:3/0 '   15:3/0/physics_layer_0/linear_velocity (   15:3/0/physics_layer_0/angular_velocity    15:3/0/script    15:2/0 '   15:2/0/physics_layer_0/linear_velocity (   15:2/0/physics_layer_0/angular_velocity    15:2/0/script    15:1/0 '   15:1/0/physics_layer_0/linear_velocity (   15:1/0/physics_layer_0/angular_velocity    15:1/0/script    14:1/0 '   14:1/0/physics_layer_0/linear_velocity (   14:1/0/physics_layer_0/angular_velocity    14:1/0/script    14:2/0 '   14:2/0/physics_layer_0/linear_velocity (   14:2/0/physics_layer_0/angular_velocity    14:2/0/script    14:3/0 '   14:3/0/physics_layer_0/linear_velocity (   14:3/0/physics_layer_0/angular_velocity    14:3/0/script    16:2/0 '   16:2/0/physics_layer_0/linear_velocity (   16:2/0/physics_layer_0/angular_velocity    16:2/0/script    17:2/0 '   17:2/0/physics_layer_0/linear_velocity (   17:2/0/physics_layer_0/angular_velocity    17:2/0/script    18:2/0 '   18:2/0/physics_layer_0/linear_velocity (   18:2/0/physics_layer_0/angular_velocity    18:2/0/script    19:2/0 '   19:2/0/physics_layer_0/linear_velocity (   19:2/0/physics_layer_0/angular_velocity    19:2/0/script    19:1/0 '   19:1/0/physics_layer_0/linear_velocity (   19:1/0/physics_layer_0/angular_velocity    19:1/0/script    19:0/0 '   19:0/0/physics_layer_0/linear_velocity (   19:0/0/physics_layer_0/angular_velocity    19:0/0/script    18:0/0 '   18:0/0/physics_layer_0/linear_velocity (   18:0/0/physics_layer_0/angular_velocity    18:0/0/script    17:0/0 '   17:0/0/physics_layer_0/linear_velocity (   17:0/0/physics_layer_0/angular_velocity    17:0/0/script    16:0/0 '   16:0/0/physics_layer_0/linear_velocity (   16:0/0/physics_layer_0/angular_velocity    16:0/0/script    16:1/0 '   16:1/0/physics_layer_0/linear_velocity (   16:1/0/physics_layer_0/angular_velocity    16:1/0/script    17:1/0 '   17:1/0/physics_layer_0/linear_velocity (   17:1/0/physics_layer_0/angular_velocity    17:1/0/script    18:1/0 '   18:1/0/physics_layer_0/linear_velocity (   18:1/0/physics_layer_0/angular_velocity    18:1/0/script    13:1/0 '   13:1/0/physics_layer_0/linear_velocity (   13:1/0/physics_layer_0/angular_velocity    13:1/0/script    12:1/0 '   12:1/0/physics_layer_0/linear_velocity (   12:1/0/physics_layer_0/angular_velocity    12:1/0/script    12:2/0 '   12:2/0/physics_layer_0/linear_velocity (   12:2/0/physics_layer_0/angular_velocity    12:2/0/script    12:3/0 '   12:3/0/physics_layer_0/linear_velocity (   12:3/0/physics_layer_0/angular_velocity    12:3/0/script    13:2/0 '   13:2/0/physics_layer_0/linear_velocity (   13:2/0/physics_layer_0/angular_velocity    13:2/0/script    13:3/0 '   13:3/0/physics_layer_0/linear_velocity (   13:3/0/physics_layer_0/angular_velocity    13:3/0/script    6:4/0 &   6:4/0/physics_layer_0/linear_velocity '   6:4/0/physics_layer_0/angular_velocity    6:4/0/script    5:4/0 &   5:4/0/physics_layer_0/linear_velocity '   5:4/0/physics_layer_0/angular_velocity    5:4/0/script    4:4/0 &   4:4/0/physics_layer_0/linear_velocity '   4:4/0/physics_layer_0/angular_velocity    4:4/0/script     physics_layer_0/collision_layer    terrain_set_0/mode    terrain_set_0/terrain_0/name    terrain_set_0/terrain_0/color 	   _bundled       Script    res://levels/base_level.gd ��������
   Texture2D M   res://common/kenney_pixel-platformer/tilemaps/tilemap-backgrounds_packed.png K�5�z�?
   Texture2D A   res://common/kenney_pixel-platformer/tilemaps/tilemap_packed.png ���ǥ6   PackedScene    res://actors/player.tscn �m<(0?   PackedScene    res://objects/spike.tscn ��T	l�.`   PackedScene    res://objects/coin.tscn U���2�a   PackedScene    res://objects/door.tscn �6�ޞf�j   !   local://TileSetAtlasSource_8sxqc �?         local://TileSet_aupys �A      !   local://TileSetAtlasSource_pyhmo &B         local://TileSet_opqi1 �Z         local://PackedScene_b30kn g[         TileSetAtlasSource 3                  -                   	      
                                                                                                                                                                                           !      "          #      $          %      &          '      (          )      *          +      ,          -      .          /      0          1      2          3      4          5      6          7      8         TileSet    <   -         >             8         TileSetAtlasSource �                 -         B          C          D          E   
           F          G   %        �  �  A  �  A  A  �  AH          I      J          K          L          M   
           N          O   %        �  �  A  �  A  A  �  AP          Q          R      S          T          U          V   
           W          X   %        �  �  A  �  A  A  �  AY          Z      [          \          ]          ^   
           _          `   %        �  �  A  �  A  A  �  Aa      b          c          d          e   
           f          g   %        �  �  A  �  A  A  �  Ah          i          j          k      l          m          n          o   
           p          q   %        �  �  A  �  A  A  �  Ar          s          t          u          v          w      x          y          z          {   
           |          }   %        �  �  A  �  A  A  �  A~                    �          �      �          �          �          �   
           �          �   %        �  �  A  �  A  A  �  A�          �      �          �          �          �   
           �          �   %        �  �  A  �  A  A  �  A�          �          �      �          �          �          �   
           �          �   %        �  �  A  �  A  A  �  A�          �          �          �          �          �      �          �          �          �   
           �          �   %        �  �  A  �  A  A  �  A�          �          �          �          �          �          �          �          �      �          �          �          �   
           �          �   %        �  �  A  �  A  A  �  A�          �          �          �          �          �      �          �          �          �   
           �          �   %        �  �  A  �  A  A  �  A�          �          �          �      �          �          �          �   
           �          �   %        �  �  A  �  A  A  �  A�          �          �          �          �          �      �          �          �          �   
           �          �   %        �  �  A  �  A  A  �  A�          �          �          �      �          �          �          �   
           �          �   %        �  �  A  �  A  A  �  A�          �          �                �          �          �   
           �          �   %        �  �  A  �  A  A  �  A�          �          �          �          �          �          �                          �          �          �   
           �          �   %        �  �  A  �  A  A  �  A�          �          �          �          �          �          �                "          �          �          �   
           �          �   %        �  �  A  �  A  A  �  A                                                                #                                   	  
           
           %        �  �  A  �  A  A  �  A                                                               !                 
                                    
                                                      
                       %        �  �  A  �  A  A  �  A!         "         #         $         %         &         '         (     )         *         +         ,  
           -         .  %        �  �  A  �  A  A  �  A/         0         1         2         3         4         5         6     7         8  
           9         :  %        �  �  A  �  A  A  �  A;     <         =  
           >         ?  %        �  �  A  �  A  A  �  A@     A         B  
           C         D     E         F  
           G         H     I         J  
           K         L     M         N  
           O         P     Q         R  
           S         T     U         V  
           W         X     Y         Z  
           [         \     ]         ^  
           _         `     a         b  
           c         d     e         f  
           g         h     i         j  
           k         l     m         n  
           o         p     q         r  
           s         t     u         v  
           w         x     y         z  
           {         |     }         ~  
                    �     �         �  
           �         �     �         �  
           �         �     �         �  
           �         �     �         �  
           �         �     �         �  
           �         �     �         �  
           �         �     �         �  
           �         �     �         �  
           �         �     �         �  
           �         �     �         �  
           �         �     �         �  
           �         �     �         �  
           �         �     �         �  
           �         �     �         �  
           �         �     �         �  
           �         �     �         �  
           �         �     �         �  
           �         �     �         �  
           �         �     �         �  
           �         �     �         �  
           �         �     �         �  
           �         �     �         �  
           �         �     �         �  
           �         �     �         �  
           �         �     �         �  
           �         �     �         �  
           �         �     �         �  
           �         �     �         �  
           �         �     �         �  
           �         �     �         �  
           �         �     �         �  
           �         �     �         �  
           �                          
                         8         TileSet    <   -                                  Grass         ?  �>  �>  �?>            8         PackedScene    	     	         names "   "   
   BaseLevel    script    Node2D    Background 	   tile_set    format    layer_0/tile_data    TileMap    Foreground    Player 	   position    ground_friction    air_friction 
   max_speed    jump_velocity 	   Camera2D    limit_right 	   Sprite2D    CollisionShape2D    AnimationPlayer    Objects    Spikes    Spike8    Spike7    Spike4    Spike5    Spike6    Spike3    Spike2    Spike    Coins    Coin    Spike9    Door    	   variants    %                                P                                                                	          
                                                                         	         
                                                                        	         
                                                                        	         
                                                                        	         
                                                                        	         
                                                                        	         
                                                                        	         
                                                                        	         
                 	         	         	         	         	         	         	 	        	 
        	         
         
         
         
         
         
         
 	        
 
        
                                                                	         
                                                                        	         
                                                                        	         
                                                                        	         
                                                                        	         
                                                                        	         
                                                                        	         
                                                                        	         
                                                                        	         
                                                                        	         
                                                                        	         
                                                                        	         
                                                                        	         
                   ��                                       ��                                    ��                                    ��                                    ��                                    ��                                    ��                                    ��                                    ��                                   	 ��       	          	         	         
 ��       
          
         
          ��                                    ��                                    ��                                    ��                                    ��                                    ��                                    ��                                    ��                                    ��                                    ��                                    ��                                    ��                                    ��                                    ��                                                                                          	         
                  ��                                                                                          	         
                  ��                                                                                          	         
                  ��                                                                                          	         
                  ��                                                                                          	         
                  ��                                                                                          	         
                  ��                                                                                          	         
                  ��                                                                                          	         
                   ��                                                                                                    	          
                  ! ��       !          !         !         !         !         !         !         !         !         ! 	        ! 
        !         " ��       "          "         "         "         "         "         "         "         "         " 	        " 
        "         # ��       #          #         #         #         #         #         #         #         #         # 	        # 
        #         $ ��       $          $         $         $         $         $         $         $         $         $ 	        $ 
        $         % ��       %          %         %         %         %         %         %         %         %         % 	        % 
        %         & ��       &          &         &         &         &         &         &         &         &         & 	        & 
        &         ' ��       '          '         '         '         '         '         '         '         '         ' 	        ' 
        '         ( ��       (          (         (         (         (         (         (         (         (         ( 	        ( 
        (         ) ��       )          )         )         )         )         )         )         )         )         ) 	        ) 
        )         * ��       *          *         *         *         *         *         *         *         *         * 	        * 
        *         + ��       +          +         +         +         +         +         +         +         +         + 	        + 
        +         , ��       ,          ,         ,         ,         ,         ,         ,         ,         ,         , 	        , 
        ,         - ��       -          -         -         -         -         -         -         -         -         - 	        - 
        -         . ��       .          .         .         .         .         .         .         .         .         . 	        . 
        .         / ��       /          /         /         /         /         /         /         /         /         / 	        / 
        /                      �                                                                            	         
                                                                      ��       ��       ��       ��       ��       ��       ��       ��
       ��	       ��       ��       ��       ��       ��       ��       ��       ��                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
        
        	        	                                                                                                                                                                                                                       ��        ��        ��        ��        ��         ��      ��        ����      ����      ����      ����      ����      ����        ��        ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��      
 ��      
 ��      	 ��      	 ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��      ! ��      ! ��      !        !        !        " ��      " ��      "        "        "        # ��      # ��      #        #        #        $ ��      $ ��      $        $        $        % ��      % ��      %        %        %        & ��      & ��      &        &        &        ' ��      ' ��      '        '        '        ( ��      ( ��      (        (        (        ) ��      ) ��      )        )        )        * ��      * ��      *        *        *        + ��      + ��      +        +        +        , ��      , ��      ,        ,        ,        - ��      - ��      -        -        -        . ��      . ��      .        .        .        / ��      / ��      /        /        /        0 ��      0 ��      0        0        0        1 ��      1 ��      1        1        1        2 ��      2 ��      2        2        2        3 ��      3 ��      3        3        3        4 ��      4 ��      4        4        4        5 ��      5 ��      5        5        5        6 ��      6 ��      6        6        6        7 ��      7 ��      7        7        7        8 ��      8 ��      8        8        8        9 ��      9 ��      9        9        9        : ��      : ��      :        :        :        ; ��      ; ��      ;        ;        ;        < ��      < ��      <        <        <        = ��      = ��      =        =        =        > ��      > ��      >        >        >        ? ��      ? ��       ? ��      ? ��      ? ��      ? ��      ?         ?        ?        ?        ?        ?        ?        ?        ?        ? 	       ? 
        ?        ?        ?        ?        ?        ?        ?        @ ��      @ ��      @ ��      @ ��      @ ��      @ ��      @         @        @        @        @        @        @        @        @        @ 	       @ 
       @        @        @        @        @        @        @                                                                         
        
        
        
        
                	                                                       	        
                                )        *        +        ,        .        /        0        1        .        /        0        1        3        4        5        6        7        8        3        4        5        6        7        8        3        4        5        6        7        8        ;        ;        ;        ;         ; 
        <        <        <        =        > 
       > 	       *        +        /        0        5 
       6 
       ;                 
     XB  2C)   �������?)   333333�?     HC     �C   �           
     D  |C
    �D  |C
     �C  |C
     �C  |C
     �C  |C
     �C  |C
     �C  |C
     �C  |C         
    ��C  /C
    �SD  kC
     �A    
     �B  ��
     �B    
     |B  �
     �A  B
     �A  B
     �A  �A
    @=D  |C
    �AD  |C
     FD  |C         
    ��D  $C      node_count    !         nodes     3  ��������       ����                            ����                                       ����                                 ���	         
               	      
                �������  ����                           ����                     ����               ���         
                 ���         
                 ���         
                 ���         
                 ���         
                 ���         
                 ���         
                 ���         
                       ����               ���         
                  ���         
                 ���         
                 ���         
                 ���          
                 ���         
                 ���         
                 ���         
                 ���          
                 ���          
                 ���          
                 ���          
                 ���          
                  ���         
                   ���         
   !               ���         
   "               ���!   #      
   $             conn_count              conns               node_paths              editable_instances                       version       8      RSRC     RSRC                    PackedScene            ��������                                                  Player    resource_local_to_scene    resource_name 	   _bundled    script       PackedScene    res://levels/base_level.tscn nX��B�      local://PackedScene_5uy26 $         PackedScene          
         names "      	   Level_00    next_level    Background    Foreground    Player 	   Camera2D 	   Sprite2D    CollisionShape2D    AnimationPlayer    Objects    Spikes    Spike8    Spike7    Spike4    Spike5    Spike6    Spike3    Spike2    Spike    Coins    Coin    Spike9    Door    	   variants                       res://levels/level_01.tscn       node_count             nodes     	   �����������    ����                   conn_count              conns               node_paths              editable_instances                       base_scene              version             RSRC  RSRC                    PackedScene            ��������                                            
      Objects    Spikes    Coins    Spike8    Spike9    Player    resource_local_to_scene    resource_name 	   _bundled    script       PackedScene    res://levels/base_level.tscn nX��B�   PackedScene    res://objects/coin.tscn U���2�a   PackedScene    res://objects/spike.tscn ��T	l�.`      local://PackedScene_x0bgp �         PackedScene          
         names "   (   	   Level_01    next_level    Background    Foreground    scale    layer_0/tile_data    Player 	   Camera2D 	   Sprite2D    CollisionShape2D    AnimationPlayer    Objects    Spikes    Spike8 	   position    script    Spike7    Spike4    Spike5    Spike6    Spike3    Spike2    Spike    Coins    Coin4    Coin3    Coin2    Coin    Spike9    Spike10    Spike11    Spike12    Spike13    Spike14    Spike15    Spike16    Spike17    Spike18    Spike19    Door    	   variants    )                   res://levels/level_02.tscn 
   �
�?J�?    �                                                                            	         
                                                                      ��       ��       ��       ��       ��       ��       ��       ��
       ��	       ��       ��       ��       ��       ��       ��       ��       ��                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
        
        	        	                                                                                                                                                                                                                       ��        ��        ��        ��        ��         ��      ��        ����      ����      ����      ����      ����      ����        ��        ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��      
 ��      
 ��      	 ��      	 ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��      ! ��      ! ��      !        !        !        " ��      " ��      "        "        "        # ��      # ��      #        #        #        $ ��      $ ��      $        $        $        % ��      % ��      %        %        %        & ��      & ��      &        &        &        ' ��      ' ��      '        '        '        ( ��      ( ��      (        (        (        ) ��      ) ��      )        )        )        * ��      * ��      *        *        *        + ��      + ��      +        +        +        , ��      , ��      ,        ,        ,        - ��      - ��      -        -        -        . ��      . ��      .        .        .        / ��      / ��      /        /        /        0 ��      0 ��      0        0        0        1 ��      1 ��      1        1        1        2 ��      2 ��      2        2        2        3 ��      3 ��      3        3        3        4 ��      4 ��      4        4        4        5 ��      5 ��      5        5        5        6 ��      6 ��      6        6        6        7 ��      7 ��      7        7        7        8 ��      8 ��      8        8        8        9 ��      9 ��      9        9        9        : ��      : ��      :        :        :        ; ��      ; ��      ;        ;        ;        < ��      < ��      <        <        <        = ��      = ��      =        =        =        > ��      > ��      >        >        >        ? ��      ? ��       ? ��      ? ��      ? ��      ? ��      ?         ?        ?        ?        ?        ?        ?        ?        ?        ? 	       ? 
        ?        ?        ?        ?        ?        ?        ?        @ ��      @ ��      @ ��      @ ��      @ ��      @ ��      @         @        @        @        @        @        @        @        @        @ 	       @ 
       @        @        @        @        @        @        @                                  ��������  ��������                         
 �������� 
 �������� 
 �������� 
 �������� 
 ��������         	 ��������                                                	        
                                )        *  ��������+  ��������,  ��������.        /        0        1        .        /        0        1        3        4        5        6  ��������7  ��������8  ��������3        4        5        6  ��������7  ��������8  ��������3        4        5        6  ��������7  ��������8  ��������;  ��������;  ��������;  ��������;  ��������; 
 ��������<  ��������<  ��������<  ��������=  ��������> 
       > 	       *  ��������+  ��������/        0        5 
       6 
 ��������;  ��������                                                                                        #        #        #        #        # 
       # 	       $ 	       $ 
       $        $        $        $        % 	       %        % 
       %        %        %        & 	       & 
       &        &        &        &        ' 	       ' 
       '        '        '        '        ( 	       ( 
       (        (        (        (        ) 	       ) 
       )        )        )        2        2        /        0        1        2        4        3        2        1        / 
       0 
       1 
       2 
       3 
       4 
       5 	       4 	       3 	       2 	       1 	       0 	       / 	       /        .        . 	       . 
       .        .        0        1        5        5        4        3        2        = 	       = 
       < 	       < 
       
     �C  �C   
     �C  �C
     �C  �C
     �C  �C
     �C  �C
     �C  �C         
     bD  �B
    �-D  C
    @D  9C
     �C  cC
    �SD  C
     =�  �A
     *C  ��
     �A             
     �  �B
     *�  �B
     �B  �B
     �  �B
     C  �B
     �B  �B
     �B  �B
     *C  �B
     C  �B
     8B  �B
     �B  �B
     ��  �B
     ��  �B
     ��  �B
     ��  �B
     ��  �B
    � D  XC
     D  XC
    �	D  XC
    ��D  "C      node_count    )         nodes       �����������    ����                     ���  ����                      @    ���  ����                      @    ���  ����                      @    ���  ����                      @    ���  ����                      @    ���  ����      	                @    ���  ����      
               @    ���                    @    ���                    @    ���                    @    ���  ����                     ���  ����                    ���  ����               @    ���  ����                    ���  ����                    ���  ����                    ���  ����                    ���                         ���                         ���                         ���                          ���!                          ���" $                        ���# (                        ���$ ,                        ���% 0                        ���& 4                        ���                         ���                         ���                         ���                           ���! $                         ���" (          !              ���# ,          "              ���$ 0          #              ���% 4          $               ���  ����      %               ���  ����      &               ���   ����      '               ���' $ ����      (             conn_count              conns               node_paths                                                      editable_instances                      base_scene              version       	      RSRC            RSRC                    PackedScene            ��������                                            
      Objects    Spikes    Coins    Spike8    Spike9    Player    resource_local_to_scene    resource_name 	   _bundled    script       PackedScene    res://levels/base_level.tscn nX��B�      local://PackedScene_3is5y [         PackedScene          
         names "      	   level_02    next_level    Background    Foreground    layer_0/tile_data    Player 	   Camera2D 	   Sprite2D    CollisionShape2D    AnimationPlayer    Objects    Spikes    Spike8 	   position    Spike7    Spike4    Spike5    Spike6    Spike3    Spike2    Spike    Coins    Coin    Spike9    Door    	   variants                       res://levels/level_00.tscn     �                                                                            	         
                                                                      ��       ��       ��       ��       ��       ��       ��       ��
       ��	       ��       ��       ��       ��       ��       ��       ��       ��                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
        
        	        	                                                                                                                                                                                                                       ��        ��        ��        ��        ��         ��      ��        ����      ����      ����      ����      ����      ����        ��        ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��      
 ��      
 ��      	 ��      	 ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��       ��      ! ��      ! ��      !        !        !        " ��      " ��      "        "        "        # ��      # ��      #        #        #        $ ��      $ ��      $        $        $        % ��      % ��      %        %        %        & ��      & ��      &        &        &        ' ��      ' ��      '        '        '        ( ��      ( ��      (        (        (        ) ��      ) ��      )        )        )        * ��      * ��      *        *        *        + ��      + ��      +        +        +        , ��      , ��      ,        ,        ,        - ��      - ��      -        -        -        . ��      . ��      .        .        .        / ��      / ��      /        /        /        0 ��      0 ��      0        0        0        1 ��      1 ��      1        1        1        2 ��      2 ��      2        2        2        3 ��      3 ��      3        3        3        4 ��      4 ��      4        4        4        5 ��      5 ��      5        5        5        6 ��      6 ��      6        6        6        7 ��      7 ��      7        7        7        8 ��      8 ��      8        8        8        9 ��      9 ��      9        9        9        : ��      : ��      :        :        :        ; ��      ; ��      ;        ;        ;        < ��      < ��      <        <        <        = ��      = ��      =        =        =        > ��      > ��      >        >        >        ? ��      ? ��       ? ��      ? ��      ? ��      ? ��      ?         ?        ?        ?        ?        ?        ?        ?        ?        ? 	       ? 
       ?        ?        ?        ?        ?        ?        ?        @ ��      @ ��      @ ��      @ ��      @ ��      @ ��      @         @        @        @        @        @        @        @        @        @ 	       @ 
       @        @        @        @        @        @        @                                                                         
 �������� 
 �������� 
 �������� 
 �������� 
 ��������         	 ��������                                                	        
                                )        *        +        ,        .        /        0        1        .        /        0        1        3        4        5        6        7        8        3  ��������4  ��������5  ��������6  ��������7  ��������8  ��������3  ��������4  ��������5  ��������6  ��������7  ��������8  ��������;        ;  ��������;  ��������;  ��������; 
 ��������<  ��������<        <  ��������=        > 
 ��������> 	 ��������*  ��������+  ��������/  ��������0  ��������5 
 ��������6 
 ��������;  ��������                                                                                                                                                                	                                                         !        "        #        $        %        &        '        (        -        2        9        :        >        
     �C ��C
     �C ��C
     `C ��C
     �C ��C
     �C ��C
     rC ��C
     NC ��C
     <C ��C
     wC  (C
     �B  �A
      �  �B
     �A    
    ��C  }C
    ��C  }C
    ��C  }C      node_count             nodes     �   �����������    ����                     ���  ����                @    ���  ����                @    ���  ����                @    ���  ����                @    ���  ����                @    ���  ����                @    ���  ����                @    ���  ����      	          @    ���   ����      
         @    ���  ����               @    ���  ����               @    ���  ����                    ���  ����                    ���  ����                    ���  ����                     ���  ����                     ���  ����                     ���   ����                   conn_count              conns               node_paths                                                               editable_instances                      base_scene              version       	      RSRCextends Area2D

@export var score: int

func _on_body_entered(body):
	$AnimationPlayer.play("pick_up")
         RSRC                    PackedScene            ��������                                            ,      .. 	   Sprite2D    frame 	   position    . 	   modulate    resource_local_to_scene    resource_name    length 
   loop_mode    step    tracks/0/type    tracks/0/imported    tracks/0/enabled    tracks/0/path    tracks/0/interp    tracks/0/loop_wrap    tracks/0/keys    tracks/1/type    tracks/1/imported    tracks/1/enabled    tracks/1/path    tracks/1/interp    tracks/1/loop_wrap    tracks/1/keys    tracks/2/type    tracks/2/imported    tracks/2/enabled    tracks/2/path    tracks/2/interp    tracks/2/loop_wrap    tracks/2/keys    tracks/3/type    tracks/3/imported    tracks/3/enabled    tracks/3/path    tracks/3/interp    tracks/3/loop_wrap    tracks/3/keys    script    _data    custom_solver_bias    size 	   _bundled       PackedScene    res://objects/object.tscn Tr�u�x.   Script    res://objects/coin.gd ��������
   Texture2D A   res://common/kenney_pixel-platformer/tilemaps/tilemap_packed.png ���ǥ6      local://Animation_b41oo          local://Animation_mf68n �         local://Animation_6iu1v �         local://AnimationLibrary_qi6qn �         local://RectangleShape2D_jl02u `         local://PackedScene_pfopu �      
   Animation          o�:         value                                                                       times !                transitions !        �?      values          �         update                value                                                                       times !                transitions !        �?      values       
         �      update                 value                                                                   times !                transitions !        �?      values       
         �      update                  value !          "         #                  $         %         &               times !                transitions !        �?      values            �?  �?  �?  �?      update        '      
   Animation             default 	         
      ��L=         value                                                                       times !            �>   ?  @?      transitions !        �?  �?  �?  �?      values          �      �      �      �         update                value                                                                       times !             ?      transitions !         ?   @      values       
         ��
         �      update                 value                                                                   times !             ?      transitions !         ?   @      values       
         ��
         �      update        '      
   Animation             pick_up       ���>         value                                                                       times !          ���>      transitions !        �?  �?      values       
         ��
         �      update                 value                                                                       times !          ���>      transitions !        �?  �?      values            �?  �?  �?  �?     �?  �?  �?          update                 method                                                                  times !      ���>      transitions !        �?      values                   method ,      queue_free       args        '         AnimationLibrary    (               RESET                 default                pick_up          '         RectangleShape2D    *   
     �A  �A'         PackedScene    +      
         names "         Coin    collision_layer    collision_mask    script    AnimationPlayer 
   libraries 	   autoplay 	   Sprite2D 	   position    texture    hframes    vframes    frame    CollisionShape2D    shape    _on_body_entered    body_entered    	   variants                                                                  default 
         �                  	      �                  node_count             nodes     4   �����������    ����                                 ���  ����                           ���  ����         	      
         	      
               ���  ����                         conn_count             conns                                       node_paths              editable_instances              base_scene              version       '      RSRC             extends Area2D
 
 
func _on_body_entered(body: Node2D) -> void:
	if owner.has_method("level_clear"):
		owner.level_clear()
     RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled       PackedScene    res://objects/object.tscn Tr�u�x.   Script    res://objects/door.gd ��������
   Texture2D A   res://common/kenney_pixel-platformer/tilemaps/tilemap_packed.png ���ǥ6      local://RectangleShape2D_ey2bu �         local://PackedScene_exrro          RectangleShape2D       
     �A  �A         PackedScene          
         names "         Door    collision_layer    collision_mask    script    AnimationPlayer 	   Sprite2D 	   position    texture    region_enabled    region_rect    CollisionShape2D    shape    _on_body_entered    body_entered    	   variants    
                                  
         ��                    4C  �B  �A  B
         8�                node_count             nodes     '   �����������    ����                                 ���  ����                     	                  ���
  ����            	             conn_count             conns                                       node_paths              editable_instances              base_scene              version             RSRC               RSRC                    PackedScene            ��������                                                  ..    CollisionShape2D    resource_local_to_scene    resource_name 	   _bundled    script           local://PackedScene_hfft0 �          PackedScene          	         names "         Object    Area2D    AnimationPlayer 
   root_node 	   Sprite2D    CollisionShape2D    	   variants                          node_count             nodes        ��������       ����                      ����                            ����                      ����              conn_count              conns               node_paths              editable_instances              version             RSRC               extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body.has_method("die"):
		body.die()
         RSRC                    PackedScene            ��������                                                  resource_local_to_scene    resource_name    custom_solver_bias    size    script 	   _bundled       PackedScene    res://objects/object.tscn Tr�u�x.   Script    res://objects/spike.gd ��������
   Texture2D A   res://common/kenney_pixel-platformer/tilemaps/tilemap_packed.png ���ǥ6      local://RectangleShape2D_tc1n7 �         local://PackedScene_568un          RectangleShape2D       
     �A  A         PackedScene          
         names "         Spike    collision_layer    collision_mask    script    AnimationPlayer 	   Sprite2D 	   position    texture    region_enabled    region_rect    CollisionShape2D    shape    _on_body_entered    body_entered    	   variants    
                                  
         �                    C  XB  �A  �A
      ?  ��                node_count             nodes     '   �����������    ����                                 ���  ����                     	                  ���
  ����            	             conn_count             conns                                       node_paths              editable_instances              base_scene              version             RSRC             GST2   �   �      ����               � �        �  RIFF�  WEBPVP8L�  /������!"2�H�m�m۬�}�p,��5xi�d�M���)3��$�V������3���$G�$2#�Z��v{Z�lێ=W�~� �����d�vF���h���ڋ��F����1��ڶ�i�엵���bVff3/���Vff���Ҿ%���qd���m�J�}����t�"<�,���`B �m���]ILb�����Cp�F�D�=���c*��XA6���$
2#�E.@$���A.T�p )��#L��;Ev9	Б )��D)�f(qA�r�3A�,#ѐA6��npy:<ƨ�Ӱ����dK���|��m�v�N�>��n�e�(�	>����ٍ!x��y�:��9��4�C���#�Ka���9�i]9m��h�{Bb�k@�t��:s����¼@>&�r� ��w�GA����ը>�l�;��:�
�wT���]�i]zݥ~@o��>l�|�2�Ż}�:�S�;5�-�¸ߥW�vi�OA�x��Wwk�f��{�+�h�i�
4�˰^91��z�8�(��yޔ7֛�;0����^en2�2i�s�)3�E�f��Lt�YZ���f-�[u2}��^q����P��r��v��
�Dd��ݷ@��&���F2�%�XZ!�5�.s�:�!�Њ�Ǝ��(��e!m��E$IQ�=VX'�E1oܪì�v��47�Fы�K챂D�Z�#[1-�7�Js��!�W.3׹p���R�R�Ctb������y��lT ��Z�4�729f�Ј)w��T0Ĕ�ix�\�b�9�<%�#Ɩs�Z�O�mjX �qZ0W����E�Y�ڨD!�$G�v����BJ�f|pq8��5�g�o��9�l�?���Q˝+U�	>�7�K��z�t����n�H�+��FbQ9���3g-UCv���-�n�*���E��A�҂
�Dʶ� ��WA�d�j��+�5�Ȓ���"���n�U��^�����$G��WX+\^�"�h.���M�3�e.
����MX�K,�Jfѕ*N�^�o2��:ՙ�#o�e.
��p�"<W22ENd�4B�V4x0=حZ�y����\^�J��dg��_4�oW�d�ĭ:Q��7c�ڡ��
A>��E�q�e-��2�=Ϲkh���*���jh�?4�QK��y@'�����zu;<-��|�����Y٠m|�+ۡII+^���L5j+�QK]����I �y��[�����(}�*>+���$��A3�EPg�K{��_;�v�K@���U��� gO��g��F� ���gW� �#J$��U~��-��u���������N�@���2@1��Vs���Ŷ`����Dd$R�":$ x��@�t���+D�}� \F�|��h��>�B�����B#�*6��  ��:���< ���=�P!���G@0��a��N�D�'hX�׀ "5#�l"j߸��n������w@ K�@A3�c s`\���J2�@#�_ 8�����I1�&��EN � 3T�����MEp9N�@�B���?ϓb�C��� � ��+�����N-s�M�  ��k���yA 7 �%@��&��c��� �4�{� � �����"(�ԗ�� �t�!"��TJN�2�O~� fB�R3?�������`��@�f!zD��%|��Z��ʈX��Ǐ�^�b��#5� }ى`�u�S6�F�"'U�JB/!5�>ԫ�������/��;	��O�!z����@�/�'�F�D"#��h�a �׆\-������ Xf  @ �q�`��鎊��M��T�� ���0���}�x^�����.�s�l�>�.�O��J�d/F�ě|+^�3�BS����>2S����L�2ޣm�=�Έ���[��6>���TъÞ.<m�3^iжC���D5�抺�����wO"F�Qv�ږ�Po͕ʾ��"��B��כS�p�
��E1e�������*c�������v���%'ž��&=�Y�ް>1�/E������}�_��#��|������ФT7׉����u������>����0����緗?47�j�b^�7�ě�5�7�����|t�H�Ե�1#�~��>�̮�|/y�,ol�|o.��QJ rmϘO���:��n�ϯ�1�Z��ը�u9�A������Yg��a�\���x���l���(����L��a��q��%`�O6~1�9���d�O{�Vd��	��r\�՜Yd$�,�P'�~�|Z!�v{�N�`���T����3?DwD��X3l �����*����7l�h����	;�ߚ�;h���i�0�6	>��-�/�&}% %��8���=+��N�1�Ye��宠p�kb_����$P�i�5�]��:��Wb�����������ě|��[3l����`��# -���KQ�W�O��eǛ�"�7�Ƭ�љ�WZ�:|���є9�Y5�m7�����o������F^ߋ������������������Р��Ze�>�������������?H^����&=����~�?ڭ�>���Np�3��~���J�5jk�5!ˀ�"�aM��Z%�-,�QU⃳����m����:�#��������<�o�����ۇ���ˇ/�u�S9��������ٲG}��?~<�]��?>��u��9��_7=}�����~����jN���2�%>�K�C�T���"������Ģ~$�Cc�J�I�s�? wڻU���ə��KJ7����+U%��$x�6
�$0�T����E45������G���U7�3��Z��󴘶�L�������^	dW{q����d�lQ-��u.�:{�������Q��_'�X*�e�:�7��.1�#���(� �k����E�Q��=�	�:e[����u��	�*�PF%*"+B��QKc˪�:Y��ـĘ��ʴ�b�1�������\w����n���l镲��l��i#����!WĶ��L}rեm|�{�\�<mۇ�B�HQ���m�����x�a�j9.�cRD�@��fi9O�.e�@�+�4�<�������v4�[���#bD�j��W����֢4�[>.�c�1-�R�����N�v��[�O�>��v�e�66$����P
�HQ��9���r�	5FO� �<���1f����kH���e�;����ˆB�1C���j@��qdK|
����4ŧ�f�Q��+�     [remap]

importer="texture"
type="CompressedTexture2D"
uid="uid://c6x7yhyo4f8tf"
path="res://.godot/imported/icon.svg-218a8f2b3041327d8a5756f3a245f83b.ctex"
metadata={
"vram_texture": false
}
                [remap]

path="res://.godot/exported/133200997/export-26e24d1e90269def944321d57dab8ad8-actor.scn"
              [remap]

path="res://.godot/exported/133200997/export-e86f95e5088e93066d258d9192ab0748-player.scn"
             [remap]

path="res://.godot/exported/133200997/export-91b05a10019765108193bb2afad7b3d9-base_level.scn"
         [remap]

path="res://.godot/exported/133200997/export-114308d02b75537e640a04e378442042-level_00.scn"
           [remap]

path="res://.godot/exported/133200997/export-c4c54ecad530fec2f43d88be46836b98-level_01.scn"
           [remap]

path="res://.godot/exported/133200997/export-a970615d582ebd1bf0e5b7e66283dc1a-level_02.scn"
           [remap]

path="res://.godot/exported/133200997/export-95f0d95b3a03d7f40146d4fc05617007-coin.scn"
               [remap]

path="res://.godot/exported/133200997/export-4d35b6806538f9d7f1eabac087f24885-door.scn"
               [remap]

path="res://.godot/exported/133200997/export-c9ee0d8e46a01f657f98a2c67970a9a1-object.scn"
             [remap]

path="res://.godot/exported/133200997/export-d7a2ad92a25ae9bae9307a8ee3f82bda-spike.scn"
              list=Array[Dictionary]([{
"base": &"CharacterBody2D",
"class": &"Actor",
"icon": "",
"language": &"GDScript",
"path": "res://actors/actor.gd"
}])
              <svg height="128" width="128" xmlns="http://www.w3.org/2000/svg"><rect x="2" y="2" width="124" height="124" rx="14" fill="#363d52" stroke="#212532" stroke-width="4"/><g transform="scale(.101) translate(122 122)"><g fill="#fff"><path d="M105 673v33q407 354 814 0v-33z"/><path d="m105 673 152 14q12 1 15 14l4 67 132 10 8-61q2-11 15-15h162q13 4 15 15l8 61 132-10 4-67q3-13 15-14l152-14V427q30-39 56-81-35-59-83-108-43 20-82 47-40-37-88-64 7-51 8-102-59-28-123-42-26 43-46 89-49-7-98 0-20-46-46-89-64 14-123 42 1 51 8 102-48 27-88 64-39-27-82-47-48 49-83 108 26 42 56 81zm0 33v39c0 276 813 276 814 0v-39l-134 12-5 69q-2 10-14 13l-162 11q-12 0-16-11l-10-65H446l-10 65q-4 11-16 11l-162-11q-12-3-14-13l-5-69z" fill="#478cbf"/><path d="M483 600c0 34 58 34 58 0v-86c0-34-58-34-58 0z"/><circle cx="725" cy="526" r="90"/><circle cx="299" cy="526" r="90"/></g><g fill="#414042"><circle cx="307" cy="532" r="60"/><circle cx="717" cy="532" r="60"/></g></g></svg>
              ����b:   res://actors/actor.tscn�m<(0?   res://actors/player.tscnK�5�z�?L   res://common/kenney_pixel-platformer/tilemaps/tilemap-backgrounds_packed.pngf��YJB.iK   res://common/kenney_pixel-platformer/tilemaps/tilemap-characters_packed.png���ǥ6@   res://common/kenney_pixel-platformer/tilemaps/tilemap_packed.pngnX��B�   res://levels/base_level.tscn���]M�<   res://levels/level_00.tscn����~_FE   res://levels/level_01.tscn��8<���6   res://levels/level_02.tscnU���2�a   res://objects/coin.tscn�6�ޞf�j   res://objects/door.tscnTr�u�x.   res://objects/object.tscn��T	l�.`   res://objects/spike.tscnG��wa   res://icon.svg       ECFG      application/config/name         New Platformer     application/run/main_scene$         res://levels/base_level.tscn   application/config/features   "         4.2    Mobile     application/config/icon         res://icon.svg  "   display/window/size/viewport_width      @  #   display/window/size/viewport_height      D  )   display/window/size/window_width_override         *   display/window/size/window_height_override      �     display/window/stretch/mode         viewport
   input/left0              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   A   	   key_label             unicode    a      echo          script         input/right0              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   D   	   key_label             unicode    d      echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script      
   input/jump�              deadzone      ?      events              InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode       	   key_label             unicode           echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode   W   	   key_label             unicode    w      echo          script            InputEventKey         resource_local_to_scene           resource_name             device     ����	   window_id             alt_pressed           shift_pressed             ctrl_pressed          meta_pressed          pressed           keycode           physical_keycode    @ 	   key_label             unicode           echo          script         layer_names/2d_physics/layer_1         worlds     layer_names/2d_physics/layer_2         players    layer_names/2d_physics/layer_3         enemies #   rendering/renderer/rendering_method         mobile  .   rendering/textures/size/window_height_override      �  -   rendering/textures/size/window_width_override            rendering/textures/stretch/mode         viewport'   rendering/textures/size/viewport_height      D   