package comm.loss;

import java.util.List;
import java.util.Map;

import org.springframework.stereotype.Repository;

import comm.common.dao.AbstractDAO;

@Repository("lossDAO")
public class LossDAO extends AbstractDAO{

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectBoardList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectPagingList("loss.selectBoardList", map);
	}

	public void insertBoard(Map<String, Object> map) throws Exception{
		insert("loss.insertBoard", map);
	}

	public void updateHitCnt(Map<String, Object> map) throws Exception{
		update("loss.updateHitCnt", map);
	}

	@SuppressWarnings("unchecked")
	public Map<String, Object> selectBoardDetail(Map<String, Object> map) throws Exception{
		return (Map<String, Object>) selectOne("loss.selectBoardDetail", map);
	}

	public void updateBoard(Map<String, Object> map) throws Exception{
		update("loss.updateBoard", map);
	}

	public void deleteBoard(Map<String, Object> map) throws Exception{
		update("loss.deleteBoard", map);
	}

	
	
	
	// 파일 관련해서는 마지막에 전반적으로 손볼것
	public void insertFile(Map<String, Object> map) throws Exception{
		insert("loss.insertFile", map);
	}

	@SuppressWarnings("unchecked")
	public List<Map<String, Object>> selectFileList(Map<String, Object> map) throws Exception{
		return (List<Map<String, Object>>)selectList("loss.selectFileList", map);
	}

	public void deleteFileList(Map<String, Object> map) throws Exception{
		update("loss.deleteFileList", map);
	}

	public void updateFile(Map<String, Object> map) throws Exception{
		update("loss.updateFile", map);
	}

}
